---
uid: contrib-issues
title: GitHub Issues
---

# Requesting Features

Feature and enhancement requests should be directed towards [our Fider intance](https://features.jellyfin.org) for tracking, voting, and reporting. Please keep all feature requests to this page and not the GitHub issues.

# Issue Guidelines

This page discusses how to open issues, including the policies and procedures of the Jellyfin project around handling issues.

Issues should detail software bug reports **only**.

All other discussions, including initial troubleshooting, should be directed towards [our help channels](xref:getting-help).

## Searching for issues and upvoting

Before opening an issue, please [search the existing issues](https://github.com/jellyfin/jellyfin/issues?utf8=✓&q=is%3Aissue) to see if a similar problem or feature request has been reported. Duplicate issues clutter the repository and should be avoided.

If you do find an issue that matches, or closely matches, your issue, please make use of the :+1: reaction to confirm the issue also affects you or that you support the feature request. If you wish, add a comment as well describing your version of the issue or feature usecase.

If the existing issue is closed, please read through it to see if the accepted workaround(s) apply to your case. If not, leave a comment and the issue will be reopened. Note that, since PRs go into `dev` first but releases are built from `master`, an issue's fix won't be immediately available in the official sources, but will be included in the next release.

## Opening an issue

Once you're ready to open an issue, please [see this page](https://github.com/jellyfin/jellyfin/issues/new)!

### Reporting bugs

When writing an bug issue, please ensure you capture as much relevant detail as possible - this is very important to assist in troubleshooting and triaging/investigating the issue. Some useful elements include:

* How you installed Jellyfin (upgrade/fresh install)

* What platform and operating system you're using (Debian, Arch, Docker, etc.)

* What you were doing that caused the error or issue to appear

* Any relevant log output

* Any non-standard configurations you use

Bugs should be tagged with `[bug]` at the beginning of their title. This will later be removed by the Jellyfin team when assigning labels. To assist in triaging, if you know which other [label(s)](xref:contrib-issues#issue-labels) should be applied to your issue, please add them after the `[bug]` label.

Bugs should be reproduceable. That is, you should be able to have determined through troubleshooting how to replicate the issue. While one-time bugs shouldn't be ignored, if they're difficult or impossible to reproduce, it's likely very hard to fix them. Please attempt to reproduce the bug before filing the issue, and include the smallest test case you can to demonstrate it.

If you ever need assistance for troubleshooting or opening an issue, please [contact the community](xref:getting-help) and we'll try to help you out!

## Issue Labels

Jellyfin features a number of issue labels to assist in triaging and managing issues. Users cannot assign these themselves due to GitHub's permissions; they will be added by an administrative team member during triaging.

### Category Labels

These first three labels are broad categories for which part of Jellyfin the issue affects:

* `UI`: An issue that mainly relates to the UI frontend code.
* `Backend`: An issue that mainly relates to the server backend code.
* `build/platform`: An issue that mainly relates to building or packaging the project.
                                                     
### Criticality Labels
                                                                                
These labels help determine how critical an issue is:

* `regression`: An issue in need of immediate attention due to a regression from the last build.
* `bug`: A bug in the code that affects normal usage.

### Management Labels

These labels help assist in managing the project and direction:

* `Good first issue`: Something that should be very straightforward to do, and is a great place to get started.
* `help wanted`: An issue that currently has no clear expert within the project and could use outside assistance.
* `roadmap`: A meta-issue related to the future roadmap of the project.
* `documentation`: An issue related to the documentation of the project.
* `fork`: An issue related to the forking from Emby.
* `investigation`: An investigation-type issue into the codebase.

### PR Labels

These labels apply only to Pull Requests for administrative purposes:

* `WIP`: A Work-in-progress PR that is not yet ready to be merged, usually blocked by further work from the contributor or a testing requirement.
* `requires testing`: A PR that has not been tested in a live environment yet. Any major backend-affecting PRs should be tested before being merged to avoid regressions.
