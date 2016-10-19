#!/bin/sh
# nb_printed_documents.sh plugin for Munin
# See more plugins on https://github.com/Naereen/My-Munin-plugins/
# MIT Licensed, https://lbesson.mit-license.org/
#
# Inspired from http://guide.munin-monitoring.org/en/latest/plugin/writing.html#example-shell-plugin

# Print config
output_config() {
    echo "graph_title Printed documents today"
    echo "graph_category printer"
    # echo "graph_scale yes"
    echo "graph_info This graph shows the number of printed documents and pages every day on the system. See <a href='https://github.com/Naereen/My-Munin-plugins/'>here</a> for other plugins written by <a href='https://github.com/Naereen/'>Lilian Besson (Naereen)</a> (<a href='https://lbesson.mit-license.org/'>MIT Licensed</a>)."
    echo "graph_vlabel Number"
    echo "documents.label Documents"
    echo "documents.info This graph shows the number printed documents every day on the system."
    echo "pages.label Pages"
    echo "pages.info This graph shows the number printed pages every day on the system."
}

# Local config
# logfile="/tmp/cups_completed_jogs_log_from_munin_${$}.html"
logfile="/tmp/cups_completed_jogs_log_from_munin.html"

# Print data
output_values() {
    getlogs
    printf "documents.value %d\n" "$(number_of_documents)"
    printf "pages.value %d\n" "$(number_of_pages)"
}

# Acquire data
getlogs(){
    wget --quiet 'http://127.0.0.1:631/jobs?which_jobs=completed' -O "$logfile"
}

number_of_documents() {
    nb="$(html2text -width 1000 "$logfile" | grep -B 1 "$(date "+%a %d %b %Y")" | grep -c completed)"
    # if [ "${nb:-0}" -eq 0 ]; then
    #     nb="$(XXX other command)"
    # fi
    echo "${nb:-0}"
}

number_of_pages() {
    nb=$(html2text -width 1000 "$logfile" | grep -B 1 "$(date "+%a %d %b %Y")" | grep completed | awk ' { print $3 }' | grep -o "[0-9]*" | python -c 'import sys; print(sum(map(int, sys.stdin)))')
    # if [ "${nb:-0}" -eq 0 ]; then
    #     nb="$(XXX other command)"
    # fi
    echo "${nb:-0}"
}

# Print help
output_usage() {
    printf >&2 "%s - munin plugin to graph the number of documents and pages printed every day\n" ${0##*/}
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
