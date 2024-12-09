import pynvim
from pathlib import Path
from os import walk
from datetime import datetime
import difflib
import dataclasses
from typing import *
import functools


# Taken from: https://en.wikibooks.org/wiki/Algorithm_Implementation/Strings/Levenshtein_distance#Python
def levenshtein(s1, s2):
    if len(s1) < len(s2):
        return levenshtein(s2, s1)

    # len(s1) >= len(s2)
    if len(s2) == 0:
        return len(s1)

    previous_row = range(len(s2) + 1)
    for i, c1 in enumerate(s1):
        current_row = [i + 1]
        for j, c2 in enumerate(s2):
            insertions = previous_row[j + 1] + 1  # j+1 instead of j since previous_row and current_row are one character longer
            deletions = current_row[j] + 1       # than s2
            substitutions = previous_row[j] + (c1 != c2)
            current_row.append(min(insertions, deletions, substitutions))
        previous_row = current_row
    return previous_row[-1]


@dataclasses.dataclass(frozen=True)
class RankPair:
    rank: float
    contents: str

    def __str__(self):
        return f"Score: {self.rank:.3f} Item: {self.contents}"


@dataclasses.dataclass
class Haystack:
    items: Set[str] = dataclasses.field(default_factory=set)

    def add_item(self, item: str):
        self.items.add(item)

    def is_cold(self) -> bool:
        return len(self.items) == 0

    def __hash__(self) -> int:
        return id(self)

    @functools.lru_cache
    def get_ranked(self, needle: str, max_items: int = 5) -> List[RankPair]:
        ranked = [RankPair(1 / levenshtein(needle, item), item) for item in self.items]
        ranked.sort(key=lambda x: x.rank, reverse=True)
        return ranked[:min(len(ranked), max_items)]


@pynvim.plugin
class Ahmad1337Helpers(object):

    def __init__(self, nvim: pynvim.Nvim):
        self.nvim = nvim
        self.proto_cache = Haystack()

    def ensure_warm_cache(self, root: Path):
        # TODO: add cache for `switch`
        if self.proto_cache.is_cold():
            # TODO: replace '.' with path to proto files
            for dirpath, _, filenames in walk(root / '.'):
                for filename in filenames:
                    if filename.endswith('proto'):
                        self.proto_cache.add_item(str(Path(dirpath, filename).absolute()))

    @pynvim.command('Link', nargs='*', sync=True)
    def link(self, args):
        line = self.nvim.command_output("echo line('.')").strip()
        full_file_name = self.nvim.command_output("echo expand('%:p')").strip()
        self.nvim.command(f"echo 'Link to file: {full_file_name}:{line}'")

    @pynvim.command('Switch', nargs='*', sync=True)
    def switch(self, args, sync=True):
        start_time = datetime.now()

        absolute_path: str = self.nvim.call('expand', '%:p')
        before_include, after_include = absolute_path.rsplit(sep="/include/", maxsplit=1)
        root = Path(before_include)
        needle = after_include
        haystack: List[tuple[int, str]] = list()
        # TODO: replace '.' with path to exclusively source files
        for dirpath, _, filenames in walk(root / '.'):
            for file in filenames:
                full_path = Path(dirpath, file)
                if full_path.suffix in ['.cpp', 'cc']:
                    haystack.append(
                        (
                            levenshtein(needle, str(full_path.relative_to(root))),
                            str(full_path),
                        )
                    )

        ranked = sorted(haystack)[:min(5, len(haystack))]
        ranked_strs = [
            f"{i+1}: Score: {1 / dist:.3f} Path: {path}"
            for i, (dist, path) in enumerate(ranked)
        ]

        end_time = datetime.now()
        elapsed = (end_time - start_time).total_seconds()

        chosen_file = self.nvim.call(
            "inputlist",
            [
                f'Select the file ({elapsed:.3f}s elapsed)',
                *ranked_strs,
            ]
        )
        self.nvim.command("redraw")
        try:
            chosen_file = int(chosen_file)
            if chosen_file < 1 or chosen_file > len(ranked):
                raise Exception("Out of bounds")
            self.nvim.command(f"edit {ranked[chosen_file-1][1]}")
        except Exception:
            self.nvim.command("echo 'No such file :('")

    @pynvim.command('ToProto', nargs='*', sync=True)
    def to_proto(self, args, sync=True):
        # class_name = self.nvim.command_output("echo expand('<cword>')").strip()
        full_file_name = self.nvim.command_output("echo expand('%:p')").strip()
        root = None
        for parent in Path(full_file_name).parents:
            # TODO: may replace .git with whatever the root marker is
            if (parent / '.git').exists():
                root = parent
                break

        if root is None:
            raise Exception("Couldn't locate project root :(")

        start_time = datetime.now()

        self.ensure_warm_cache(root)

        ranked = self.proto_cache.get_ranked(full_file_name, max_items=5)
        ranked_strs = [
            f"{i+1}: {str(item)}"
            for i, item in enumerate(ranked)
        ]

        end_time = datetime.now()
        elapsed = (end_time - start_time).total_seconds()

        chosen_file = self.nvim.call(
            "inputlist",
            [
                f'Select the file ({elapsed:.3f}s elapsed)',
                *ranked_strs,
            ]
        )
        self.nvim.command("redraw")
        try:
            chosen_file = int(chosen_file)
            if chosen_file < 1 or chosen_file > len(ranked):
                raise Exception("Out of bounds")
            self.nvim.command(f"edit {ranked[chosen_file-1].contents}")
        except Exception:
            self.nvim.command("echo 'No such file :('")
