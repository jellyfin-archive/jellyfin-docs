# Release Procedure

This document is a Core team guide, provided publicly to ensure transparancy in the release process.

## Versioning

Jellyfin uses [semantic versioning](https://semver.org). All releases will have versions in the `X.Y.Z` format, starting from `10.0.0`. Note however that the `10.Y.Z` release chain represents the "cleanup" of the codebase, so it should be accepted that `10.Y.Z` breaks all compatibility, at some point, with previous Emby-compatible interfaces. Our versioning will typically follow the patterns below:

#### `X` - Major breaking versions

* Breaks compatibility with the HTTP and/or plugin APIs.

#### `Y` - Minor versions

* Introduces new features.
* Makes minor non-breaking API changes.

#### `Z` - Hotfix versions

* Introduces bugfixes or otherwise changes `master` branch code since the last release.

## General Release Philosophy

We will be following the guide [A successful Git branching model](https://nvie.com/posts/a-successful-git-branching-model/) for our release branching model and workflow, with GitHub-specific tweaks as required.

#### Significant deviations

* The development branch is named `dev`.

* Developers should, as described in [the contributing guidelines](/developer-docs/contributing), do feature branch work on their own forked copies of repositories.

* Standard review requirements as defined for each repo always apply.

## Release procedure

1. Announce release in the [jellyfin-dev](https://matrix.to/#/#jellyfin-dev:matrix.org) Matrix/Riot channel at least 24h before creating the release branch.

1. Ensure any required PRs are merged into both the [jellyfin](https://github.com/jellyfin/jellyfin) and [jellyfin-web](https://github.com/jellyfin/jellyfin-web) repositories.

1. Create a release branch for the [jellyfin](https://github.com/jellyfin/jellyfin) and [jellyfin-web](https://github.com/jellyfin/jellyfin-web) repositories with the format `release-X.Y.Z`, where `X.Y.Z` is the new version number, based off the current `dev` branches.

1. Execute the `bump_version` script inside the release branch in the [jellyfin](https://github.com/jellyfin/jellyfin) local repository. Commit the resulting differences as `Bump version to X.Y.Z`.

1. Perform initial testing builds and test the resulting binaries.

    Basic testing checklist:
    1. Run through setup wizard and import small library.
    1. Test playback, navigation, and subtitles in the Web UI.
    1. Test playback, navigation, and subtitles in the Chromecast app.

1. Call to [jellyfin-dev](https://matrix.to/#/#jellyfin-dev:matrix.org) for any release-critical bug found; perform bugfix pull requests against the `release-X.Y.Z` branch.

1. Perform final testing builds and test the resulting binaries.

1. Perform the release.

    1. Create pull requests from release branch into `master` in both repositories.
    1. Obtain approval from the Core team.
    1. Merge release branch PR into `master` in both repositories.
    1. Merge `master` into `dev` via local CLI and push (no PR) in both repositories.
    1. Delete the release branch.
    1. Create the GitHub release and tag from `master`.
    1. Build new releases packages off of `master`.
