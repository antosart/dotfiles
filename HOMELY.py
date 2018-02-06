# ~/dotfiles/HOMELY.py

from homely.files import mkdir
from homely.files import symlink
from homely.install import installpkg
import os

installpkg('source-highlight')

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
symlink('emacs/melpa', '~/.emacs.d/melpa')
symlink('emacs/helm', '~/.emacs.d/helm')

mkdir('~/.i3')
symlink('i3/config', '~/.i3/config')
symlink('i3/ipy3status.py', '~/.i3/ipy3status.py')
symlink('i3/exit_menu.sh', '~/.i3/exit_menu.sh')

mkdir('~/bin')
for entry in os.scandir(os.environ['HOME'] + '/dotfiles/bin'):
    if entry.is_file():
        symlink('bin/' + entry.name,
                '~/bin/' + entry.name)
