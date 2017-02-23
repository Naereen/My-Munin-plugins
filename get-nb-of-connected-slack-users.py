#! /usr/bin/env python2
# -*- coding: utf-8; mode: python -*-
""" Small script to connect to a Slack team and get the number of connected users.

Requirements:
- slackclient, cf. documentation https://api.slack.com/methods

About:
- *Date:* 23/02/2017.
- *Author:* Lilian Besson, (C) 2017
- *Licence:* MIT Licence (http://lbesson.mit-license.org).
"""

from __future__ import print_function, division  # Python 2 compatibility if needed

import sys

from slackclient import SlackClient

# --- Parameters of the bot

SLACK_TOKEN = open(".slack_api_key", 'r').readline().strip()

URL = "https://github.com/Naereen/My-Munin-plugins/tree/master/get-nb-of-connected-slack-users.py"


# --- API calls

def get_nb_channels(sc):
    """Get number of channels, using https://api.slack.com/methods/channels.list"""
    response = sc.api_call(
        "channels.list",
    )
    return len(response['channels']) if response['ok'] else 0


def get_nb_users(response):
    """Get number of users, using https://api.slack.com/methods/users.list"""
    return len(response['members']) if response['ok'] else 0


def get_nb_active_users(sc, response):
    """Get number of active users, using https://api.slack.com/methods/users.getPresence"""
    if not response['ok']:
        return 0
    users = [m['id'] for m in response['members']]
    nb = 0
    for user in users:
        response = sc.api_call(
            "users.getPresence"
        )
        if response['ok'] and response['presence'] == 'active':
            nb += 1
    return nb


def get_nb_usergroups(sc):
    """Get number of users, using https://api.slack.com/methods/usergroups.list"""
    response = sc.api_call(
        "usergroups.list"
    )
    return len(response['usergroups']) if response['ok'] else 0


def get_nb_groups(sc):
    """Get number of users, using https://api.slack.com/methods/groups.list"""
    response = sc.api_call(
        "groups.list"
    )
    return len(response['groups']) if response['ok'] else 0


# --- Main function

def main():
    """Main program."""
    # Get list of quotes and parameters
    sc = SlackClient(SLACK_TOKEN)
    # Start loop
    nb_channels = get_nb_channels(sc)
    print("channels.value", nb_channels)
    response = sc.api_call(
        "users.list"
    )
    nb_users = get_nb_users(response)
    print("users.value", nb_users)
    # nb_active_users = get_nb_active_users(sc, response)
    # print("activeusers.value", nb_active_users)
    nb_usergroups = get_nb_usergroups(sc)
    print("usergroups.value", nb_usergroups)
    nb_groups = get_nb_groups(sc)
    print("groups.value", nb_groups)
    return 0


# --- Main script

if __name__ == '__main__':
    sys.exit(main())

# End of my-small-slack-bot.py
