#!/bin/sh
# tmux.sh plugin for Munin
# See more plugins on https://github.com/Naereen/My-Munin-plugins/
# MIT Licensed, https://lbesson.mit-license.org/
#
# Inspired from http://guide.munin-monitoring.org/en/latest/plugin/writing.html#example-shell-plugin

# Print config
output_config() {
    echo "graph_title Tmux sessions, windows and panes"
    echo "graph_category tmux"
    # echo "graph_scale no"
    # echo "graph_vlabel Number of Tmux windows"
    echo "sessions.label Tmux sessions"
    echo "sessions.info This graph shows the number of sessions opened on the system."
    echo "windows.label Tmux windows"
    echo "windows.info This graph shows the number of windows opened in all the tmux sessions on the system."
    echo "panes.label Tmux panes"
    echo "panes.info This graph shows the number of panes opened in all the tmux sessions on the system."
}

# Print data
output_values() {
    printf "sessions.value %d\n" $(number_of_sessions)
    printf "windows.value %d\n" $(number_of_windows)
    printf "panes.value %d\n" $(number_of_panes)
}

# Acquire data
number_of_sessions() {
    # tmux list-sessions 2>/dev/null | wc -l
    w | grep -o "tmux([0-9]\+" | sed s/"tmux("/""/ | uniq | wc -l
}

number_of_windows() {
    nb=$(tmux list-windows 2>/dev/null | wc -l)
    if [ $nb -eq 0 ]; then
        nb=$(number_of_panes)
    fi
    echo $nb
}

number_of_panes() {
    # XXX should find a way to be quicker, the last part in Python is slow!
    # tmux list-windows 2>/dev/null | grep -o "[0-9]\+ panes" | sed s/' panes'/''/ | python -c 'import sys; print(sum(map(int, sys.stdin)))'
    w | grep "tmux([0-9]\+)\.%" | wc -l
}

# Print help
output_usage() {
    printf >&2 "%s - munin plugin to graph the number of sessions, windows and panes opened in tmux\n" ${0##*/}
    printf >&2 "Usage: %s [config]\n" ${0##*/}
}

# Parse command line arguments
case $# in
    0)
        output_values
        ;;
    1)
        case $1 in
            config)
                output_config
                ;;
            *)
                output_usage
                exit 1
                ;;
        esac
        ;;
    *)
        output_usage
        exit 1
        ;;
esac
