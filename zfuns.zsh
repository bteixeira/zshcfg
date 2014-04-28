function mkcd() {
  mkdir -p $1
  cd $1
}

man() {
      env \
      	  LESS_TERMCAP_mb=$(printf "\e[1;31m") \
	  LESS_TERMCAP_md=$(printf "\e[1;31m") \
	  LESS_TERMCAP_me=$(printf "\e[0m") \
	  LESS_TERMCAP_se=$(printf "\e[0m") \
	  LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
	  LESS_TERMCAP_ue=$(printf "\e[0m") \
	  LESS_TERMCAP_us=$(printf "\e[1;32m") \
	  			   man "$@"
}
# http://unix.stackexchange.com/questions/119/colors-in-man-pages

# not working, but a good idea
function copydir {
  pwd | tr -d "\r\n" | pbcopy
}
function copyfile {
  [[ "$#" != 1 ]] && return 1
  local file_to_copy=$1
  cat $file_to_copy | pbcopy
}




#Show progress while file is copying

# Rsync options are:
#  -p - preserve permissions
#  -o - preserve owner
#  -g - preserve group
#  -h - output in human-readable format
#  --progress - display progress
#  -b - instead of just overwriting an existing file, save the original
#  --backup-dir=/tmp/rsync - move backup copies to "/tmp/rsync"
#  -e /dev/null - only work on local files
#  -- - everything after this is an argument, even if it looks like an option

alias cpv="rsync -poghb --backup-dir=/tmp/rsync -e /dev/null --progress --"





# another good one: shortcut to navigate dirs stack
##
# dircycle plugin: enables cycling through the directory
# stack using Ctrl+Shift+Left/Right

eval "insert-cycledleft () { zle push-line; LBUFFER='pushd -q +1'; zle accept-line }"
zle -N insert-cycledleft
bindkey "\e[1;6D" insert-cycledleft
eval "insert-cycledright () { zle push-line; LBUFFER='pushd -q -0'; zle accept-line }"
zle -N insert-cycledright
bindkey "\e[1;6C" insert-cycledright


#useful omz plugin: dirpersist -- keeps dirs stack between sessions


# ------------------------------------------------------------------------------
#          FILE: emoji-clock.plugin.zsh
#   DESCRIPTION: The current time with half hour accuracy as an emoji symbol.
#                Inspired by Andre Torrez' "Put A Burger In Your Shell"
#                http://notes.torrez.org/2013/04/put-a-burger-in-your-shell.html
#        AUTHOR: Alexis Hildebrandt (afh[at]surryhill.net)
#       VERSION: 1.0.0
# -----------------------------------------------------------------------------


## put this next to the time? kinda wasteful but it looks cute
function emoji-clock() {
  hour=$(date '+%I')
  minutes=$(date '+%M')
  case $hour in
    01) clock="🕐"; [ $minutes -ge 30 ] && clock="🕜";;
    02) clock="🕑"; [ $minutes -ge 30 ] && clock="🕝";;
    03) clock="🕒"; [ $minutes -ge 30 ] && clock="🕞";;
    04) clock="🕓"; [ $minutes -ge 30 ] && clock="🕟";;
    05) clock="🕔"; [ $minutes -ge 30 ] && clock="🕠";;
    06) clock="🕕"; [ $minutes -ge 30 ] && clock="🕡";;
    07) clock="🕖"; [ $minutes -ge 30 ] && clock="🕢";;
    08) clock="🕗"; [ $minutes -ge 30 ] && clock="🕣";;
    09) clock="🕘"; [ $minutes -ge 30 ] && clock="🕤";;
    10) clock="🕙"; [ $minutes -ge 30 ] && clock="🕥";;
    11) clock="🕚"; [ $minutes -ge 30 ] && clock="🕦";;
    12) clock="🕛"; [ $minutes -ge 30 ] && clock="🕧";;
     *) clock="⌛";;
  esac
  echo $clock
}


## dont forget to check git plugin in omz (and also all other git related plugins)


# Easily jump around the file system by manually adding marks
# marks are stored as symbolic links in the directory $MARKPATH (default $HOME/.marks)
#
# jump FOO: jump to a mark named FOO
# mark FOO: create a mark named FOO
# unmark FOO: delete a mark
# marks: lists all marks

# dont forget to check mvn plugin

# check npm plugin which calls "npm completion"

# nvm plugin

# there is a per-directory history plugin, might be interesting for some dirs

# random-quote plugin: a litle like fortune. again, wasteful but cute?

# safe paste plugin -- changes keymap while pasting to avoid unwanted behaviour

# svn plugin might still be useful sometimes. maybe copy the omz plugin directly so not to waste time with it

# check out the sys admin plugin

# check out url tools plugin

# check the Z plugin

# get the name of the branch we are on
function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

# Checks if working tree is dirty
parse_git_dirty() {
  local SUBMODULE_SYNTAX=''
  local GIT_STATUS=''
  local CLEAN_MESSAGE='nothing to commit (working directory clean)'
  if [[ "$(git config --get oh-my-zsh.hide-status)" != "1" ]]; then
    if [[ $POST_1_7_2_GIT -gt 0 ]]; then
          SUBMODULE_SYNTAX="--ignore-submodules=dirty"
    fi
    if [[ "$DISABLE_UNTRACKED_FILES_DIRTY" != "true" ]]; then
        GIT_STATUS=$(git status -s ${SUBMODULE_SYNTAX} 2> /dev/null | tail -n1)
    else
        GIT_STATUS=$(git status -s ${SUBMODULE_SYNTAX} -uno 2> /dev/null | tail -n1)
    fi
    if [[ -n $(git status -s ${SUBMODULE_SYNTAX} -uno  2> /dev/null) ]]; then
      echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
    else
      echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
    fi
  else
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}

