# Nautilus
if [ $(uname) = "Linux" ]; then
    alias nautilus='nautilus --no-desktop'
fi

# IP Addresses
alias publicip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="sudo ifconfig | grep -Eo 'inet (addr:)?([0-9]*\\.){3}[0-9]*' | grep -Eo '([0-9]*\\.){3}[0-9]*' | grep -v '127.0.0.1'"

# Tar
alias untar="tar -xvf"
