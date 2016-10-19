#!/usr/bin/make
# Small Makefile to run quickly some commands to debug Munin plugins
# See my plugins on https://github.com/Naereen/My-Munin-plugins/
# MIT Licensed, https://lbesson.mit-license.org/
#

# DEBUG each scripts
tmux:
	@echo "\n\n# Munin config for 'tmux' plugin:"
	@sudo -u munin munin-run tmux config
	@echo "\n\n# Output for 'tmux' plugin:"
	@sudo -u munin munin-run tmux

nb_of_plugins:
	@echo "\n\n# Munin config for 'nb_of_plugins' plugin:"
	@sudo -u munin munin-run nb_of_plugins config
	@echo "\n\n# Output for 'nb_of_plugins' plugin:"
	@sudo -u munin munin-run nb_of_plugins

gui_windows:
	@echo "\n\n# Munin config for 'gui_windows' plugin:"
	@sudo -u munin munin-run gui_windows config
	@echo "\n\n# Output for 'gui_windows' plugin:"
	@sudo -u munin munin-run gui_windows

printed_docs:
	@echo "\n\n# Munin config for 'printed_docs' plugin:"
	@sudo -u munin munin-run printed_docs config
	@echo "\n\n# Output for 'printed_docs' plugin:"
	@sudo -u munin munin-run printed_docs

# DEBUG Munin
restart:
	/etc/init.d/munin-node restart

taillog:
	watch "tail /var/log/munin/munin-node.log"

replot:
	@sudo -u munin /usr/bin/munin-cron

check:
	munin-check
