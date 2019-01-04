# Issue Guidelines

This page discusses how to open issues, including the policies and procedures of the Jellyfin project around handling issues.

Issues should detail one of three things:

   1. A software bug with Jellyfin.
   1. A feature request or suggestion.
   1. A task to be done with Jellyfin.

All other discussions, including initial troubleshooting, should be directed towards [our help channels](/user-docs/getting-help).

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

Bugs should be tagged with `[bug]` at the beginning of their title. This will later be removed by the Jellyfin team when assigning labels. To assist in triaging, if you know which other [label(s)](/developer-docs/issues#issue-labels) should be applied to your issue, please add them after the `[bug]` label.

Bugs should be reproduceable. That is, you should be able to have determined through troubleshooting how to replicate the issue. While one-time bugs shouldn't be ignored, if they're difficult or impossible to reproduce, it's likely very hard to fix them. Please attempt to reproduce the bug before filing the issue, and include the smallest test case you can to demonstrate it.

If you ever need assistance for troubleshooting or opening an issue, please [contact the community](/user-docs/getting-help) and we'll try to help you out!

### Requesting features

When writing a feature issue, please note that we distinguish between new features, tagged with `[feature]`, and enhancements to existing features, tagged with `[enhancement]`. Enhancement issues should be reserved only for modifications to existing functionality or features, with a default towards the `[feature]` tag.

When requesting a feature, please include details about what you want to achieve with the feature, including a usecase if possible. This not only helps the Jellyfin team gauge how possible the issue is, but also helps other community members understand what you want to acheieve so that they can agree with it via the [upvote system](/developer-docs/issues#Searching-for-issues-and-upvoting).

Features are not explicitly prioritized; they are worked by those in the community who are able to and are interested. However community desire for a feature can greatly affect this, so ensure you upvote any features you are interested in seeing, or are interested in working on. Developers who are interested in taking on a feature requests should update the issue to indicate as much, and just as importantly indicate if they *stop* wanting to work on the feature - this helps avoid the appearance of ownership that doesn't exist.

Enhancements are smaller than features, and often involve small tweaks to existing functionality. They should be requested in the same way as other features and with the same details, including a description of how the functionality should appear after the tweak, and how it functions now. This helps steer discussion on how to make the enhancement.

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
* `enhancement`: An issue that requests a modification of an existing feature.
* `feature`: An issue that requests a new feature not present in Jellyfin.

### Management Labels

These labels help assist in managing the project and direction:

* `Good first issue`: Something that should be very straightforward to do, and is a great place to get started.
* `help wanted`: An issue that currently has no clear expert within the project and could use outside assistance.
* `roadmap`: A meta-issue related to the future roadmap of the project.
* `documentation`: An issue related to the documentation of the project.
* `fork`: An issue related to the forking from Emby.

### PR Labels

These labels apply only to Pull Requests for administrative purposes:

* `WIP`: A Work-in-progress PR that is not yet ready to be merged, usually blocked by further work from the contributor or a testing requirement.
* `requires testing`: A PR that has not been tested in a live environment yet. Any major backend-affecting PRs should be tested before being merged to avoid regressions.

