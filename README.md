# Utils

Utils is a collection of config files and scripts that I've written
and collected over the years.

> [!WARNING]
> Some of these files were **NOT** tested enough to my standards. I've noted the files you should be careful with in the files list below.

## Included files

### Config files

1. **.vimrc**: I did _not_ write this. I downloaded this years ago, and unfortunately, I've lost the name of the original author.
1. **.zshrc**: Customises the ZSH environment (prompt design, extensions, &c.) to my liking.
2. **Microsoft.PowerShell_profile.ps1**: [_NOTE: `gcm` (`git commit -m`) requires `Remove-Alias`, which PowerShell 6.0+._] Customises PowerShell in my Windows systems.

### Scripts

1. **compi**: Automatically compresses image into different levels. Featured in [Automated Image Compression for Web Development with Python](https://gist.github.com/noahdominic/3c4853bc5b41ff3389b12717caed7f0e).
1. **compv**: Automatically compresses videos for low data transfers. See docs in file.
1. **journey**: Submodule to [Journey](https://github.com/noahdominic/journey), a BASH-enabled journal/diary system.
1. **erase-all-forge-keybindings.sh**†: Deletes all the keybinding for the Forge extension on GNOME. This one is niche, imo.
1. **extractall**†: Extract all compressed packages into their own directories. I've only used this for extracting arrays of IMG files (this is how a lot of retro software is packaged) on Linux.
1. **git-myinit**: Typical `git init` but it autoadds an ignore file.
1. **git-rebaseall**‡: Rebase multiple branches into the current branch.
1. **git-update**: Fetches and prints the status
1. **json2csv**: Automatically converts JSONs to CSVs, if compatible. Really unstable.
1. **mkfile**: `touch` with support for directories
1. **ts2mp4**: Converts all TSs in the current directory and converts them to MP4.

> Notes:
>
> † Are not tested well enough for my standards.
>
> ‡ Tested well enough but still may produce unexpected results due to the use of wildcards. (My regex skills suck).

## Installation & Usage

### Installation

1. Copy with repo to your machine:

```bash
git clone https://github.com/noahdominic/utils.git
```

1. Done.

### Setting up git

1. Edit `setup-git.sh` to change my details to yours in the config params. If you're me, reader, you don't have to do this step.
1. Run `setup-git.sh`. You may need to enable execution permissions with `chmod +x setup-git.sh`.
1. Done.

### Setting up zsh

1. Run `setup-zsh.sh`. You may need to enable execution permissions with `chmod +x setup-zsh.sh`.
1. Done.

### Setting up scripts

1. Add the location of your local machine's copy of this repo, `scripts/`, and all subdirectories to your `PATH`. If you use zsh, this setting is already in .zshrc .

## Contributing

This repo is primarily maintained for personal use, and contributions are not actively sought. However, if you encounter issues or identify bugs, your corrections and bug fixes are welcomed and appreciated 😊

Thank you for understanding and contributing to the quality of this repository.

## Licence

`compi`, `compv`, `journal`, and any other file whose source code or directory contains a notice indicating it to be so, are licensed under the European Union Public Licence v1.2.

Unless indicated to not be the case, this repo's files are licensed under the BSD Licence 2.0 ('3-clause BSD Licence', 'Revised BSD Licence', 'New BSD Licence', or 'Modified BSD Licence').
