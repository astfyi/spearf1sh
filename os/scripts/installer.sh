#!/bin/bash

make_spearf1sh_defconfig () {
    make BR2_DL_DIR=$SPEARF1SH_BR2_DL_DIR $SPEARF1SH_WORK_DIR BR2_EXTERNAL=$SPEARF1SH_INSTALL_DIR/os O=$SPEARF1SH_WORK_DIR -C $SPEARF1SH_INSTALL_DIR/buildroot $SPEARF1SH_DEFCONFIG
}

print_success () {
    printf "\n"
    printf "$BBLUE   ██████  ██▓███  ▓█████ ▄▄▄       ██▀███    █████▒██▓  ██████  ██░ ██ \n"
    printf "$BBLUE ▒██    ▒ ▓██░  ██▒▓█   ▀▒████▄    ▓██ ▒ ██▒▓██   ▒▓██▒▒██    ▒ ▓██░ ██▒\n"
    printf "$BBLUE ░ ▓██▄   ▓██░ ██▓▒▒███  ▒██  ▀█▄  ▓██ ░▄█ ▒▒████ ░▒██▒░ ▓██▄   ▒██▀▀██░\n"
    printf "$BBLUE   ▒   ██▒▒██▄█▓▒ ▒▒▓█  ▄░██▄▄▄▄██ ▒██▀▀█▄  ░▓█▒  ░░██░  ▒   ██▒░▓█ ░██ \n"
    printf "$BBLUE ▒██████▒▒▒██▒ ░  ░░▒████▒▓█   ▓██▒░██▓ ▒██▒░▒█░   ░██░▒██████▒▒░▓█▒░██▓\n"
    printf "$BBLUE ▒ ▒▓▒ ▒ ░▒▓▒░ ░  ░░░ ▒░ ░▒▒   ▓▒█░░ ▒▓ ░▒▓░ ▒ ░   ░▓  ▒ ▒▓▒ ▒ ░ ▒ ░░▒░▒\n"
    printf "$BBLUE ░ ░▒  ░ ░░▒ ░      ░ ░  ░ ▒   ▒▒ ░  ░▒ ░ ▒░ ░      ▒ ░░ ░▒  ░ ░ ▒ ░▒░ ░\n"
    printf "$BBLUE ░  ░  ░  ░░          ░    ░   ▒     ░░   ░  ░ ░    ▒ ░░  ░  ░   ░  ░░ ░\n"
    printf "$BBLUE       ░              ░  ░     ░  ░   ░             ░        ░   ░  ░  ░\n\n"

    printf "$GREEN ... is now built $USER!$RESET\n"
    printf "$GREEN Your SD card is in $SPEARF1SH_WORK_DIR/images/sdcard.img\n"
}

make_spearf1sh () {
    time make BR2_DL_DIR=$SPEARF1SH_BR2_DL_DIR -C $SPEARF1SH_WORK_DIR
    if [ $? -ne 0 ]; then
        printf "$BRED Spearf1sh failed to build.\n"
        printf "$BRED Try resolving the error and re-running the installer with -x.\n"
        printf "$BRED To rebuild from scratch again, re-run with -r\n$RESET"
        exit 1
    fi
    print_success

}

install_spearf1sh () {
    printf " Cloning Spearfish's GitHub repository...\n$RESET"
    if [ x$SPEARF1SH_VERBOSE != x ]
    then
        /usr/bin/env git clone --recurse-submodules $SPEARF1SH_URL "$SPEARF1SH_INSTALL_DIR"
    else
        /usr/bin/env git clone --recurse-submodules $SPEARF1SH_URL "$SPEARF1SH_INSTALL_DIR" > /dev/null
    fi
    if ! [ $? -eq 0 ]
    then
        printf "$RED A fatal error occurred during Spearf1sh's git clone. Aborting..."
        exit 1
    fi

    mkdir -p "$SPEARF1SH_WORK_DIR"
    mkdir -p "$SPEARF1SH_BR2_DL_DIR"

    make_spearf1sh_defconfig
    make_spearf1sh

}

make_spearf1sh_dirs () {
    printf " Creating the required directories.\n$RESET"
    mkdir -p "$SPEARF1SH_INSTALL_DIR"
}

install_deps()
{
    ## Prompt the user
    read -p "Do you want to install missing libraries? [Y/n]: " answer
    ## Set the default value if no answer was given
    answer=${answer:Y}
    ## If the answer matches y or Y, install
    [[ $answer =~ [Yy] ]] && sudo apt-get install ${deps[@]}
}


deps=("bash" "bc" "binutils" "bison" "bsdmainutils" "build-essential" "bzip2" "ca-certificates" "cmake-extras" "cmake" "cpio" "cryptsetup" "debianutils" "flex" "gcc" "git" "gnu-efi" "g++" "gzip" "libelf-dev" "libncurses5-dev" "libnss3-tools" "libpcap-dev" "libssl-dev" "locales" "lzop" "make" "patch" "perl" "python-dev" "python" "qemu-system-x86" "rsync" "sbsigntool" "sed" "swig" "tar" "unzip" "wget" "zlib1g-dev")

colors_ () {
    case "$SHELL" in
    *zsh)
        autoload colors && colors
        eval RESET='$reset_color'
        for COLOR in RED GREEN YELLOW BLUE MAGENTA CYAN BLACK WHITE
        do
            eval $COLOR='$fg_no_bold[${(L)COLOR}]'
            eval B$COLOR='$fg_bold[${(L)COLOR}]'
        done
        ;;
    *)
        RESET='\e[0m'           # Reset
        RED='\e[0;31m'          # Red
        GREEN='\e[0;32m'        # Green
        YELLOW='\e[0;33m'       # Yellow
        BLUE='\e[0;34m'         # Blue
        PURPLE='\e[0;35m'       # Magenta
        CYAN='\e[0;36m'         # Cyan
        WHITE='\e[0;37m'        # White
        BRED='\e[1;31m'         # Bold Red
        BGREEN='\e[1;32m'       # Bold Green
        BYELLOW='\e[1;33m'      # Bold Yellow
        BBLUE='\e[1;34m'        # Bold Blue
        BPURPLE='\e[1;35m'      # Bold Magenta
        BCYAN='\e[1;36m'        # Bold Cyan
        BWHITE='\e[1;37m'       # Bold White
        ;;
    esac
}

usage() {
    printf "Usage: $0 [OPTION]\n"
    printf "  -c, --colors \t \t \t Enable colors.\n"
    printf "  -d, --directory [dir] \t Install Spearf1sh into the specified directory.\n"
    printf "  \t \t \t \t If 'dir' is a relative path prefix with $HOME.\n"
    printf "  \t \t \t \t Defaults to $HOME/spearf1sh\n"
    printf "  -b, --buildroot_dl [dir] \t Install Spearf1sh buildroot download cache.\n"
    printf "  \t \t \t \t If 'dir' is a relative path prefix with $HOME.\n"
    printf "  \t \t \t \t Defaults to $HOME/.spearf1sh/buildroot_dl\n"
    printf "  -f, --defconfig [config] \t \t Make the 'config' defconfig.\n"
    printf "  \t \t \t \t Defaults to 'artyz7_20_gpio_jtag_defconfig'.\n"
    printf "  -s, --source [url] \t \t Clone Spearf1sh from 'url'.\n"
    printf "  \t \t \t \t Defaults to 'https://github.com/advancedsecio/spearf1sh'.\n"
    printf "  -r, --remove \t \t \t First remove the existing Spearf1sh directory.\n"
    printf "  -h, --help \t \t \t Display this help and exit\n"
    printf "  -v, --verbose \t \t Display verbose information\n"
    printf "  -x, --remake \t \t Re-run make without a clean\n"
    printf "\n"
}

### Parse cli
while [ $# -gt 0 ]
do
    case $1 in
        -d | --directory)
            SPEARF1SH_INSTALL_DIR=$2
            shift 2
            ;;
        -b | --buildroot_dl)
            SPEARF1SH_BR2_DL_DIR=$2
            shift 2
            ;;
        -c | --colors)
            colors_
            shift 1
            ;;
        -f | --defconfig)
            SPEARF1SH_DEFCONFIG=$2
            shift 2
            ;;
        -r | --remove)
            SPEARF1SH_REMOVE='true'
            shift 1
            ;;
        -h | --help)
            usage
            exit 0
            ;;
        -v | --verbose)
            SPEARF1SH_VERBOSE='true';
            shift 1
            ;;
        -x | --remake)
            SPEARF1SH_REMAKE='true';
            shift 1
            ;;
        *)
            printf "Unknown option: $1\n"
            shift 1
            ;;
    esac
done

VERBOSE_COLOR=$BBLUE

[ -z "$SPEARF1SH_URL" ] && SPEARF1SH_URL="https://github.com/advancedsecio/spearf1sh"
[ -z "$SPEARF1SH_INSTALL_DIR" ] && SPEARF1SH_INSTALL_DIR="$HOME/spearf1sh"
[ -z "$SPEARF1SH_WORK_DIR" ] && SPEARF1SH_WORK_DIR="$SPEARF1SH_INSTALL_DIR/work"
[ -z "$SPEARF1SH_DEFCONFIG" ] && SPEARF1SH_DEFCONFIG="artyz7_20_gpio_jtag_defconfig"
[ -n "$BR2_DL_DIR" ] && SPEARF1SH_BR2_DL_DIR="$BR2_DL_DIR"
[ -z "$SPEARF1SH_BR2_DL_DIR" ] && SPEARF1SH_BR2_DL_DIR="$HOME/.spearf1sh/buildroot_dl"


if [ -n "$SPEARF1SH_REMAKE" ]
then
    make_spearf1sh
    exit $?
fi

if [ -n "$SPEARF1SH_REMOVE" ]
then
    echo "Removing recursively the Spearf1sh install dir"
    rm -rf $SPEARF1SH_INSTALL_DIR
fi


if [ x$SPEARF1SH_VERBOSE != x ]
then
    printf "$VERBOSE_COLOR"
    printf "SPEARF1SH_VERBOSE = $SPEARF1SH_VERBOSE\n"
    printf "INSTALL_DIR = $SPEARF1SH_INSTALL_DIR\n"
    printf "SOURCE_URL  = $SPEARF1SH_URL\n"
    printf "SPEARF1SH_WORK_DIR = $SPEARF1SH_WORK_DIR\n"
    printf "SPEARF1SH_DEFCONFIG = $SPEARF1SH_DEFCONFIG\n"
    printf "SPEARF1SH_BR2_DL_DIR = $SPEARF1SH_BR2_DL_DIR\n"

    printf "$RESET"
    printf "$RESET"
fi

# If spearf1sh is already installed
if [ -f "$SPEARF1SH_WORK_DIR/images/sdcard.img" ]
then
   printf "\n\n$BRED"
   printf "You already have Spearf1sh installed and a sd card image.$RESET\nYou'll need to remove $SPEARF1SH_INSTALL_DIR/spearf1sh if you want to install Spearf1sh again.\n"
   printf "Be mindful and keep any buildroot package downloads and images if you need them\n"
   printf "You can re-run this script with the -r option to remove this directory for you.\n\n"
   exit 1;
elif [ -f "$SPEARF1SH_INSTALL_DIR/README.md" ]
then
    printf "\n\n$BRED"
    printf "You already have Spearf1sh installed BUT NO SD CARD.$RESET\n"
    printf "You have options.\n"
    printf "You you want to rebuild without a clean, because you fixed an error or made a change, rerun this script with -x\n"
    printf "If you want to start from scratch and remove everyting, rerun with -r\n"
    exit 1;
fi

mkdir -p $HOME/.spearf1sh

if [ -f $HOME/.spearf1sh/deps ]
then
    printf "\n\nDeps installed\n"
else
    dpkg -s "${deps[@]}" >/dev/null 2>&1 || install_deps
    if [ $? -eq 0 ]
    then
       touch $HOME/.spearf1sh/deps
    fi

fi


### Check dependencies
printf  "$CYAN Checking to see if git is installed... $RESET"
if hash git 2>&-
then
    printf "$GREEN found.$RESET\n"
else
    printf "$RED not found. Aborting installation!$RESET\n"
    exit 1
fi;


if [ -d "$SPEARF1SH_INSTALL_DIR" ] || [ -f "$SPEARF1SH_INSTALL_DIR" ]
then
    printf "$BRED $SPEARF1SH_INSTALL_DIR exists but it is not setup correctly.\n"
    printf "$BRED please remove (rerun with -r) or install Spearf1sh in a different directory"
    printf "$BRED (-d flag)\n$RESET"
    exit 1

elif [ -e "$SPEARF1SH_INSTALL_DIR" ]
then
    # File exist but not a regular file or directory
    # WTF NOW?
    printf "$BRED $SPEARF1SH_INSTALL_DIR exist but isn't a file or directory.\n"
    printf "$BRED please remove this file or install Spearf1sh in a different directory"
    printf "$BRED (-d flag)\n$RESET"
    exit 1
else
    # Nothing yet so just install spearf1sh
    install_spearf1sh
    make_spearf1sh_dirs
fi
