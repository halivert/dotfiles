# Vimrc

Este es mi conjunto de archivos de vimrc, con configuraciones por
archivo y cosas por el estilo.

## Instalación:

### Opción 1 (Recomendada)

Ejecutar el script `install.sh` que creará un archivo `.vimrc` en tu carpeta
`$HOME`. Dicho script tiene las siguientes opciones:

_**`-f / --functions`**_

>     Agrega como fuente el archivo que contiene funciones extras.

_**`-p / --plugins`**_

>     Agrega como fuente el archivo que contiene los plugins.

_**`-s / --secret`**_

>     Agrega como fuente un archivo «secreto» ubicado en `$HOME/.vim/secret.vim`.

_**`--snippets`**_

>     Crea un soft link para el directorio `snippets-used`.

_**`-t / --file-types`**_

>     Crea soft links para los tipos de archivos.

_**`-a / --all`**_

>     Agrega como fuente los archivos de funciones, plugins, secreto y crea soft
>
> links para los tipos de archivos.

_**`-m / --minimal`**_[\*](#instalación-mínima)

>     Agrega solo un archivo con las instrucciones mínimas.

### Opción 2 (manual)

Soft link para cada uno de los siguientes archivos, ejemplo:

```sh
# Si estás en el directorio actual
ln -s $(pwd)/.vimrc $HOME/.vimrc
```

#### Ejemplo de ubicación de los soft links

```sh
~/.bin/online-search # Algún lugar de tu $PATH
~/.config/nvim/init.vim # Si usas neovim
~/.vim/.minvimrc
~/.vim/ftplugin/tex.vim
~/.vim/functions.vim
~/.vim/plugins.vim
~/.vim/snippets-used
~/.vimrc
```

Para instalar el [administrador de plugins][1] hacen falta estas dos líneas en
nuestra terminal:

```sh
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

## Instalación mínima

Para una instalación mínima, en un servidor, por ejemplo, hay que ejecutar el
siguiente comando:

```sh
curl https://raw.githubusercontent.com/halivert/dotfiles/main/.vim/config/.minvimrc > $HOME/.vimrc
# O
wget https://raw.githubusercontent.com/halivert/dotfiles/main/.vim/config/.minvimrc
mv .minvimrc $HOME/.vimrc
```

[1]: https://github.com/junegunn/vim-plug
