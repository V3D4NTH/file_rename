# reversing the SRN to create the password
function rev() {
    local str="$1"
    local len=${#str}
    local reverse=""

    for ((i = len - 1; i >= 0; i--)); 
    do
        reverse="$reverse${str:i:1}"
    done

    echo "$reverse"
}

function search() {
    local dir="$1"
    local fn="$2"

    if [ ! -d "$dir" ]; 
    then
        echo "Directory does not exist!"
        exit 253
    fi

    local outcome=$(find "$dir" -type f -name "$fn")
    local hits=$(find "$dir" -type f -name "$fn" | wc -l)


    if [ $hits -eq 0 ]; 
    then
        echo "There are $outcome number of matches"
    else
        echo "There are $hits number of matches"
        echo "$outcome"
    fi
}

function rename_file() {
    local dir="$1"
    local ext="$2"
    find "$dir" -type f -name "$ext" | while read -r file; 
    do
        initial=$(basename "$file")
        final=$(dirname "$file")
        renamed="${final}/${initial%$ext}.pNg"
        mv "$file" "g $file to $renamed"
    done
}

read SRN PWD DIR
standardSRN="PES2UG22CS___"
EXT="*.png"
reverse_PWD=$(rev "$PWD")

if test "$SRN" = "$standardSRN"; 
then
    if test "$reverse_PWD" = "$SRN"; 
    then
        echo "Credentials are correct."
        search "$DIR" "$EXT"
        rename_file "$DIR" "$EXT"
    else
        echo "Wrong password."
        exit 255
    fi
else
    echo "Wrong username."
    exit 254
fi
