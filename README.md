<h1 align="center">Jellyfin Documentation</h1>
<h3 align="center">Part of the <a href="https://jellyfin.media">Jellyfin Project</a></h3>

This repository houses all documentation for Jellyfin available at [jellyfin.org](https://docs.jellyfin.org/) and written in markdown.

# Contributing

The site is built with [DocFX](https://dotnet.github.io/docfx/) using [DocFX Flavored Markdown](https://dotnet.github.io/docfx/spec/docfx_flavored_markdown.html). See the content section [here](https://dotnet.github.io/docfx/tutorial/docfx_getting_started.html) for a quick tutorial on DocFX.

Since the site is mostly written with simple Markdown files, the easiest and fastest way to contribute is to just edit the source files directory on GitHub. For example, you could edit this README page by going to its [edit page](https://github.com/jellyfin/jellyfin-docs/edit/master/README.md) on GitHub.

Editing directly on GitHub provides a feature to preview your changes for the current document, but if you want to see your changes within the context of the actual website or make more advanced changes to the site, you will need to run a copy of the site locally.

To run the site locally, you can start by following the instructions to install DocFx as a [command line tool](https://dotnet.github.io/docfx/tutorial/docfx_getting_started.html#2-use-docfx-as-a-command-line-tool). Once installed, you can run the following command from the repository root directory.

```bash
docfx --serve
```

This will build the site and start up a development server to test out your changes available at http://localhost:8080.

# Layout

The following sections explain the documentation content available for each area of the site.

## Plugin API

Describe all available API surfaces and class from plugin development.

## ApiSpec

`apispec` is used to overwrite specific plugin API page contexts.

## Docs

`docs` is the main custom documentation directory.
All uids for the custom documentation are relative to this directory, with `administration` and `contributing` shortened to `admin` and `contrib` respectively.
So for example to reference the file `general/administration/installing.md` one would use `xref:admin-installing` with an optional anchor like `xref:admin-installing#arch`.

### Administration

Should be used for documentation related to server setup including non-default configs for more advanced users.

### Contributing

Should be used for documentation related to development, translations, releases, and other ways to contribute to the project.

### Clients

Any documentation related to the clients.

### Server

Any documentation related to managing the server or explaining certain features.

#### Media

Naming conventions for all supported media types, such as movies or podcasts.

#### Plugin

Any plugin documentation.
