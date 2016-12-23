## 256色生成用便利関数
### red: 0-5
### green: 0-5
### blue: 0-5
color256()
{
	local red=$1; shift
		local green=$2; shift
		local blue=$3; shift

		echo -n $[$red * 36 + $green * 6 + $blue + 16]
}

fg256()
{
	echo -n $'\e[38;5;'$(color256 "$@")"m"
}

bg256()
{
	echo -n $'\e[48;5;'$(color256 "$@")"m"
}
### プロンプトバーの左側
### %{%B%}...%{%b%}: 「...」を太字にする。
### %{%F{cyan}%}...%{%f%}: 「...」をシアン色の文字にする。
### %n: ユーザ名
### %m: ホスト名（完全なホスト名ではなくて短いホスト名）
### %{%B%F{white}%(?.%K{green}.%K{red})%}%?%{%f%k%b%}:
### 最後に実行したコマンドが正常終了していれば
### 太字で白文字で緑背景にして異常終了していれば
### 太字で白文字で赤背景にする。
### %{%F{white}%}: 白文字にする。
### %(x.true-text.false-text): xが真のときはtrue-textになり
### 偽のときはfalse-textになる。
### ?: 最後に実行したコマンドの終了ステータスが0のときに真になる。
### %K{green}: 緑景色にする。
### %K{red}: 赤景色を赤にする。
### %?: 最後に実行したコマンドの終了ステータス
### %{%k%}: 背景色を元に戻す。
### %{%f%}: 文字の色を元に戻す。
### %{%b%}: 太字を元に戻す。
### %D{%Y/%m/%d %H:%M}: 日付。「年/月/日 時:分」というフォーマット。
#prompt_bar_left_self="(%{%B%}%n%{%b%}%{%F{cyan}%}@%{%f%}%{%B%}%m%{%b%})"
prompt_bar_left_self="(%{%b%}%n@%m%{%b%})"
#prompt_bar_left_status="(%{%B%F{white}%(?.%K{green}.%K{red})%}%?%{%k%f%b%})"
prompt_bar_left_status="(%{%F{white}%(?.%K{black}.%K{red})%}%?%{%k%f%b%})"
#prompt_bar_left_date="<%{%B%}%D{%Y/%m/%d %H:%M}%{%b%}>"
prompt_bar_left_date="<%D{%Y/%m/%d %H:%M}%{%b%}>"
#prompt_bar_left="-${prompt_bar_left_self}-${prompt_bar_left_status}-${prompt_bar_left_date}-"
prompt_bar_left="-${prompt_bar_left_self}-${prompt_bar_left_status}-${prompt_bar_left_date}-"
#prompt_bar_left=printf "%${COLUMNS}s\n" "${prompt_bar_left}"
### プロンプトバーの右側
### %{%B%K{magenta}%F{white}%}...%{%f%k%b%}:
### 「...」を太字のマゼンタ背景の白文字にする。
### %d: カレントディレクトリのフルパス（省略しない）
#prompt_bar_right="[%{%B%K{magenta}%F{white}%}%d%{%f%k%b%}]-"
#prompt_bar_right="[%{%F{white}%}%d%{%f%k%b%}]-"
prompt_bar_right="[%{%F{magenta}%}%d%{%f%k%b%}]"


### 2行目左にでるプロンプト。
### %h: ヒストリ数。
### %(1j,(%j),): 実行中のジョブ数が1つ以上ある場合だけ「(%j)」を表示。
### %j: 実行中のジョブ数。
### %{%B%}...%{%b%}: 「...」を太字にする。
### %#: 一般ユーザなら「%」、rootユーザなら「#」になる。
#prompt_left="-[%h]%(1j,(%j),)%{%B%}%#%{%b%} "

#prompt_update() {
#
#	setopt prompt_subst
#
#	echo $[RANDOM % 6] > /dev/null
#
#	#prompt_left="%{%F$(fg256 $[RANDOM % 6] $[RANDOM % 6] $[RANDOM % 6])%}-[%h]%(1j,(%j),)%{%B%}%#%{%b%}%{%f%} "
#	#prompt_left="%{%F$(fg256 $[RANDOM % 5] $[RANDOM % 5] $[RANDOM % 5])%}-[%h]%(1j,(%j),)%{%B%}%#%{%b%}%{%f%} "
#	#PROMPT='${prompt_bar_left}${prompt_bar_right}'$'\n''${prompt_left}%{$fg_bold[red]%}➜ %{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'
#	#prompt_left="%{%F$(fg256 $[RANDOM % 5] $[RANDOM % 5] $[RANDOM % 5])%}-[%h]%(1j,(%j),)%#%{%f%} "
#	prompt_left="-[%h]%(1j,(%j),)%{%f%} "
#	#prompt_right=printf "%${COLUMNS}s\n" "${prompt_bar_left}${prompt_bar_right}"
#	right_chars="-${prompt_bar_right}${prompt_bar_left}"
#	echo "$right_chars"
#	prompt_right=$(printf "%${COLUMNS}s\n" "$right_chars")
#	echo "$prompt_right"
#	echo "$COLUMNS"
#	line=$(count_prompt_chars "$prompt_right")
#	echo "$line"
#	left_chars=`expr $COLUMNS - 1 - ${line} - 1`
#	left_chars=`expr $line - $COLUMNS`
#	echo "$left_chars"
#	left_space=""
#	for k in `seq 1 "$left_chars"`
#	do
#    	left_space="$left_space "
#	done
#	prompt_right=$(printf "%${COLUMNS}s\n" "${left_space}${right_chars}")
#	line=$(count_prompt_chars "$prompt_right")
#	echo "$line"
#	#PROMPT='${prompt_bar_left}${prompt_bar_right}'$'\n''${prompt_left}%{$fg_bold[red]%}➜ %{$fg_bold[green]%}%p %{%b%}%{$fg[cyan]%}%c %{$fg[blue]%}$(git_prompt_info)%{$fg[blue]%} % %{$reset_color%}'
#	PROMPT='${prompt_right}'$'\n''${prompt_left}%{$fg_bold[yellow]%}➜ %{$fg_bold[green]%}%p %{%b%}%{$fg[cyan]%}%c %{$fg[blue]%}$(git_prompt_info)%{$fg[blue]%}% %{$reset_color%}%# '
#
#	ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[green]%}"
#	ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
#	ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg_bold[red]%}✗ %{$reset_color%}"
#	ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
#
#	ZSH_THEME_GIT_PROMPT_UNTRACKED="%%{$fg[blue]%}) {$fg[cyan]%} ✭%{$reset_color%}" # ⓣ
#	ZSH_THEME_GIT_PROMPT_ADDED="%%{$fg[blue]%}) {$fg[cyan]%} ✚%{$reset_color%}" # ⓐ ⑃
#	ZSH_THEME_GIT_PROMPT_MODIFIED="%%{$fg[blue]%}) {$fg[yellow]%} ⚡%{$reset_color%}"  # ⓜ ⑁
#	ZSH_THEME_GIT_PROMPT_DELETED="%%{$fg[blue]%}) {$fg[red]%} ✖%{$reset_color%}" # ⓧ ⑂
#	ZSH_THEME_GIT_PROMPT_RENAMED="%%{$fg[blue]%}) {$fg[blue]%} ➜%{$reset_color%}" # ⓡ ⑄
#	ZSH_THEME_GIT_PROMPT_UNMERGED="%%{$fg[blue]%}) {$fg[magenta]%} ♒%{$reset_color%}" # ⓤ ⑊
#}

function count_prompt_chars (){
	# @see https://twitter.com/satoh_fumiyasu/status/519386124020482049
	print -n -P -- "$1" | sed -e $'s/\e\[[0-9;]*m//g' | sed -e 's/[^\x01-\x7e]/aa/g' | wc -m | sed -e 's/ //g'
	#print -n -P -- "$1" | sed -e $'s/\e\[[0-9;]*m//g' | wc -m | sed -e 's/ //g'
}

#add-zsh-hook precmd prompt_update

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg_bold[red]%}✗ %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}) "

ZSH_THEME_GIT_PROMPT_UNTRACKED="%%{$fg[blue]%}) {$fg[cyan]%}✭ %{$reset_color%}" # ⓣ
ZSH_THEME_GIT_PROMPT_ADDED="%%{$fg[blue]%}) {$fg[cyan]%}✚ %{$reset_color%}" # ⓐ ⑃
ZSH_THEME_GIT_PROMPT_MODIFIED="%%{$fg[blue]%}) {$fg[yellow]%}⚡ %{$reset_color%}"  # ⓜ ⑁
ZSH_THEME_GIT_PROMPT_DELETED="%%{$fg[blue]%}) {$fg[red]%}✖ %{$reset_color%}" # ⓧ ⑂
ZSH_THEME_GIT_PROMPT_RENAMED="%%{$fg[blue]%}) {$fg[blue]%}➜ %{$reset_color%}" # ⓡ ⑄
ZSH_THEME_GIT_PROMPT_UNMERGED="%%{$fg[blue]%}) {$fg[magenta]%}♒ %{$reset_color%}" # ⓤ ⑊


# この行は現在のパスを表示する設定です。ブランチを表示して色をつける設定とは関係ありません
PROMPT="%{${fg[blue]}%}[%~]%{${reset_color}%}"
#PROMPT='${prompt_left}%{$fg_bold[yellow]%}➜ %{$fg_bold[green]%}%p %{%b%}%{$fg[cyan]%}%c %{$fg[blue]%}$(git_prompt_info)%{$fg[blue]%}% %{$reset_color%}%# '
#PROMPT='${prompt_left}%{$fg_bold[yellow]%}➜ %{$reset_color%}%n%{$fg_bold[yellow]%}@%{$reset_color%}%m %{$fg_bold[green]%}%p %{%b%}%{$fg[cyan]%}%c %{$fg[blue]%}$(git_prompt_info)%{$fg[blue]%}% %{$reset_color%}%# '
PROMPT='${prompt_left}%{$fg_bold[yellow]%}➜ %{$fg_bold[green]%}%p %{%b%}%{$fg[cyan]%}%c %{$fg[blue]%}$(git_prompt_info)%{$fg[blue]%}% %{$reset_color%}%# '

autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT=$RPROMPT'${vcs_info_msg_0_}%{${fg[blue]}%}[%~]%{$reset_color%}% %{${fg[white]}%}[%*]%{$reset_color%}%'
