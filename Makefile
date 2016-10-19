#!/usr/bin/make
# Small Makefile to run quickly some commands to debug Munin plugins
# See my plugins on https://github.com/Naereen/My-Munin-plugins/
# MIT Licensed, https://lbesson.mit-license.org/
#

# DEBUG each scripts
tmux:
	@echo "\n\n# Munin config for 'tmux' plugin:"
	munin-run tmux config
	@echo "\n\n# Output for 'tmux' plugin:"
	munin-run tmux

nb_of_plugins:
	@echo "\n\n# Munin config for 'nb_of_plugins' plugin:"
	munin-run nb_of_plugins config
	@echo "\n\n# Output for 'nb_of_plugins' plugin:"
	munin-run nb_of_plugins

gui_windows:
	@echo "\n\n# Munin config for 'gui_windows' plugin:"
	munin-run gui_windows config
	@echo "\n\n# Output for 'gui_windows' plugin:"
	munin-run gui_windows

# DEBUG Munin
restart:
	/etc/init.d/munin-node restart

replot:
	sudo -u munin /usr/bin/munin-cron

check:
	munin-check