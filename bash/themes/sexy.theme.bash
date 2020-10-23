# Sexy Bash Prompt, inspired by "Extravagant Zsh Prompt"
# Screenshot: http://cloud.gf3.ca/M5rG
# A big thanks to \amethyst on Freenode

VIRTUALENV_THEME_PROMPT_PREFIX='('
VIRTUALENV_THEME_PROMPT_SUFFIX=') '
PYTHON_THEME_PROMPT_PREFIX='('
PYTHON_THEME_PROMPT_SUFFIX=')'
NODE_THEME_PROMPT_PREFIX='('
NODE_THEME_PROMPT_SUFFIX=')'
SCM_THEME_PROMPT_PREFIX=' ('
SCM_THEME_PROMPT_SUFFIX=')'
SCM_GIT_SHOW_DETAILS=true
SCM_GIT_IGNORE_UNTRACKED=false

#if [[ $COLORTERM = gnome-* && $TERM = xterm ]]  && infocmp gnome-256color >/dev/null 2>&1; then export TERM=gnome-256color
#elif [[ $TERM != dumb ]] && infocmp xterm-256color >/dev/null 2>&1; then export TERM=xterm-256color
#fi
if [[ $TERM != dumb ]] && infocmp xterm-256color >/dev/null 2>&1; then export TERM=xterm-256color
fi

if tput setaf 1 &> /dev/null; then
    MAGENTA=$(tput setaf 5)
    ORANGE=$(tput setaf 4)
    GREEN=$(tput setaf 2)
    PURPLE=$(tput setaf 1)
    WHITE=$(tput setaf 7)
    BOLD=$(tput bold)
    RESET=$(tput sgr0)
else
        echo "else"
    MAGENTA="\033[1;31m"
    ORANGE="\033[1;33m"
    GREEN="\033[1;32m"
    PURPLE="\033[1;35m"
    WHITE="\033[1;37m"
    BOLD=""
    RESET="\033[m"
fi

parse_git_dirty () {
  [[ $(git status 2> /dev/null | tail -n1 | cut -c 1-17) != "nothing to commit" ]] && echo "*"
}
parse_git_branch () {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

function prompt_command() {
PS1="\n\[${BOLD}${MAGENTA}\]\u\[$WHITE\]@\[$ORANGE\]\h\[$WHITE\]:\[$GREEN\]\w\[$WHITE\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" \")\[$WHITE\]\$(scm_prompt_info) ${BOLD}${WHITE}$(py_interp_prompt) $(node_interp_prompt)\[$WHITE\]\n$(virtualenv_prompt) $(__docker_machine_ps1)\$ \[$RESET\]"
}

PROMPT_COMMAND=prompt_command
