# .phoenix

<p align="center">
	<a href="https://github.com/thuvasooriya/.phoenix/stargazers">
		<img alt="stargazers" src="https://img.shields.io/github/stars/thuvasooriya/.phoenix?style=for-the-badge&logo=starship&color=C9CBFF&logoColor=D9E0EE&labelColor=302D41"></a>
    <a href="https://nixos.org/">
        <img src="https://img.shields.io/badge/NixOS-24.05-informational.svg?style=for-the-badge&logo=nixos&color=F2CDCD&logoColor=D9E0EE&labelColor=302D41"></a>
</p>

**nix** config to be reborn again and again anywhere and everywhere.

apart from the sexy name, this config is ~nowhere~ near useable. i'm currently testing it on my macbook with apple silicon and some of my cute little linux machines which are also aarch64. so i don't think this is the phoe**nix** that i want it to be yet, but i mean... when is a child ever what you want to be... _slaps in the forhead_

## install

```sh
curl https://raw.githubusercontent.com/thuvasooriya/phoenix/main/naive | sudo bash -s -- netinstall
```

or

```sh
git clone https://github.com/thuvasooriya/phoenix && cd phoenix
sudo ./naive install
```
```sh
./naive uporb # for orbstack
```

## upgrade

```bash
./naive update
./naive upgrade
./naive uporb # for orbstack
```
> [!NOTE]
>
> use `sudo -i nix-env --uninstall nix` to uinstall deterministic-installer installed nix in macos

> [!WARNING]
>
> **Fallback does not support advanced terminal features.** Because
> `xterm-256color` does not include all of Ghostty's capabilities, terminal
> features beyond xterm's like colored and styled underlines will not work.

## focus

- [ ] rosetta in parallels
- [ ] devenv for rocket-chip
- [ ] fix github auth for commits on linux
- [ ] fix ghostty issues in orbstack ssh
- [ ] rpi4b config: yuji
- [ ] opi02w config: shoko
- [ ] automate manual steps
    - [ ] ssh copy
    - [ ] github auth
    - [ ] shell history
- [x] zig overlay setup
- [x] basic fish and starship setup
- [x] porting my starship and fish goodies to nix
- [x] transferred all homebrew casks
- [x] initial nvim config with partial determinism


## sacrifices

> [what y'all will need when nix drives you to drink.](https://www.youtube.com/watch?v=Eni9PPPPBpg)
> (copy from ryan4yin's nix-config repo, when i pulled an all nighter to finish the damn restructuring, this thing really held me togeather)

- [x] my sanity
- [x] willingness to install software in any other way
- [x] any remaining love for other package managers

## gracefully yoinked from
- [wegank's config](https://github.com/wegank/nixos-config) : went for parallels vm setup but config structure was in my taste so ...
- [sempruijs' config](https://github.com/sempruijs/nixos-config) : got some orbstack setup
- [ryan's godicle](https://github.com/ryan4yin/nix-config) : initial sufferings
- [malob's config](https://github.com/malob/nixpkgs)
- [paul's system?](https://github.com/PaulGrandperrin/nix-systems)
