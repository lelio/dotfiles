
#
# /etc/bash.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

BLACK='\[\033[0;30m\]'
DGRAY='\[\033[1;30m\]'
RED='\[\033[0;31m\]'
LRED='\[\033[1;31m\]'
GREEN='\[\033[0;32m\]'
LGREEN='\[\033[1;32m\]'
BROWN='\[\033[0;33m\]'
YELLOW='\[\033[1;33m\]'
BLUE='\[\033[0;34m\]'
LBLUE='\[\033[1;34m\]'
PURPLE='\[\033[0;35m\]'
LPURPLE='\[\033[1;35m\]'
CYAN='\[\033[0;36m\]'
LCYAN='\[\033[1;36m\]'
LGRAY='\[\033[0;37m\]'
WHITE='\[\033[1;37m\]'
NORMAL='\[\033[0m\]'
#$PS1='[\u@\h \W]\$ '
#PS1="┌─[\[\e[34m\]\h\[\e[0m\]][\[\e[32m\]\w\[\e[0m\]]\n└─╼ "
#     ┌─[                     ][                     ]  └─╼ 
	if [[ ${EUID} == 0 ]] ; then
		PS1="\[$RED\]┌[\[$RED\]\[\e[34m\]\h\[\e[0m\]\[$RED\]][\[$RED\]\[\e[32m\]\w\[$RED\]]\[$RED\]\n\[$RED\]└─#\[$RED\] "
	else
		PS1="┌[\[\e[34m\]\h\[\e[0m\]][\[\e[32m\]\w\[\e[0m\]]\n└─$ "
	fi      #    ┌[                     ][                     ]  └─$ 

PS2='> '
PS3='> '
PS4='+ '

case ${TERM} in
  xterm*|rxvt*|Eterm|aterm|kterm|gnome*)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
                                                        
    ;;
  screen)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
    ;;
esac

# enable bash completion in interactive shells
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

[ -r /etc/bash_completion   ] && . /etc/bash_completion
# Check for an interactive session
[ -z "$PS1" ] && return

if [ -d ~/bin ] ; then
PATH=~/bin:"${PATH}"
fi

alias ls='ls --color=auto'

man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;37m") \
		LESS_TERMCAP_md=$(printf "\e[1;37m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;47;30m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[0;36m") \
			man "$@"
}

export EDITOR="vim"
export EDITOR=vim
export PAGER="less"
set -o vi
set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after  #that's for fetching the vim-latex files

## The order matters: due to the dot, the computer will first search the current directory 
## (i.e., wherever your TeX/LaTeX source file is); then it searches in the subdirectory TeX/inputs 
## inside your account (but it won't go searching through any tree below there); then it searches TeX/funpackage; 
## finally, due to the colon at the end, it will search all the usual places it would have searched if you hadn't 
## declared TEXINPUTS at all. 
#declare -x TEXINPUTS=.:$HOME/TeX/inputs:$HOME/TeX/funpackage:

alias ll="ls -l --group-directories-first"
alias ls='ls -hF --color'  # add colors for filetype recognition
alias la='ls -Al'          # show hidden files
alias lx='ls -lXB'         # sort by extension
alias lk='ls -lSr'         # sort by size, biggest last
alias lc='ls -ltcr'        # sort by and show change time, most recent last
alias lu='ls -ltur'        # sort by and show access time, most recent last
alias lt='ls -ltr'         # sort by date, most recent last
alias lm='ls -al |more'    # pipe through 'more'
alias lr='ls -lR'          # recursive ls
alias tree='tree -Csu'     # nice alternative to 'recursive ls'

#alias du='du -kh'     # This makes a more readable output
alias du='cdu -idh'    # Color Perl wrapper
alias df='df -kTh'

#alias urxvtc-nondrop='urxvtc -fn "xft:terminus:pixelsize=12" -bg rgba:0000/0000/0000/bbbb"'

alias lowriter='GTK2_RC_FILES=~/.gtkrc-2.0-loffice libreoffice'
alias lowriter='GTK2_RC_FILES=~/.gtkrc-2.0-loffice soffice'
alias lowriter='GTK2_RC_FILES=~/.gtkrc-2.0-loffice ooffice'
alias lowriter='GTK2_RC_FILES=~/.gtkrc-2.0-loffice lowriter'
alias localc='GTK2_RC_FILES=~/.gtkrc-2.0-loffice localc'
alias lobase='GTK2_RC_FILES=~/.gtkrc-2.0-loffice lobase'
alias lodraw='GTK2_RC_FILES=~/.gtkrc-2.0-loffice lodraw'
alias lomath='GTK2_RC_FILES=~/.gtkrc-2.0-loffice lomath'
alias loimpress='GTK2_RC_FILES=~/.gtkrc-2.0-loffice loimpress'

alias umb='umount -v /dev/sdb1'
alias umc='umount -v /dev/sdc1'

alias latin='words'

alias vi='vim'
alias more='less'
alias svim='sudo vim'
alias e='emacsclient -nw'
alias r='ranger'
alias se='sudo emacsclient -nw'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias md='mkdir -p'
alias ..='cd ..'
alias cdd='cd -'
alias syu='pacman -Syyu'
alias S='pacman -S'
alias rsn='pacman -Rsn'
alias y='yaourt'
alias aur='yaourt -Syyu --aur'
alias devel='yaourt -Syu --devel'
alias grep='grep --colour=auto'
alias ^L='clear'
alias l='clear'
#alias synctime='sudo ~/bin/synctime.sh'

	#----------------------------------------
	# File & string-related functions, and various functions generally
	#----------------------------------------

	## Find a file with a pattern in name:
	#function ff() { find . -type f -iname '*'$*'*' -ls ; }
	#
	## Find a file with pattern $1 in name and Execute $2 on it:
	#function fe()
	#{ find . -type f -iname '*'${1:-}'*' -exec ${2:-file} {} \;  ; }
	#
	## Find a pattern in a set of files and highlight them:
	## (needs a recent version of egrep)
	#function fstr()
	#{
	#    OPTIND=1
	#    local case=""
	#    local usage="fstr: find string in files.
	#Usage: fstr [-i] \"pattern\" [\"filename pattern\"] "
	#    while getopts :it opt
	#    do
	#        case "$opt" in
	#        i) case="-i " ;;
	#        *) echo "$usage"; return;;
	#        esac
	#    done
	#    shift $(( $OPTIND - 1 ))
	#    if [ "$#" -lt 1 ]; then
	#        echo "$usage"
	#        return;
	#    fi
	#    find . -type f -name "${2:-*}" -print0 | \
	#    xargs -0 egrep --color=always -sn ${case} "$1" 2>&- | more 
	#
	#}
	#
	#function cuttail() # cut last n lines in file, 10 by default
	#{
	#    nlines=${2:-10}
	#    sed -n -e :a -e "1,${nlines}!{P;N;D;};N;ba" $1
	#}
	#
	#function lowercase()  # move filenames to lowercase
	#{
	#    for file ; do
	#        filename=${file##*/}
	#        case "$filename" in
	#        */*) dirname==${file%/*} ;;
	#        *) dirname=.;;
	#        esac
	#        nf=$(echo $filename | tr A-Z a-z)
	#        newname="${dirname}/${nf}"
	#        if [ "$nf" != "$filename" ]; then
	#            mv "$file" "$newname"
	#            echo "lowercase: $file --> $newname"
	#        else
	#            echo "lowercase: $file not changed."
	#        fi
	#    done
	#}
	#
	#
	#function swap()  # Swap 2 filenames around, if they exist
	#{                #(from Uzi's bashrc).
	#    local TMPFILE=tmp.$$ 
	#
	#    [ $# -ne 2 ] && echo "swap: 2 arguments needed" && return 1
	#    [ ! -e $1 ] && echo "swap: $1 does not exist" && return 1
	#    [ ! -e $2 ] && echo "swap: $2 does not exist" && return 1
	#
	#    mv "$1" $TMPFILE 
	#    mv "$2" "$1"
	#    mv $TMPFILE "$2"
	#}

	pacman() {
	   case $1 in
	       -S | -S[^sih]* | -R* | -U*)
		   /usr/bin/sudo /usr/bin/pacman "$@" ;;
	       *)
		   /usr/bin/pacman "$@" ;;
	   esac
	}

	tk() {
		mkdir $1
		cd $1
	}

alias kt='tk'
#----------------------------------------

fortune cs


export PERL_LOCAL_LIB_ROOT="/home/lelio/perl5";
export PERL_MB_OPT="--install_base /home/lelio/perl5";
export PERL_MM_OPT="INSTALL_BASE=/home/lelio/perl5";
export PERL5LIB="/home/lelio/perl5/lib/perl5/x86_64-linux-thread-multi:/home/lelio/perl5/lib/perl5";
export PATH="/home/lelio/perl5/bin:$PATH";
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'
