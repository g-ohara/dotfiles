# .config/nvim/lua/filetype

Specific configurations for different file types.

## Files

### `c.lua`

C/C++ configurations.

- Language server: [clangd](https://clangd.llvm.org/)

### `haskell.lua`

Haskell configurations.

- Language server: [Haskell Language Server](https://github.com/haskell/haskell-language-server)
- Formatter: [fourmolu](https://github.com/fourmolu/fourmolu)

### `lua.lua`

Lua configurations.

- Language server: [lua-language-server](https://github.com/sumneko/lua-language-server)

### `python.lua`

Python configurations.

- Language server: [pyright](https://github.com/microsoft/pyright)
- Formatter: `rye fmt`
- Column lines: at 72 and 79 characters
- Indentation: 4 spaces

### `sh.lua`

Shell configurations.

- Language server: [bash-language-server](https://github.com/bash-lsp/bash-language-server)
- Formatter: [shfmt](https://github.com/mvdan/sh#shfmt)

### `tex.lua`

LaTeX configurations.

- Language server: [texlab](https://github.com/latex-lsp/texlab)
- Linter: [ChkTeX](https://www.nongnu.org/chktex/)
- Formatter: [latexindent](https://github.com/cmhughes/latexindent.pl)

### `typescript.lua`

TypeScript configurations.

- Language server: [TypeScript Language Server](https://github.com/typescript-language-server/typescript-language-server)
