#!/bin/bash
# get-nb-of-connected-slack-users.sh plugin for Munin
# See more plugins on https://github.com/Naereen/My-Munin-plugins/
# Require https://github.com/Naereen/My-Munin-plugins/tree/master/get-nb-of-connected-slack-users.py
#
# From http://guide.munin-monitoring.org/en/latest/plugin/writing.html#example-shell-plugin

cd "$( dirname "${BASH_SOURCE[0]}" )"

# Print config
output_config() {
    echo "graph_title Slack stats"
    echo "graph_category Slack"
    echo "graph_scale no"
    echo "graph_vlabel Number of"
    echo "graph_info This graph shows the number of users, channels, groups of a Slack team. See <a href='https://github.com/Naereen/My-Munin-plugins/'>here</a> for other plugins written by <a href='https://github.com/Naereen/'>Lilian Besson (Naereen)</a> (<a href='https://lbesson.mit-license.org/'>MIT Licensed</a>)."
    # Legend for the graphs
    echo "channels.label Number of channels"
    echo "channels.info Call the Slack API for our <a href='https://sceeteam.slack.com/'>SCEE team</a> to get the number of channels"
    echo "users.label Number of users"
    echo "users.info Call the Slack API for our <a href='https://sceeteam.slack.com/'>SCEE team</a> to get the number of users"
    # echo "activeusers.label Number of active users"
    # echo "activeusers.info Call the Slack API for our <a href='https://sceeteam.slack.com/'>SCEE team</a> to get the number of channels"
    echo "usergroups.label Number of user groups"
    echo "usergroups.info Call the Slack API for our <a href='https://sceeteam.slack.com/'>SCEE team</a> to get the number of user groups"
    echo "groups.label Number of groups"
    echo "groups.info Call the Slack API for our <a href='https://sceeteam.slack.com/'>SCEE team</a> to get the number of groups"
}

# Print data
output_values() {
    [ -L "${BASH_SOURCE[0]}" ] && cd "$(dirname "$(file "${BASH_SOURCE[0]}" | awk '{ print $5 }')")"
    ./get-nb-of-connected-slack-users.py
}


# Print help
output_usage() {
    printf >&2 "%s - munin plugin to display the number of users, channels, groups of a Slack team\n" ${0##*/}
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
