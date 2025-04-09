# Neovim
- linux x64 - appimage
- linux aarch64 - build from source (git clone + `make
  CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=$HOME/.local` + make
  install). arm64 appimage is buggy since it links to libc 2.38, that isn't bundled in
  appimage
- macos (x64 & aarch64) - `brew install nvim` or something like that (the brew
  version is quite recent)

