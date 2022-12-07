# Nvim
---
This repo contains my peesonal configuration files for **Neovim** written in Lua.<BR>
This repo was created following this template [nvim-basic-ide](https://github.com/LunarVim/nvim-basic-ide) and [this playlist](https://www.youtube.com/playlist?list=PLhoH5vyxr6Qq41NFL4GvhFp-WLd5xzIzZ)

This config is built over **Neovim v0.8+** and have no commit pinned, so you can have to manage breaking changes

To use this conifg files run the following:

```bash
git clone --dept 1 https://github.com/mamaraddio/nvim ~/.config/nvim
```

You'll need to restart **Neovim** a couple of time in order to insattl all the plugins

## Requirements:
### arch based systems
```sh
pacman -Sy xsel node npm yarn
```
### debian/ubuntu based systems
```sh
apt update 
apt install xsel node npm yarn
```
If you are on **wayland** replace _xsel_ with [wayclip](https://github.com/noocsharp/wayclip)

### python deps
```sh
pip install pynvim
```

### node deps
```sh
npm i -g neovim
```

## Fonts

`ttf-dejavu` `fira code nerd font` or patch your preferred font with [nerd-fonts](https://github.com/ryanoasis/nerd-fonts#option-9-patch-your-own-font)

