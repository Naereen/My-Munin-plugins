#!/bin/sh
# number_of_plugins.sh plugin for Munin
# See more plugins on https://github.com/Naereen/My-Munin-plugins/
#
# From http://guide.munin-monitoring.org/en/latest/plugin/writing.html#example-shell-plugin

# Print config
output_config() {
    echo "graph_title Munin plugins"
    echo "graph_category munin"
    echo "graph_scale no"
    echo "graph_vlabel Number of plugins"
    echo "graph_info This graph shows the number of munin plugins being installed on the system."
    echo "plugins.label All plugins"
    echo "plugins.info Total number of plugins to be installed. Includes default and custom plugins."
    echo "myplugins.label Homemade plugins"
    echo "myplugins.info Number of plugins installed as links to .git repository. Still experimental. Includes only custom plugins."
}

# Print data
output_values() {
    printf "plugins.value %d\n" $(number_of_plugins)
    printf "myplugins.value %d\n" $(number_of_my_plugins)
}

# Acquire data
number_of_plugins() {
    find /etc/munin/plugins -type l | wc -l
}

# XXX remove this useless line
number_of_my_plugins() {
    ls -larth /etc/munin/plugins | grep '.git' | wc -l
}

# Print help
output_usage() {
    printf >&2 "%s - munin plugin to graph the number of loaded plugins\n" ${0##*/}
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
