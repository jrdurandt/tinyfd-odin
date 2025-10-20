# tinyfd

[Odin](https://odin-lang.org/) bindings for [tinyfiledialogs](https://sourceforge.net/projects/tinyfiledialogs/)

## Build:

Requires [zig 0.14.0]() to build cross-platform

Pull submodules `git submodule update --init --recursive`

Native: `zig build`

Linux: `zig build -Dtarget=x86_64-linux`

Windows: `zig build -Dtarget=x86_64-windows`

macOS (Darwin): `zig build -Dtarget=x86_64-macos` `zig build -Dtarget=aarch64-macos`

## Usage

```
import "tinyfd"

tinyfd.beep()

```

Please see official source of tinyfiledialogs: https://sourceforge.net/projects/tinyfiledialogs/
