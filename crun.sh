NC='\033[0m'
RED='\033[0;31m'
GREEN='\033[1;32m'
LGREEN='\033[1;32m'
LIGHTBLUE='\033[1;34m'
BOLD=$(tput bold)
NORMAL=$(tput sgr0)
PURPLE='\033[1;35m'

crun() {
    tput civis
    passargs=''
    KEEP=0
    
    # check for errors n stuff
    if ! [ "$1" ]; then
        printf "${RED}${BOLD}E: No filename given!\n${NC}${NORMAL}"
        tput cnorm
        return
    fi
    if ! [[ "$1" == *".cs"* ]]; then
        printf "${RED}${BOLD}E: No .cs file!\n${NC}${NORMAL}"
        tput cnorm
        return
    fi

    # handle arguments
    for i in $@; do
        if [[ "$i" == "--help" ]]; then
            printf "${PURPLE}${BOLD}Use 'crun <file.cs> <args and flags>' to compile and run cs scirpts.\n"
            printf "Flags: '--keep' to preserve .exe file, '--clear' to clear terminal before execution and '--help' for help.${NC}${NORMAL}\n"
            tput cnorm
            return
        elif [[ "$i" == "--keep" ]]; then
            KEEP=1
        elif [[ "$i" == "--clear" ]]; then
            clear
        elif ! [[ "$i" == "$1" ]]; then
            passargs+=' '$i
        fi
    done

    printf "${PURPLE}${BOLD}Compiling and running '${1}'${NC}${NORMAL}\n"
    start_time="$(date -u +%s.%N)"

    mcs $1

    #check compile succes
    if ! test -f "./${1%.*}.exe"; then
        printf "${RED}${BOLD}E: Failed to compile '$1'!\n${NC}${NORMAL}"
        printf "${PURPLE}${BOLD}Aborting...\n${NC}${NORMAL}"
        tput cnorm
        return
    fi

    printf "${PURPLE}${BOLD}Compiled (${1%.*}.exe)\n${LGREEN}------------------------------\n\n${NC}${NORMAL}"
    mono ${1%.*}.exe ${passargs}

    end_time="$(date -u +%s.%N)"
    elapsed="$(bc <<<"$end_time-$start_time")"
    printf "\n${BOLD}${LGREEN}------------------------------"
    printf "\n${PURPLE}${BOLD}Done (Finished in ${elapsed} seconds)\n"

    if [ $KEEP -eq 1 ]; then
        printf "${1%.*}.exe preserved (remove '--keep' to remove)${NC}${NORMAL}\n"
        tput cnorm
        return
    fi
    rm "${1%.*}.exe"
    printf "${1%.*}.exe removed (add '--keep' to preserve)${NC}${NORMAL}\n"
    tput cnorm
    return
}

alias crun='crun'
