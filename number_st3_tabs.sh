#!/bin/sh
# number_of_plugins.sh plugin for Munin
# See more plugins on https://github.com/Naereen/My-Munin-plugins/
#
# From http://guide.munin-monitoring.org/en/latest/plugin/writing.html#example-shell-plugin

# Print config
output_config() {
    echo "graph_title Sublime Text 3 tabs"
    echo "graph_category sublimetext"
    echo "graph_scale no"
    echo "graph_vlabel Number of tabs"
    echo "graph_info This graph shows the number of tabs opened in your <a href='https://www.sublimetext.com/3'>Sublime Text 3</a> text editor. See <a href='https://github.com/Naereen/My-Munin-plugins/'>here</a> for other plugins written by <a href='https://github.com/Naereen/'>Lilian Besson (Naereen)</a> (<a href='https://lbesson.mit-license.org/'>MIT Licensed</a>)."
    echo "st3tabs.label Opened tabs"
    echo "st3tabs.info Total number of tabs to be opened in the current view of your Sublime Text 3."
}


# Print data
output_values() {
    if [ -f /opt/sublime_text/sublime_text -a -x /opt/sublime_text/sublime_text ]; then
        if pidof sublime_text >/dev/null 2>/dev/null; then
            subl --background --command number_tabs
            nb="$(number_of_tabs)"
        fi
    fi
    echo "${nb:-st3_tabs.value 0}"
}

# Acquire data
number_of_tabs() {
    if [ -f /tmp/number_tabs.py.output.txt ]; then
        cat /tmp/number_tabs.py.output.txt
    else
        printf "st3_tabs.value 0"
    fi
}


# Print help
output_usage() {
    printf >&2 "%s - munin plugin to graph the number of open tabs in Sublime Text 3\n" ${0##*/}
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
