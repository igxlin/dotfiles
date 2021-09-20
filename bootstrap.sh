#!/usr/bin/env bash

dotfiles_dir=$(cd -- "$(dirname ${BASH_SOURCE})" > /dev/null 2>&1; pwd -P)

remove_and_link () {
    for var in $@
    do
        if [ -L $HOME/$var ] && [ -e $HOME/$var ] && \
            [ "$(readlink -- $HOME/$var)" = "$dotfiles_dir/$var" ]; then
            continue
        fi

        rm -rf $HOME/$var
        ln -s $dotfiles_dir/$var $HOME/$var
        echo "Linked: $HOME/$var -> $dotfiles_dir/$var"
    done
}

link_all () {
    remove_and_link .ctags.d .mutt bin .aliases .macos \
        .mbsyncrc .msmtprc  .tmux.conf .urlview .zshrc \
        .vimrc .vim .path .functions
}

main () {
    if [ $# -eq 0 ] || [ $1 -eq 'all' ]; then
        link_all
        return
    fi

    remove_and_link $@
}

main $@

