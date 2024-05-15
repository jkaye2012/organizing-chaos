---
title: A Rust + WASM development environment with Nix
date: 2024-05-14
draft: false
tags:
  - nix
  - rust
  - wasm
---

{{<tagline>}}
Getting started with a new ecosystem can be difficult. Using Nix makes the solution reproducible!
{{</tagline>}}

I was recently following the [setup guide](https://rustwasm.github.io/docs/book/game-of-life/setup.html) for Rust and WebAssembly
and found more surprises than I was expecting while setting up the development environment using a [Nix Flake](https://nixos.wiki/wiki/Flakes).
As I've also been working towards a [personal repository of Flake templates](https://github.com/jkaye2012/flake-templates), I thought it might
help others to detail the issues that I encountered and how I solved them. It's as much about the process of debugging a new Flake environment
(and a new toolchain in general) as it is about the final state of the template!

This post assumes some basic familiarity with Nix and Flakes. I'm still relatively new to Nix, so if you notice anything in this post that you think is
incorrect, please [open an issue](https://github.com/jkaye2012/organizing-chaos/issues/new) so that I can fix it.

If you already know what you're doing and you're here looking to get started without the more in-depth explanation, you should be able to use the
[rust-wasm-project template](https://github.com/jkaye2012/flake-templates/tree/main/rust-wasm-project-template) via
`github:jkaye2012/flake-templates#rust-wasm-project`. More detailed instructions can be found in the [last section of the post](#bringing-it-all-together).

With the disclaimers out of the way, let's get started!

# Rust toolchains

The first step in setting up a development environment is installing dependencies (surprise!). We need the Rust toolchain,
`wasm-pack` (to build WebAssembly from Rust code), and `npm` (to manage web dependencies, build/run the site, etc). This is Nix, so dependency
installation should be the easy part:

```nix
{
  description = "Rust with WebAssembly";

  inputs = {
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, fenix, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          f = fenix.packages.${system};
        in
          {
            devShells.default =
              pkgs.mkShell {
                name = "rust-wasm-first-attempt";

                packages = with pkgs; [
                  f.stable.toolchain
                  nodejs_21
                  wasm-pack
                ];
              };
          }
      );
}
```

Unfortunately, this isn't quite the entire story. If we attempt to build the [wasm-pack template project](https://github.com/rustwasm/wasm-pack-template)
in this environment, the Rust build functions normally, but the WebAssembly portion fails loudly:

```sh
[jkaye@jkaye-nixos:~/test]$ nix develop
(nix:rust-wasm-first-attempt-env) [jkaye@jkaye-nixos:~/test]$ cargo build
   Compiling proc-macro2 v1.0.81
   Compiling unicode-ident v1.0.12
   Compiling wasm-bindgen-shared v0.2.92
   Compiling bumpalo v3.16.0
   Compiling log v0.4.21
   Compiling once_cell v1.19.0
   Compiling wasm-bindgen v0.2.92
   Compiling cfg-if v1.0.0
   Compiling quote v1.0.36
   Compiling syn v2.0.60
   Compiling wasm-bindgen-backend v0.2.92
   Compiling wasm-bindgen-macro-support v0.2.92
   Compiling wasm-bindgen-macro v0.2.92
   Compiling console_error_panic_hook v0.1.7
   Compiling replace-me v0.1.0 (/home/jkaye/test)

    Finished `dev` profile [unoptimized + debuginfo] target(s) in 10.34s
(nix:rust-wasm-first-attempt-env) [jkaye@jkaye-nixos:~/test]$ wasm-pack build
[INFO]: 🎯  Checking for the Wasm target...
Error: wasm32-unknown-unknown target not found in sysroot: "/nix/store/l7rmk66qn9hbdfd0190wqzdh2qfhyysr-rust-stable-2024-05-02"

Used rustc from the following path: "/nix/store/l7rmk66qn9hbdfd0190wqzdh2qfhyysr-rust-stable-2024-05-02/bin/rustc"
It looks like Rustup is not being used. For non-Rustup setups, the wasm32-unknown-unknown target needs to be installed manually. See https://rustwasm.github.io/wasm-pack/book/prerequisites/non-rustup-setups.html on how to do this.

Caused by: wasm32-unknown-unknown target not found in sysroot: "/nix/store/l7rmk66qn9hbdfd0190wqzdh2qfhyysr-rust-stable-2024-05-02"

Used rustc from the following path: "/nix/store/l7rmk66qn9hbdfd0190wqzdh2qfhyysr-rust-stable-2024-05-02/bin/rustc"
It looks like Rustup is not being used. For non-Rustup setups, the wasm32-unknown-unknown target needs to be installed manually. See https://rustwasm.github.io/wasm-pack/book/prerequisites/non-rustup-setups.html on how to do this.
```

This failure is because the Rust toolchain is being managed with Nix rather than with Rustup directly. The error message tells us how to solve this problem:
`the wasm32-unknown-unknown target needs to be installed manually`. The [Fenix documentation](https://github.com/nix-community/fenix) points to the `combine`
derivation, which allows for combining multiple Rust toolchain components into a single derivation that we can use. So, instead of relying directly upon
`stable.toolchain`, we instead must bring the `wasm32-unknown-unknown` component into the mix:

```nix
{
  description = "Rust with WebAssembly";

  inputs = {
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, fenix, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          f = with fenix.packages.${system}; combine [ # <-- change here
            stable.toolchain
            targets.wasm32-unknown-unknown.stable.rust-std
          ];
        in
          {
            devShells.default =
              pkgs.mkShell {
                name = "rust-wasm-second-attempt";

                packages = with pkgs; [
                  f # <-- change here
                  nodejs_21
                  wasm-pack
                ];
              };
          }
      );
}
```

If I hadn't read the Fenix documentation, it wouldn't have been so easy to solve this problem. Reading documentation is something that sounds simple
and obvious, but in my experience it's a rare skill. If you're finding yourself frustrated with a problem and can't find a solution to it, take a deep
breath and read the docs. A large portion of the time you'll find what you're looking for.

# Linking WASM

The WebAssembly toolchain is good to go! So what's next?

```sh
[jkaye@jkaye-nixos:~/test]$ nix develop
warning: Git tree '/home/jkaye/test' is dirty
(nix:rust-wasm-second-attempt-env) [jkaye@jkaye-nixos:~/test]$ wasm-pack build
[INFO]: 🎯  Checking for the Wasm target...
[INFO]: 🌀  Compiling to Wasm...
   Compiling cfg-if v1.0.0
   Compiling wasm-bindgen v0.2.92
   Compiling console_error_panic_hook v0.1.7
   Compiling replace-me v0.1.0 (/home/jkaye/test)

error: linking with `rust-lld` failed: exit status: 127
  |
  = note: Could not start dynamically linked executable: rust-lld
          NixOS cannot run dynamically linked executables intended for generic
          linux environments out of the box. For more information, see:
          https://nix.dev/permalink/stub-ld
          

error: could not compile `replace-me` (lib) due to 1 previous error; 1 warning emitted
Error: Compiling your crate to WebAssembly failed
Caused by: Compiling your crate to WebAssembly failed
Caused by: failed to execute `cargo build`: exited with exit status: 101
  full command: cd "/home/jkaye/test" && "cargo" "build" "--lib" "--release" "--target" "wasm32-unknown-unknown"
```

Linking issues! This was a new one for me on NixOS. Matklad has a
[great explanation](https://matklad.github.io/2022/03/14/rpath-or-why-lld-doesnt-work-on-nixos.html) of what's going on here;
however, I didn't love the idea of modifying the flags in the Cargo configuration because that wouldn't be reproducible for other
users. My solution was instead to modify Cargo's environment variables in the development environment:

```nix
{
  description = "Rust with WebAssembly";

  inputs = {
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, fenix, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          f = with fenix.packages.${system}; combine [
            stable.toolchain
            targets.wasm32-unknown-unknown.stable.rust-std
          ];
        in
          {
            devShells.default =
              pkgs.mkShell {
                name = "rust-wasm-final-attempt";

                packages = with pkgs; [
                  f
                  llvmPackages.bintools # <-- change here
                  nodejs_21
                  wasm-pack
                ];

                CARGO_TARGET_WASM32_UNKNOWN_UNKNOWN_LINKER = "lld"; # <-- change here
              };
          }
      );
}
```

I don't _think_ this modification is necessary on operating systems other than NixOS, but in my testing it also doesn't seem to
have any negative effects, so for now I'm happy with it. With this, we can now successfully build our WASM:

```sh
[jkaye@jkaye-nixos:~/test]$ nix develop
warning: Git tree '/home/jkaye/test' is dirty
(nix:rust-wasm-final-attempt-env) [jkaye@jkaye-nixos:~/test]$ wasm-pack build
[INFO]: 🎯  Checking for the Wasm target...
[INFO]: 🌀  Compiling to Wasm...
   Compiling cfg-if v1.0.0
   Compiling wasm-bindgen v0.2.92
   Compiling console_error_panic_hook v0.1.7
   Compiling replace-me v0.1.0 (/home/jkaye/test)

    Finished `release` profile [optimized] target(s) in 1.47s
[INFO]: ⬇️   Installing wasm-bindgen...
[INFO]: Optimizing wasm binaries with `wasm-opt`...
[INFO]: Optional fields missing from Cargo.toml: 'description', 'repository', and 'license'. These are not necessary, but recommended
[INFO]: ✨   Done in 1.92s
[INFO]: 📦   Your wasm pkg is ready to publish at /home/jkaye/test/pkg.

```

# Editor integrations

The final change is for quality of life more than anything. Fenix provides a Rust [LSP](https://microsoft.github.io/language-server-protocol/)
server, but for TypeScript, JS, HTML, and CSS editor support is still lacking. Of course, there are nixpkgs for this functionality, so fixing
this is the easiest change of all:

```nix
{
  description = "Rust with WebAssembly";

  inputs = {
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, fenix, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          f = with fenix.packages.${system}; combine [
            stable.toolchain
            targets.wasm32-unknown-unknown.stable.rust-std
          ];
        in
          {
            devShells.default =
              pkgs.mkShell {
                name = "rust-wasm-final-attempt";

                packages = with pkgs; [
                  f
                  llvmPackages.bintools
                  nodePackages.typescript-language-server # <-- change here
                  nodejs_21
                  vscode-langservers-extracted # <-- change here
                  wasm-pack
                ];

                CARGO_TARGET_WASM32_UNKNOWN_UNKNOWN_LINKER = "lld"; 
              };
          }
      );
}
```

You'll still have to configure your editor of choice to detect and integrate these language servers, but I don't think that choosing
an editor for someone is the right thing to do. So long as your editor is configured for LSP support in general (personally, I'm using
Neovim for this), things should "just work".

# Bringing it all together

The moral of the story is: when trying something new, don't let unexpected errors scare you away. The solution is often closer than you may think.

The easiest way to use all of this if you're just trying to get started with a new project is to use the template directly. These templates are
mostly for my personal use, but if you're okay with a small amount of drift, feel free to use them yourself. I've tried to make it about as easy
as possible to start a new project:

```sh
mkdir test && cd test
nix flake init -t github:jkaye2012/flake-templates#rust-wasm-project
git init && git add .
nix develop
wasm-pack build
cd www
npm install
npm run start
```

This assumes that you have Nix installed and Flakes enabled. If so, you should be off to the races! Browse to `localhost:8080` and your
site should be up and running. The slug `replace-me` can be replaced using `sed` or any other method of your choice to modify the project
name. This one-liner may be of use:

`find . -type f -exec sed -i'' s/replace-me/cool-project-name/g {} \;`

Happy hacking!

