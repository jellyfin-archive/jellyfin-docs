---
uid: admin-configuration
title: Configuration
---

# Configuration

There are several entry points available for administrators to manage the configuration of their Jellyfin server. This section aims to outline all those configuration methods, explain what configuration options are available, and what each option does.

Note that the configuration options here are distinct from the [runtime settings](xref:server-settings) available from the Administrator Dashboard in the web client. The configuration options here are generally meant to be static and set before starting the server.

## Command Line Options

Documentation for the available command line options can be obtained by adding the `--help` flag when running the Jellyfin executable.

## Server Paths

The file paths used by the server are determined according the rules outline below. In general, the [XDG specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html) is followed by default for non-Windows systems.

### Data Directory

This is the directory that will hold all Jellyfin data, and is also used as a default base directory for some other paths below. It is set from the following sources in order of decreasing precedence:

1. Command line option `--datadir`, if specified
2. Environment variable `JELLYFIN_DATA_DIR`, if specified
3. `<%APPDATA%>/jellyfin`, if running on Windows
4. `$XDG_DATA_HOME/jellyfin`, if `$XDG_DATA_HOME` exists
4. `$HOME/.local/share/jellyfin`

### Configuration Directory

This is the directory containing the server configuration files. It is set from the following sources in order of decreasing precedence:

1. Command line option `--configdir`, if specified
2. Environment variable `JELLYFIN_CONFIG_DIR`, if specified
3. `<Data Directory>/config`, if it exists or if running on Windows
4. `$XDG_CONFIG_HOME/jellyfin` if `$XDG_CONFIG_HOME` exists
5. `$HOME/.config/jellyfin`

### Cache Directory

This is the directory containing the server cache. It is set from the following sources in order of decreasing precedence:

1. Command line option `--cachedir`, if specified
2. Environment variable `$JELLYFIN_CACHE_DIR`, if specified
3. `<Data Directory>/cache`, if Windows
4. `$XDG_CACHE_HOME/jellyfin` if `$XDG_CACHE_HOME` exists
5. `$HOME/.cache/jellyfin`

### Web Directory

This is the directory containing the built files of the [web client](https://github.com/jellyfin/jellyfin-web). Note that this setting is not used if the server is configured to not host the web client. It is set from the following sources in order of decreasing precedence:

1. Command line option `--webdir`, if specified
2. Environment variable `$JELLYFIN_WEB_DIR`, if specified
3. `<Binary Directory>/jellyfin-web`, where `<Binary Directory>` is the directory containing the Jellyfin executable

### Log Directory

This is the directory where the Jellyfin logs will be stored. It is set from the following sources in order of decreasing precedence:

1. Command line option `--logdir`, if specified
2. Environment variable `$JELLYFIN_LOG_DIR`, if specified
3. `<Data Directory>/log`

## Main Configuration

The main server configuration is built upon the ASP .NET [configuration framework](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/configuration/?view=aspnetcore-3.1), which provides a tiered approach to loading configuration. The base directory to locate the configuration files is set using the [configuration directory](#configuration-directory) setting. The configuration sources are as follows, with later sources having higher priority (overwriting the values in earlier sources):

1. **Hard-coded default values**: These defaults are specified specified in the Jellyfin [source code](https://github.com/jellyfin/jellyfin/blob/master/Emby.Server.Implementations/ConfigurationOptions.cs) and cannot be changed.
2. **Default logging configuration file** (`logging.default.json`): This file should not be modified manually by users. It is reserved by the server to be overwritten with new settings on each new release.
3. **System-specific logging configuration file** (`logging.json`): This is the file you should change if you want to have a custom logging setup. Jellyfin uses the [Serilog](https://serilog.net/) logging framework, and you can read about the configuration options available in their [documentation](https://github.com/serilog/serilog-settings-configuration). Note that this file can be changed at runtime, which will automatically reload the configuration and apply the changes immediately.
4. **Environment Variables**: The [documentation](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/configuration/?view=aspnetcore-3.1#environment-variables) provided by Microsoft explains how to set these configuration options via environment variables. Jellyfin uses its own custom `JELLYFIN_` prefix for these variables. For example, to set a value for the `HttpListenerHost:DefaultRedirectPath` setting, you would set a value for the `JELLYFIN_HttpListenerHost__DefaultRedirectPath` environment variable.
5. **Command line options**: Certain command line options are loaded into the configuration system and have the highest priority. The following command line options are mapped to associated configuration options:

    - The `--nowebcontent` command line flag sets the `hostwebclient` configuration setting to false

### Main Configuration Options

This section lists all the configuration options available and explains their function.

|Key|Value|
|---|-----|
|`hostwebclient`|Set to `True` if the server should host the web client, otherwise `False`|
|`FFmpeg:probesize`|The FFmpeg probe size|
|`FFmpeg:analyzeduration`|The FFmpeg analyze duration|
|`playlists:allowDuplicates`|Whether playlists should allow duplicate items. When false, duplicates will be automatically filtered out when adding items to playlists.|
