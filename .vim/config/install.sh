scriptPath=$(realpath $0)
configPath=$(dirname $scriptPath)

OPTS=$(getopt -o pfasmth \
	--long output:,plugins,file-types,minimal,functions,all,secret,snippets,help \
	-n 'parse-options' -- "$@")

if [ $? != 0 ]; then
	printf "Failed parsing options." >& 2
	exit 1
fi

eval set -- "$OPTS"

OUTPUT_FILE="$HOME/.vimrc"
PLUGINS=false
FILE_TYPES=false
FUNCTIONS=false
SECRET=false
ALL=false
MINIMAL=false
SNIPPETS=false
HELP=false

while true; do
	case "$1" in
		--output ) OUTPUT_FILE="$2"; shift; shift ;;
		-p | --plugins ) PLUGINS=true; shift ;;
		-f | --functions ) FUNCTIONS=true; shift ;;
		-s | --secret ) SECRET=true; shift ;;
		--snippets ) SNIPPETS=true; shift ;;
		-t | --file-types ) FILE_TYPES=true; shift ;;
		-a | --all ) ALL=true; shift ;;
		-m | --minimal ) MINIMAL=true; shift ;;
		-h | --help ) HELP=true; shift ;;
		-- ) shift; break ;;
		* ) break ;;
	esac
done

create_file_types_links() {
	if [ ! -d "$HOME/.vim/ftplugin" ] ; then
		printf "Linking ftplugin directory... "
		ln -s $configPath/ftplugin/ $HOME/.vim/ftplugin
	else
		printf "Creating soft links... "
		ln -s $configPath/ftplugin/* $HOME/.vim/ftplugin
	fi
	printf "Soft links created\n\n"
}

create_snippets_link() {
	if [ ! -d "$HOME/.vim/snippets-used" ] ; then
		printf "Creating full folder link... "
		ln -s $configPath/snippets-used/ $HOME/.vim/snippets-used
	else
		printf "Creating snippets soft links... "
		ln -s $configPath/snippets-used/* $HOME/.vim/snippets-used
	fi

	printf "Snippet soft links created\n\n"
}

create_back_up_file() {
	if [ -e $1 ] ; then
		printf "Creating backup for $1... "
		mv $1 $1.bk
		printf "Backup created\n\n"
	fi
}

print_help() {
	echo "	--output            Output file
	-p | --plugins      Add plugins
	-f | --functions    Add functions
	-s | --secret       Source secret file
	--snippets          Link used snippets
	-t | --file-types   Link file types
	-a | --all          Install all
	-m | --minimal      Minimal install
	-h | --help         Print this message"
}

if [ "$HELP" = true ] ; then
	print_help
	exit 0
fi

if [ "$MINIMAL" = true ] ; then
	create_back_up_file $OUTPUT_FILE

	if [ "$FILE_TYPES" = true ] || [ "$ALL" = true ] ; then
		create_file_types_links
	fi

	echo "so $configPath/.minvimrc" > $OUTPUT_FILE
	printf "Minimal setup ready"
else
	create_back_up_file $OUTPUT_FILE

	if [ "$FILE_TYPES" = true ] || [ "$ALL" = true ] ; then
		create_file_types_links
	fi

	if [ "$SNIPPETS" = true ] || [ "$ALL" = true ] ; then
		create_snippets_link
	fi

	if [ -n $OUTPUT_FILE ] ; then
		if [ ! -e $OUTPUT_FILE ] || [ "$FORCE" = true ] ; then
			echo "let dirSep = \"/\"" > $OUTPUT_FILE
			echo "let configPath = \"$configPath\"" >> $OUTPUT_FILE
			echo "so $configPath/.vimrc" >> $OUTPUT_FILE

			if [ "$PLUGINS" = true ] || [ "$ALL" = true ] ; then
				printf "Adding plugins.vim..."
				if [ ! -d "$HOME/.vim/plugin" ] ; then
					printf "Linking plugin directory... "
					ln -s $configPath/plugin/ $HOME/.vim/plugin
				else
					printf "Creating soft links... "
					ln -s $configPath/plugin/* $HOME/.vim/plugin
				fi

				if [ ! -e ~/.vim/autoload/plug.vim ] ; then
					printf "Installing vim plug..."
					curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
						https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

					printf "Vim plug installed\n\n"
				fi

				ln -s $configPath/coc-settings.json $HOME/.config/nvim/coc-settings.json
				echo "so $configPath/plugins.vim" >> $OUTPUT_FILE
				printf "plugins.vim added\n\n"
			fi

			echo "" >> $OUTPUT_FILE

			if [ "$FUNCTIONS" = true ] || [ "$ALL" = true ] ; then
				printf "Adding functions.vim... "
				echo "so $configPath/functions.vim" >> $OUTPUT_FILE
				printf "functions.vim added\n\n"
			fi

			if [ "$SECRET" = true ] || [ "$ALL" = true ] ; then
				printf "Adding secret.vim... "
				echo "so $HOME/.vim/secret.vim" >> $OUTPUT_FILE
				printf "secret.vim added\n\n"
			fi

			printf "$OUTPUT_FILE written\n"
		fi
	fi
fi
