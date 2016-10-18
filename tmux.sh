#!/bin/sh
# tmux.sh plugin for Munin
# See more plugins on https://github.com/Naereen/My-Munin-plugins/
# MIT Licensed, https://lbesson.mit-license.org/
#
# Inspired from http://guide.munin-monitoring.org/en/latest/plugin/writing.html#example-shell-plugin

output_config() {
    echo "graph_title Tmux tabs, panes and sessions"
    echo "graph_category Tmux"
    echo "graph_scale no"
    echo "graph_vlabel Number of Tmux tabs"
    echo "tabs.label Tmux tabs"
    echo "tabs.info This graph shows the number of tabs and panes opened in all the tmux sessions on the system."
}

output_values() {
    printf "tabs.value %d\n" $(number_of_tabs)
    printf "sessions.value %d\n" $(number_of_sessions)
}

number_of_tabs() {
    find /etc/munin/plugins -type l | wc -l
}

number_of_sessions() {
    tmux list-sessions | wc -l
}

output_usage() {
    printf >&2 "%s - munin plugin to graph an example value\n" ${0##*/}
    printf >&2 "Usage: %s [config]\n" ${0##*/}
}

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
