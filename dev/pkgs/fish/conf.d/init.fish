# vim:fdm=marker
set HERE (dirname (status -f))
source $HERE/env.fish

# abbr {{{
abbr -a py ipython
abbr -a ..  "cd ../"
abbr -a ... "cd ../../"
abbr -a v nvim
abbr -a c cd
abbr -a stdwn "shutdown -h now"
abbr -a top gotop
abbr -a btop battop
abbr -a tk tokei
abbr -a gpo git push origin
abbr -a lg lazygit
abbr -a jigai sudo shutdown -h now
# }}}

# alias {{{
function dif
	delta --side-by-side --line-numbers $argv
end

function ls
	lsd $argv
end

function ll
	lsd -l $argv
end

function lt
	lsd --tree $argv
end

function clipb
	xsel --clipboard --input
end
# }}}

# ~/tmp {{{
set TMPDIR /tmp/.(whoami)-tmp

if not test -e ~/tmp
	mkdir -p $TMPDIR
	ln -s $TMPDIR ~/tmp
end
# }}}

# starship {{{
starship init fish | source
zoxide init fish | source
# }}}

