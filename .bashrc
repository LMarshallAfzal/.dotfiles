set -o nounset

export EDITOR="$VISUAL"

if [ -e $HOME/.aliases ]; then
    source $HOME/.aliases
fi

if [ -f ~/.bash_prompt ]; then
    source ~/.bash_prompt
fi

test -s ~/.alias && . ~/.alias || true

# Color codes
white=$(tput setaf 231) 
blue=$(tput setaf 27)

HISTTIMEFORMAT="$blue%Y-%m-%d $blue%H:%M:%S $white"

# Extract any type of compressed file
ex() {
    if [ -z ${1} ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
        echo "Usage: extract <archive> [directory]"
        echo "Example: extract presentation.zip."
        echo "Valid archive types are:"
        echo "tar.bz2, tar.gz, tar.xz, tar, bz2, gz, tbz2,"
        echo "tbz, tgz, lzo, rar, zip, 7z, xz, txz, lzma and tlz"
    else
        case "$1" in
            *.tar.bz2|*.tbz2|*.tbz)         tar xvjf "$1" ;;
            *.tgz)                          tar zxvf "$1" ;;
            *.tar.gz)                       tar xvzf "$1" ;;
            *.tar.xz)                       tar xvJf "$1" ;;
            *.tar)                          tar xvf "$1" ;;
            *.rar)                          7z x "$1" ;;
            *.zip)                          unzip "$1" ;;
            *.7z)                           7z x "$1" ;;
            *.lzo)                          lzop -d  "$1" ;;
            *.gz)                           gunzip "$1" ;;
            *.bz2)                          bunzip2 "$1" ;;
            *.Z)                            uncompress "$1" ;;
            *.xz|*.txz|*.lzma|*.tlz)        xz -d "$1" ;;
            *) echo "Sorry, '$1' could not be extract." ;;
        esac
    fi
}

# List largest files in working directory
lf() {
    du -h -x -s -- * | sort -r -h | head -20;
}

# Search through your history for previous run commands
hg() {
    history | grep "$1";
}

# Create an initialise a skeleton git repository
gitInit() {
    if [ -z "$1" ]; then
        printf "%s\n" "Please provide a directory name.";
    else
        mkdir "$1";
        builtin cd "$1";
        pwd;
        git init;
        touch README.md .gitignore LICENSE;
        echo "# $(basename $PWD)" >> README.md
    fi
}

export HISTSIZE=1000000
export HISTFILESIZE=1000000000

export STAGING_SUPABASE_URL="https://adwknukzsperykabkynr.supabase.co"
export STAGING_SUPABASE_KEY="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFkd2tudWt6c3BlcnlrYWJreW5yIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTA1MTM4NDYsImV4cCI6MjAyNjA4OTg0Nn0.wAJtG2VzRp83eUNlpnniRhfrbDW7LowU4vb4zhw70Nk"
export PRODUCTION_SUPABASE_URL="https://pdezxxwedspxsjttoqhw.supabase.co"
export PRODUCTION_SUPABASE_KEY="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBkZXp4eHdlZHNweHNqdHRvcWh3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTA0MzIxNTAsImV4cCI6MjAyNjAwODE1MH0.1T3sn2BVtKN-sI2wrNCufQaTPSypTEWtwXweLcWkMic"

source ~/.aliases
