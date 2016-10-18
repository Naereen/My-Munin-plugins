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

For instance, if you want to intall the plugin [`number_of_plugins.sh`](https://github.com/Naereen/My-Munin-plugins/tree/master/number_of_plugins.she), then in the good folder (see step 1) do:

```bash
# Be sure it is executable
chmod 755 number_of_plugins.sh  # By default they should all be executable
# Then symlink it to /etc/munin/plugins/
sudo ln -s ${PWD}/number_of_plugins.sh /etc/munin/plugins/plugins
```

You can (and should) then check that the plugin works:

```bash
$ munin-run nb_of_plugins  # Gives the number of plugin currently activated
plugins.value 30
```

You can repeat these two steps for every plugins you want to install.

----

## List of plugins
> TODO

----

## Wishlist for future plugins
I would like to be able to use [Munin](http://www.munin-monitoring.org/) to monitor:

- [ ] number of documents and number of pages printed by my laptop. Should already be available from [this list](http://gallery.munin-monitoring.org/printing-index.html)!
- [ ] number of songs played by my music player [GMusicBrowser](http://gmusicbrowser.org) ([by @squentin](https://github.com/squentin/gmusicbrowser/)),
- [ ] number of open tabs in [tmux](https://tmux.github.io/), [Sublime Text 3](https://www.sublimetext.com/3dev) and [Firefox](https://www.mozilla.org/en-US/firefox/central/),
- [ ] volume of the main sound card,
- [ ] number of USB peripherics connected?
- [ ] local [weather](https://github.com/munin-monitoring/contrib/tree/master/plugins/weather/), or temperature of my home.

----

## :notebook: References ?
- For more details on [Munin](http://www.munin-monitoring.org/), see the official website, http://www.munin-monitoring.org/, and the documentation, http://guide.munin-monitoring.org/.
- A good introductory page is [plugin/writing.html](http://guide.munin-monitoring.org/en/latest/plugin/writing.html) on [the new Munin guide](http://guide.munin-monitoring.org/en/latest/).
- Fore more details on Munin plugins, see first [this page (wiki/plugins)](http://munin-monitoring.org/wiki/plugins), then if needed the pages [PluginShell](http://munin-monitoring.org/wiki/PluginShell), or [PluginConcise](http://munin-monitoring.org/wiki/PluginConcise) or [HowToWritePlugins](http://munin-monitoring.org/wiki/HowToWritePlugins) on [the Munin wiki](http://munin-monitoring.org/wiki/).

## :scroll: License ? [![GitHub license](https://img.shields.io/github/license/Naereen/My-Munin-plugins.svg)](https://github.com/Naereen/My-Munin-plugins/blob/master/LICENSE)
[MIT Licensed](https://lbesson.mit-license.org/) (file [LICENSE.txt](LICENSE.txt)).
© [Lilian Besson](https://GitHub.com/Naereen), 2016.

[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://GitHub.com/Naereen/My-Munin-plugins/graphs/commit-activity)
[![Ask Me Anything !](https://img.shields.io/badge/Ask%20me-anything-1abc9c.svg)](https://GitHub.com/Naereen/ama)
[![Analytics](https://ga-beacon.appspot.com/UA-38514290-17/github.com/Naereen/My-Munin-plugins/README.md?pixel)](https://GitHub.com/Naereen/My-Munin-plugins/)

[![ForTheBadge built-with-swag](http://ForTheBadge.com/images/badges/built-with-swag.svg)](https://GitHub.com/Naereen/)

[![ForTheBadge uses-badges](http://ForTheBadge.com/images/badges/uses-badges.svg)](http://ForTheBadge.com)
[![ForTheBadge uses-git](http://ForTheBadge.com/images/badges/uses-git.svg)](https://GitHub.com/)
