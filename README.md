# Vim Configuration

This repository stores my vim config files :-)

## Install

```sh
./install.sh -i
```

Use `-p` for pretend (dry-run) mode: `./install.sh -p -i`

## Uninstall

```sh
./install.sh -u
```

## LSP Dependencies

coc.nvim provides LSP support. The following language servers need to be
installed separately:

- **C/C++**: `clangd` (install matching version with your `clang`, e.g. `sudo apt install clangd-18`)
- **Python**: `pyright` (installed automatically by coc-pyright via npm)
- **Rust**: `rust-analyzer` (install via `rustup component add rust-analyzer`)
