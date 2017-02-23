#!/usr/bin/make
# Small Makefile to run quickly some commands to debug or install Munin plugins
# See my plugins on https://github.com/Naereen/My-Munin-plugins/
# MIT Licensed, https://lbesson.mit-license.org/
#

# DEBUG all scripts
test: test__tmux test__nb_of_plugins test__gui_windows test__printed_docs test__slack_stats

# DEBUG each scripts
test__tmux:
	@echo "\n\n# Munin config for 'tmux' plugin:"
	sudo -u munin munin-run tmux config
	@echo "\n\n# Output for 'tmux' plugin:"
	sudo -u munin munin-run tmux

test__nb_of_plugins:
	@echo "\n\n# Munin config for 'nb_of_plugins' plugin:"
	sudo -u munin munin-run nb_of_plugins config
	@echo "\n\n# Output for 'nb_of_plugins' plugin:"
	sudo -u munin munin-run nb_of_plugins

test__gui_windows:
	@echo "\n\n# Munin config for 'gui_windows' plugin:"
	sudo -u munin munin-run gui_windows config
	@echo "\n\n# Output for 'gui_windows' plugin:"
	sudo -u munin munin-run gui_windows

test__printed_docs:
	@echo "\n\n# Munin config for 'printed_docs' plugin:"
	sudo -u munin munin-run printed_docs config
	@echo "\n\n# Output for 'printed_docs' plugin:"
	sudo -u munin munin-run printed_docs

test__st3_tabs:
	@echo "\n\n# Munin config for 'st3_tabs' plugin:"
	sudo -u munin munin-run st3_tabs config
	@echo "\n\n# Output for 'st3_tabs' plugin:"
	sudo -u munin munin-run st3_tabs

test__slack_stats:
	@echo "\n\n# Munin config for 'slack_stats' plugin:"
	sudo -u munin munin-run slack_stats config
	@echo "\n\n# Output for 'slack_stats' plugin:"
	sudo -u munin munin-run slack_stats


# Install all my plugins
install: install__tmux install__nb_of_plugins install__gui_windows install__printed_docs test__slack_stats

install__tmux:
	@echo "\nInstalling 'tmux.sh' as 'tmux' ..."
	sudo ln -s `pwd`/tmux.sh /etc/munin/plugins/tmux

install__nb_of_plugins:
	@echo "\nInstalling 'number_of_plugins.sh' as 'nb_of_plugins' ..."
	sudo ln -s `pwd`/number_of_plugins.sh /etc/munin/plugins/nb_of_plugins

install__gui_windows:
	@echo "\nInstalling 'gui_windows.sh' as 'gui_windows' ..."
	sudo ln -s `pwd`/gui_windows.sh /etc/munin/plugins/gui_windows

install__printed_docs:
	@echo "\nInstalling 'nb_printed_documents.sh' as 'printed_docs' ..."
	sudo ln -s `pwd`/nb_printed_documents.sh /etc/munin/plugins/printed_docs

install__st3_tabs:
	@echo "\nInstalling 'number_st3_tabs.sh' as 'st3_tabs' ..."
	sudo ln -s `pwd`/number_st3_tabs.sh /etc/munin/plugins/st3_tabs

install__slack_stats:
	@echo "\nInstalling 'get-nb-of-connected-slack-users.sh' as 'slack_stats' ..."
	sudo ln -s `pwd`/get-nb-of-connected-slack-users.sh /etc/munin/plugins/slack_stats


# DEBUG Munin
restart:
	/etc/init.d/munin-node restart

munin-log:
	watch "tail -n 40 /var/log/munin/munin-node.log"

plot:
	sudo -u munin /usr/bin/munin-cron

check:
	munin-check
