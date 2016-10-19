#! /usr/bin/env python3
# -*- coding: utf-8; mode: python -*-
""" Tiny SublimeText3 plugin to add these commands:

'number_tabs'
  - It prints the number of opened tabs
  - It is NOT binded to any key
  - It is used by an external script, a plugin for Munin. Cf. https://github.com/Naereen/My-Munin-plugins


About:

- *Date:*    2016-10-19
- *Version:* 0.0.1
- *Web:*     https://github.com/Naereen/My-Munin-plugins
- *Author:*  Lilian Besson (C) 2016
- *Licence:* MIT Licence (http://lbesson.mit-license.org)
"""

import sublime
import sublime_plugin


class NumberTabsCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        # Get the data
        nb = len(self.view.window().views())
        # Display a message
        message = "{} opened tabs".format(nb)
        self.view.window().status_message(message)
        print(message)
        # Save the data to a text file?
        filepath = "/tmp/number_tabs.py.output.txt"
        with open(filepath, 'w') as f:
            f.write("st3tabs.value {}\n".format(nb))
            print("'st3tabs.value {}' was just written to the file '{}' ...".format(nb, f))
