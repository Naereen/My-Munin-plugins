#!/bin/sh
# gui_windows.sh plugin for Munin
# See more plugins on https://github.com/Naereen/My-Munin-plugins/
# MIT Licensed, https://lbesson.mit-license.org/
#
# Inspired from http://guide.munin-monitoring.org/en/latest/plugin/writing.html#example-shell-plugin

# Print config
output_config() {
    echo "graph_title Windows and programs"
    echo "graph_category system"
    echo "graph_scale yes"
    echo "graph_info This graph shows the number of graphical windows and programs opened on the system. See <a href='https://github.com/Naereen/My-Munin-plugins/'>here</a> for other plugins written by <a href='https://github.com/Naereen/'>Lilian Besson (Naereen)</a> (<a href='https://lbesson.mit-license.org/'>MIT Licensed</a>)."
    # echo "graph_vlabel Number"
    echo "windows.label Active windows"
    echo "windows.info This graph shows the number of graphical windows opened on the system."
    echo "programs.label Active programs"
    echo "programs.info This graph shows the number of graphical programs running on the system."
}

# Print data
output_values() {
    printf "windows.value %d\n" "$(number_of_windows)"
    printf "programs.value %d\n" "$(number_of_programs)"
}

# Acquire data
number_of_windows() {
    # We only count the windows in the foreground
    nb="$(wmctrl -l | awk ' { print $2 } ' | grep -c 0)"
    echo "${nb:-0}"
}

number_of_programs() {
    nb="$(xlsclients | wc -l)"
    echo "${nb:-0}"
}

# Print help
output_usage() {
    printf >&2 "%s - munin plugin to graph the number of active windows in your windows manager\n" ${0##*/}
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
