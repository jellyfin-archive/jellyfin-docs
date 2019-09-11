# Contributing to Jellyfin

Thank you for your interest in contributing to the Jellyfin project! This page and its children desribe the ways you can contribute, as well as some of our policies. This should help guide you through your first Issue or PR.

Even if you can't contribute code, you can still help Jellyfin! The two main things you can help with are testing and creating Issues, and contributing to documentation, translations, and other non-code components.

## Issues

We use GitHub Issues extensively to track open problems, new enhancements or features, and other aspects of the development of Jellyfin.

Please see the [getting help](/user-docs/getting-help) page for help with troubleshooting and finding bugs, and the [documentation on Issues](/contributor-docs/issues) for more information on how to submit good Issues.

## Code

The entire project consists of a C# core server, a Javascript web client, and a number of other clients written in various languages and frameworks. If you have experience with these languages, we're always grateful for any contributions you might want to make!

For general guidelines on how the project works, including how to set up your development copy, make changes, and guidelines on Pull Requests (PRs), please see the [documentation on contributing code](/contributor-docs/contributing-code). Jellyfin follows a "fork and PR" methodology; if you're not familiar with this, please see the [relevant section](/contributor-docs/contributing-code#set-up-your-copy-of-the-repo).

## Documentation

Documentation is incredibly helpful! All these docs are written using `mkdocs` via [readthedocs.io](https://readthedocs.io). You can find the raw markdown in the [documentation repository](https://github.com/jellyfin/jellyfin-docs). Pull requests are welcome!

## Translations

If you're interested in helping to translate Jellyfin into your local language, we use [Weblate](https://weblate.org/en/) running at [translate.jellyfin.org](https://translate.jellyfin.org) to handle translations. These are collected in the `translations` branchs of the various repositories and are merged into the `master` branches before each release.

## Testing

Testing is the easiest way to contribute. Simply use Jellyfin, and if you run into problems, [let us know](/user-docs/getting-help). This is the most common way we uncover bugs, through a user doing something we hadn't thought about. If the issue does end up being related to the code, a [bug issue](/contributor-docs/issues#reporting-bugs) can then be opened.
