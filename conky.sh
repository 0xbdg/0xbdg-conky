killall conky

if ! pgrep -x "conky" > /dev/null; then
    # Start Conky in the background
    conky -c ~/.config/conky/right.conf &
    conky -c ~/.config/conky/middle.conf &
    conky -c ~/.config/conky/left.conf &
fi
