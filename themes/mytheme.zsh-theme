# http://qiita.com/takc923/items/c479e38112b913b7614a
# this theme depends on git plugin.

function str_with_color() {
    echo "%{$fg[$1]%}$2%{$reset_color%}"
}

ZSH_THEME_GIT_PROMPT_ADDED=$(str_with_color cyan '+')
ZSH_THEME_GIT_PROMPT_MODIFIED=$(str_with_color yellow '*')
ZSH_THEME_GIT_PROMPT_DELETED=$(str_with_color red 'x')
ZSH_THEME_GIT_PROMPT_RENAMED=$(str_with_color blue 'o')
ZSH_THEME_GIT_PROMPT_UNMERGED=$(str_with_color magenta '!')
ZSH_THEME_GIT_PROMPT_UNTRACKED=$(str_with_color grey '?')

function my_git_status() {
    [ $(current_branch) ] && echo "($(current_branch)$(git_prompt_status))"
}

DATE_TIME=$(str_with_color yellow '%D{%Y-%m-%d %K:%M}')
PROMPT_PREFIX=$(str_with_color white '#')
SEPARATOR1=$(str_with_color white '|')
USER_NAME=$(str_with_color blue '%n')
SEPARATOR2=$(str_with_color white '@')
HOST_NAME=$(str_with_color cyan '%m')
SEPARATOR3=$(str_with_color white ':')
CURRENT_DIRECTORY=$(str_with_color green '%~')
PROMPT_CHAR=$(str_with_color white '$ ')
PROMPT='${PROMPT_PREFIX}${DATE_TIME}${SEPARATOR1}${USER_NAME}${SEPARATOR2}${HOST_NAME}${SEPARATOR3}${CURRENT_DIRECTORY} $(my_git_status)
$PROMPT_CHAR'
PROMPT2=$(str_with_color white '> ')
