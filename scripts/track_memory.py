#!/usr/bin/env python3


import time
import argparse
import json
import datetime
import psutil


def to_human(byte_size: int) -> str:
    suffix_to_divisor = {
        "KiB" : 1024,
        "MiB" : 1024 ** 2,
        "GiB" : 1024 ** 3,
        "TiB" : 1024 ** 4,
    }
    for suffix, divisor in sorted(suffix_to_divisor.items(), key=lambda kv: kv[1], reverse=True):
        if byte_size // divisor >= 1:
            return f"{round(byte_size / divisor)}{suffix}"
    return f"{byte_size}B"


assert to_human(0) == "0B"
assert to_human(1) == "1B"
assert to_human(1023) == "1023B"
assert to_human(1024) == "1KiB"
assert to_human(2047) == "2KiB"
assert to_human(1024**2) == "1MiB"
assert to_human(1024**2 - 1) == "1024KiB"


def main():
    parser = argparse.ArgumentParser(
        description="""
            Example usages:
            ./track_memory.py --pid 42 >process_log.json
            ./track_memory.py --name nvim >process_log.json
            ./track_memory.py --name tmux --interval 0.5 >process_log.json
        """,
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )

    parser.add_argument(
        "--interval",
        action="store",
        type=float,
        dest="interval",
        default=1.0,
        help="time interval for probing the memory",
    )
    parser.add_argument("pid_or_name", type=str)

    group = parser.add_mutually_exclusive_group()
    group.add_argument(
        "--pid",
        action="store_true",
        dest="pid",
        help="use pid to find a process to track",
    )
    group.add_argument(
        "--name",
        action="store_true",
        dest="name",
        help="name of a process to track",
    )
    args = parser.parse_args()

    if args.pid:
        pid = int(args.pid_or_name)
        matching_procs = [proc for proc in psutil.process_iter() if proc.pid == pid]
    elif args.name:
        name = str(args.pid_or_name)
        matching_procs = [proc for proc in psutil.process_iter() if name in proc.name()]
    else:
        raise Exception("You should specify either --pid or --name option")

    match matching_procs:
        case [proc]:
            result = {}
            try:
                start = datetime.datetime.now()
                while True:
                    # if proc.
                    with proc.oneshot():
                        # NOTE: indices were taken from official psutil documentation
                        time_diff = datetime.datetime.now() - start
                        result[f"{time_diff.seconds}.{time_diff.microseconds // 1000:03d}"] = {
                            "memory_info": {
                                "rss": to_human(proc.memory_info()[0]),
                                "vms": to_human(proc.memory_info()[1]),
                            },
                            "cpu_usage_user_seconds": proc.cpu_times()[0],
                        }
                    time.sleep(args.interval)
            finally:
                # also works when the process is terminated via KeyboardInterrupt
                print(json.dumps(result, indent=4))
        case []:
            raise Exception(f"No matches found for {args.pid_or_name}")
        case _:
            raise Exception(f"Multiple matches found for {args.pid_or_name}: {matching_procs}")


if __name__ == '__main__':
    main()
