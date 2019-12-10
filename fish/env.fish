if not test $XDG_CONFIG_HOME
	set -gx XDG_CONFIG_HOME $HOME/.config
end

set -gx LANG en_US.UTF-8
set -gx EDITOR nvim
set -gx OCAMLPARAM "_,bin-annot=1"
set -gx OPAMKEEPBUILDDIR 1
set -gx GOPATH ~/.local/share/go
if type opam > /dev/null 2>&1
	eval (opam env)
end

set PATH ~/.cargo/bin $PATH
set PATH ~/.gem/ruby/2.6.0/bin $PATH
set PATH ~/anaconda3/bin $PATH
set PATH $GOPATH/bin $PATH

