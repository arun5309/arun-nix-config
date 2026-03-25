typeset -A abbrevs
abbrevs=(
            "..." "../.."
           "...." "../../.."        
            "upd"  "sudo dnf update -y"
           "fupd" "flatpak update -y"
           "sins" "rpm --query --all --queryformat '%{NAME}.%{ARCH}: %{SUMMARY}\n' "
        "clipclr" 'wl-copy --clear; copyq remove $(seq 0 1 $(($(copyq count) - 1)))'
            "mkc" 'MY_DIR= mkdir $MY_DIR && cd $MY_DIR'
            "mve" 'mv --exchange'
)

#create aliases for the abbrevs too
for abbr in ${(k)abbrevs}; do
   alias -g $abbr="${abbrevs[$abbr]}"
done

my-expand-abbrev() {
    local ARR=( ${=LBUFFER} )
    ARR[-1]="${abbrevs[${ARR[-1]}]:-${ARR[-1]}}"    
    LBUFFER=$ARR
    # zle self-insert
}

zle -N my-expand-abbrev    
bindkey "^ " my-expand-abbrev 
bindkey -M isearch "^ " self-insert

