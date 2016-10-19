# My own plugins for [Munin](http://www.munin-monitoring.org/)

This small repository contains some tiny plugins (written in [Bash](https://www.gnu.org/software/bash/) or [Python](https://www.python.org/)), for the [Munin](http://www.munin-monitoring.org/) monitoring tool.

Despite a [very rich plugin collection](http://gallery.munin-monitoring.org/), I found some that could be missing to someone (well, at least to me), so I decided to write them.
See below for a list of the plugins I wrote (tiny, and probably bugged), and how to install them.

----

## How to install them?
### 1. First clone the repo
In a classic Ubuntu or Debian Linux environment, with [Munin](http://www.munin-monitoring.org/) correctly installed with the default folder configuration, the following commands will [git clone](https://help.github.com/articles/cloning-a-repository/) my repository:

```bash
cd ~/.local/etc/munin/    # A certain directory, you can use some place else
git clone https://github.com/Naereen/My-Munin-plugins ./My-Munin-plugins.git/  # Clone my repo
cd ./My-Munin-plugins.git/  # Go to this directory
```

### 2. Then [install or activate the plugins](http://munin-monitoring.org/wiki/faq#Q:Howdoyouinstallaplugin) you want
Then, pick the plugins you like in [this folder](https://github.com/Naereen/My-Munin-plugins/tree/master/), and [install them or activate them](http://guide.munin-monitoring.org/en/latest/plugin/writing.html#activating-the-plugin).

For instance, if you want to intall the plugin [`number_of_plugins.sh`](https://github.com/Naereen/My-Munin-plugins/tree/master/number_of_plugins.sh), then in the good folder (see step 1) do:

```bash
# Be sure it is executable
chmod 755 number_of_plugins.sh  # By default they should all be executable
# Then symlink it to /etc/munin/plugins/
sudo ln -s ${PWD}/number_of_plugins.sh /etc/munin/plugins/nb_of_plugins
```

You can (and should) then check that the plugin works:

```bash
$ munin-run nb_of_plugins  # Gives the number of plugin currently activated
plugins.value 34
myplugins.value 5
```

You can repeat these two steps for every plugins you want to install.

*Note:* you can also use the provided [`Makefile`](https://github.com/Naereen/My-Munin-plugins/tree/master/Makefile) to install one or all plugins:

```bash
make install__tmux  # Ask for sudo password and install tmux.sh to /etc/munin/plugins/tmux
make install_all    # Ask for sudo password and install all my plugins to /etc/munin/plugins/
```

----

## List of plugins
- [x] Number of open tabs, windows and panes in [tmux](https://tmux.github.io/)? **Done**, see [`tmux.sh`](https://github.com/Naereen/My-Munin-plugins/tree/master/tmux.sh), it works but works even better if `user` is well configured (see below).
- [x] Number of open graphical programs and open windows in your window manager? **Done**, see [`gui_windows.sh`](https://github.com/Naereen/My-Munin-plugins/tree/master/gui_windows.sh), it works *only* if `user` is well configured (see below).
- [x] Number of documents and number of pages printed by my laptop? **In progress**, see [`nb_printed_documents.sh`](https://github.com/Naereen/My-Munin-plugins/tree/master/nb_printed_documents.sh). FIXME Should already be available from [this list](http://gallery.munin-monitoring.org/printing-index.html)!
- [x] Number of open tabs, windows and panes in [Sublime Text 3](https://www.sublimetext.com/3dev). It was harder... I created this tiny ST3 plugin ([`number_tabs.py`](https://github.com/Naereen/My-Munin-plugins/tree/master/number_tabs.py), to install in your [`Packages/User` directory](http://docs.sublimetext.info/en/latest/basic_concepts.html#the-user-package)), in order to have a ST3 command `number_tabs`. Then the script [`number_st3_tabs.sh`](https://github.com/Naereen/My-Munin-plugins/tree/master/number_st3_tabs.sh) calls it with `subl --background --command number_tabs` from the command line... FIXME do it better!

### Required configuration
Edit your `munin-node` configuration file to specify the configuration.

Currently, [`tmux.sh`](https://github.com/Naereen/My-Munin-plugins/tree/master/tmux.sh) and [`gui_windows.sh`](https://github.com/Naereen/My-Munin-plugins/tree/master/gui_windows.sh) need to be ran from the user `$USER` (ie, you) and not `munin`:

```bash
[tmux]
user lilian   # adapt to your own username

[gui_windows]
user lilian   # adapt to your own username
```

----

## Wishlist for future plugins ?
I would like to be able to use [Munin](http://www.munin-monitoring.org/) to monitor:

- [ ] ~~Number of songs played from morning and number of songs currently in the waiting list, for my music player [GMusicBrowser](http://gmusicbrowser.org) ? ([by @squentin](https://github.com/squentin/gmusicbrowser/))~~ It seems impossible...
- [ ] ~~Number of open tabs and windows in [Firefox](https://www.mozilla.org/en-US/firefox/central/) ?~~ It seems impossible...
- [ ] Volume of the main sound card?
- [ ] Number of USB peripherics connected?
- [ ] Local [weather](https://github.com/munin-monitoring/contrib/tree/master/plugins/weather/), or temperature of my home?
- [ ] And you, do you have any other idea?

----

## :notebook: References ?
- For more details on [Munin](http://www.munin-monitoring.org/), see the official website, http://www.munin-monitoring.org/, and the documentation, http://guide.munin-monitoring.org/.
- A good introductory page is [plugin/writing.html](http://guide.munin-monitoring.org/en/latest/plugin/writing.html) on [the new Munin guide](http://guide.munin-monitoring.org/en/latest/).
- Fore more details on Munin plugins, see first [this page (wiki/plugins)](http://munin-monitoring.org/wiki/plugins), then [the reference](http://guide.munin-monitoring.org/en/latest/reference/plugin.html), and if needed the older pages [PluginShell](http://munin-monitoring.org/wiki/PluginShell), or [PluginConcise](http://munin-monitoring.org/wiki/PluginConcise) or [HowToWritePlugins](http://munin-monitoring.org/wiki/HowToWritePlugins) on [the Munin wiki](http://munin-monitoring.org/wiki/).

----

## Other [self-quantified projects](http://perso.crans.org/besson/self-quantified.en.html) ?
- [uLogMe](https://GitHub.com/Naereen/uLogMe/): keep track of your computer activity throughout the day: visualize your active window titles and the number and frequency of keystrokes, in beautiful and responsive HTML timelines.
- [`selfspy`](https://github.com/gurgeh/selfspy): log everything you do on the computer, for statistics, future reference and all-around fun. I also worked a little bit on [selfspy-vis](https://github.com/Naereen/selfspy-vis), some tools to visualize the data collected by [`selfspy`](https://github.com/gurgeh/selfspy).
- My minimalist dashboard, generated every hour (with [a `crontab` file](https://help.ubuntu.com/community/CronHowto)), with this bash script [`GenerateStatsMarkdown.sh`](https://bitbucket.org/lbesson/bin/src/master/GenerateStatsMarkdown.sh).

----

## :scroll: License ? [![GitHub license](https://img.shields.io/github/license/Naereen/My-Munin-plugins.svg)](https://github.com/Naereen/My-Munin-plugins/blob/master/LICENSE)
[MIT Licensed](https://lbesson.mit-license.org/) (file [LICENSE.txt](LICENSE.txt)).
© [Lilian Besson](https://GitHub.com/Naereen), 2016.

[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://GitHub.com/Naereen/My-Munin-plugins/graphs/commit-activity)
[![Ask Me Anything !](https://img.shields.io/badge/Ask%20me-anything-1abc9c.svg)](https://GitHub.com/Naereen/ama)
[![Analytics](https://ga-beacon.appspot.com/UA-38514290-17/github.com/Naereen/My-Munin-plugins/README.md?pixel)](https://GitHub.com/Naereen/My-Munin-plugins/)

[![ForTheBadge built-with-swag](http://ForTheBadge.com/images/badges/built-with-swag.svg)](https://GitHub.com/Naereen/)

[![ForTheBadge uses-badges](http://ForTheBadge.com/images/badges/uses-badges.svg)](http://ForTheBadge.com)
[![ForTheBadge uses-git](http://ForTheBadge.com/images/badges/uses-git.svg)](https://GitHub.com/)
