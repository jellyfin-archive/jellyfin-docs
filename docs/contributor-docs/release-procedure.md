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

* Introduces critical bugfixes or otherwise changes `master` branch code since the last release.

## General Release Philosophy

## Release procedure (major releases)

1. Announce release in the [jellyfin-dev](https://matrix.to/#/#jellyfin-dev:matrix.org) Matrix/Riot channel at least a few hours before releasing, to put a temporary freeze on merges.

1. Ensure any required PRs are merged into both the [jellyfin](https://github.com/jellyfin/jellyfin) and [jellyfin-web](https://github.com/jellyfin/jellyfin-web) repositories.

1. Create a release branch for the [jellyfin](https://github.com/jellyfin/jellyfin) and [jellyfin-web](https://github.com/jellyfin/jellyfin-web) repositories with the format `release-X.Y.Z`, where `X.Y.` is the new version number and `Z` is a literal `Z` character, based off the current `master` branches. These will be somewhat long-lived branches to track particular releases and deal with hotfixes to those branches should they be required.

1. Execute the `bump_version` script inside the release branch in the [jellyfin](https://github.com/jellyfin/jellyfin) local repository. Commit the resulting differences as `Bump version to X.Y.Z`.

1. Perform initial testing builds and test the resulting binaries.

    Basic testing checklist:

    1. Run through setup wizard and import small library.  
    1. Test playback, navigation, and subtitles in the Web UI.  
    1. Test playback, navigation, and subtitles in the Chromecast app.  

1. Call to [jellyfin-dev](https://matrix.to/#/#jellyfin-dev:matrix.org) for any release-critical bug found; perform bugfix pull requests against the `release-X.Y.Z` branch.

1. Repeat the above two steps until no more RC bugs are found.

1. Perform the release.

    1. Create pull requests from release branch into `master` in both repositories.  
    1. Obtain approval from the Core team.  
    1. Merge release branch PR into `master` in `jellyfin-web`.
    1. Update submodule for `jellyfin-web` directly in release branch. Commit the resulting differences as `Update jellyfin-web submodule to X.Y.Z`, where `X.Y.Z` is the full version number.  
        `cd MediaBrowser.WebDashboard/jellyfin-web`  
        `git fetch --all`  
        `git checkout master`  
        `cd ../..`  
        `git add MediaBrowser.WebDashboard/jellyfin-web`  
        `git commit`  
    1. Merge release branch PR into `master` in `jellyfin`.
    1. Create the GitHub release and tag from release branch to facilitate future point releases.  
    1. Build new releases packages off of release branch and upload to repositories.  
    1. Announce new release in the [jellyfin-announce](https://matrix.to/#/#jellyfin-announce:matrix.org) Matrix/Riot channel and anywhere else required (e.g. Reddit, etc.).

1. Delete any previous major release branches, as all future hotfix work should go against the new release branch, or master directly for inclusion in the next major release.

## Release procedure (minor releases/hotfixes)

1. Discover a major, breaking bug in the current release which must be immediately fixed and cannot wait for the next full feature release; discuss in the [jellyfin-dev](https://matrix.to/#/#jellyfin-dev:matrix.org) Matrix/Riot channel to coordinate hotfixes.

1. Create all hotfix PRs against the *previous release branch* in either the [jellyfin](https://github.com/jellyfin/jellyfin) and [jellyfin-web](https://github.com/jellyfin/jellyfin-web) repositories; merge when completed.

1. Execute the `bump_version` script inside the release branch in the [jellyfin](https://github.com/jellyfin/jellyfin) local repository. Commit the resulting differences as `Bump version to X.Y.Z`.

1. Perform the release.

    1. Create pull requests from release branch into `master` in any required repositories.  
    1. Obtain approval from the Core team.  
    1. IF the hotfix applies to the [jellyfin-web](https://github.com/jellyfin/jellyfin-web) repository, merge release branch PR into `master` in `jellyfin-web`.
    1. IF the hotfix applies to the [jellyfin-web](https://github.com/jellyfin/jellyfin-web) repository, update submodule for `jellyfin-web` directly in the [jellyfin-web](https://github.com/jellyfin/jellyfin) release branch. Commit the resulting differences as `Update jellyfin-web submodule to X.Y.Z`, where `X.Y.Z` is the full version number.  
        `cd MediaBrowser.WebDashboard/jellyfin-web`  
        `git fetch --all`  
        `git checkout master`  
        `cd ../..`  
        `git add MediaBrowser.WebDashboard/jellyfin-web`  
        `git commit`  
    1. Merge release branch PR into `master` in `jellyfin`.
    1. Create the GitHub release and tag from release branch to facilitate future point releases. IF the hotfix did not affect the [jellyfin-web](https://github.com/jellyfin/jellyfin-web) repository, still create a new release and tag targeting the same point on the release branch to facilitate consistent versioning between the repositories; the changelog may be empty with a "new release to match main repository"-type message.
    1. Build new releases packages off of release branch and upload to repositories.  
    1. Announce new release in the [jellyfin-announce](https://matrix.to/#/#jellyfin-announce:matrix.org) Matrix/Riot channel and anywhere else required (e.g. Reddit, etc.).
