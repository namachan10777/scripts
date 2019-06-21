#!/usr/bin/fish

set HERE (cd (dirname (status -f)); and pwd)

if not test $XDG_CONFIG_HOME
	set -gx XDG_CONFIG_HOME $HOME/.config
end

function confirm
	set MSG $argv[1]
	while true
		read -P $MSG -n 1 ANS
		switch (echo $ANS)
			case y Y
				return 0
			case n N
				return 1
			case '*'
		end
	end
end