# ~/dotfiles/HOMELY.py

from homely.files import mkdir
from homely.files import symlink
import os

symlink('git/gitignore', '~/.gitignore')
symlink('git/gitconfig', '~/.gitconfig')

symlink('zsh/zshenv', '~/.zshenv')
symlink('zsh/zshrc', '~/.zshrc')

symlink('emacs/emacs', '~/.emacs')
mkdir('~/.emacs.d')
for entry in os.scandir(os.environ['HOME'] + '/dotfiles/emacs'):
    if entry.name.startswith('config') and entry.is_file():
        symlink('emacs/' + entry.name,
                '~/.emacs.d/' + entry.name)

mkdir('~/.i3')
symlink('i3/config', '~/.i3/config')
symlink('i3/ipy3status.py', '~/.i3/ipy3status.py')

symlink('vimperator/vimperatorrc', '~/.vimperatorrc')
