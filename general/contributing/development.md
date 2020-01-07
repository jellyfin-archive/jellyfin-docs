---
uid: contrib-development
title: Development
---

# How to contribute code to Jellyfin

This page details how our repositories are organized, how to get started editing the code and creating your first pull request, and some general procedures around pull requests in Jellyfin.

## What should you work on?

The best way to get going is to look through the [Issues list](https://github.com/jellyfin/jellyfin/issues), find an issue you would like to work on, and start hacking. Issues are triaged regularly by the administrative team, and labels assigned that should help you find issues within your skill-set. Once you start working on an issue, please comment on it stating your intent to work on the issue, to avoid unnecessary duplication of work.

### Major Issue Types

A list of issue types can be found on the [Issue guidelines](xref:contrib-issues#issue-labels) page.

### What if there isn't an issue?

If there isn't already an issue dealing with the changes you want to make, please [create an issue](xref:contrib-issues) to track it first, then ensure your PR(s) reference the issue in question. This is especially useful for bugs that are found and then fixed by the author, so both the original issue and the fix can be documented and tracked in detail.

## How should you make changes?

Once you've found something you want to work on or improve, the next step is to make your changes in the code, test them, then submit a Pull Request (PR) on GitHub.

For simplicity, all examples assume the developer is operating on Linux with SSH access to GitHub, however the general ideas can be applied to HTTP-based GitHub interfaces, and can be translated to Windows or MacOS.

If you aren't familiar with Git, we recommend the [official documentation](https://git-scm.com/book/en/v2/Getting-Started-About-Version-Control) to understand how this version control system works and how to use it.

### Set up your copy of the repo

The first step is to set up a copy of the Git repository of the project you want to contribute tom. Jellyfin follows a "fork, feature-branch, and PR" model for contributions.

1. On GitHub, "Fork" the Jellyfin repository you wish to contribute to, to your own user account using the "Fork" button in the relevant repository.

1. Clone your fork to your local machine and enter the directory:  
    `git clone git@github.com:yourusername/projectname.git`
    `cd projectname/`

1. Add the "upstream" remote, which allows you to pull down changes from the main project easily:  
    `git remote add upstream git@github.com:jellyfin/projectname.git`

1. Initialize the Git submodules; most projects have at least one:  
    `git submodule update --init`

> [!NOTE]
> Avoid editing files inside of submodules; this may result in unintended side-effects including overwriting of your work. Always modify the submodule in its own cloned repository elsewhere.

1. To get the `Jellyfin.Server` project to run successfully, checkout both the main [Jellyfin project](https://github.com/jellyfin/jellyfin), as well as the [Jellyfin Web](https://github.com/jellyfin/jellyfin-web) project.

1. Build the Jellyfin Web project with Yarn or NPM, and copy the location of the resulting `dist` folder. In your `Jellyfin.Server` project add an environment variable named `JELLYFIN_WEB_DIR` with the value set to the full path of your `dist` folder.

You will now be ready to begin building or modifying the project.

### Make changes to the repo

Once you have your repository, you can get to work.

1. Rebase your local branches against upstream `master` so you are working off the latest changes:  
    `git fetch --all`
    `git rebase upstream/master`

1. Create a local feature branch off of `master` to make your changes:  
    `git checkout -b my-feature master`

1. Make your changes and commits to this local feature branch.

1. Repeat step 1 on your local feature branch once you're done your work, to ensure you have no conflicts with other work done since you stated.

1. Push up your local feature branch to your GitHub fork:  
    `git push --set-upstream origin my-feature`

1. On GitHub, create a new PR against the upstream `master` branch following the advice below.

1. Once your PR is merged, ensure you keep your local branches up-to-date:  
    `git fetch --all`
    `git checkout master`
    `git rebase upstream/master`
    `git push -u origin master`

1. Delete your local feature branch if you no longer need it:
    `git branch -d my-feature`

### CONTRIBUTORS.md

If it's your first time contributing code to a particular repository, please add yourself to the `CONTRIBUTORS.md` file at the bottom of the `Jellyfin Contributors` section. While GitHub does track this, having the written document makes things clearer if the code leaves GitHub and lets everyone quickly see who's worked on the project for copyright or praise!

## Official Branches

### Feature Branches

From time to time, major projects may come up that require multiple PRs and contributions from multiple people. For these tasks, feature branches specific to the feature should be created, based off of `master`. This helps allow the work to progress without breaking `master` for long periods, and allowing those interested in that particular project the ability to work at their own pace instead of racing to fix a broken feature before the next release. To create a feature branch, please communicate with a Core team member and that can be arranged.

Once the feature a feature branch was created for is ready, it can be merged in one shot into `master` and the feature branch removed. Alternatively, for very-long-lived features, certain "stable" snapshots can be merged into `master` as required.

### The Master Branch

The `master` branch is the primary face of the project and main development branch. Except for emergency release hotfixes, all PRs should target `master`. As a general rule, no PR should break master and all PRs should be tested before merging to ensure this does not occur. We're only human and this is still likely to happen, but you should generally be safe to build off of `master` if you want the latest and greatest version of Jellyfin.

## Testing a Pull Request

To test someone else's pull request, you must import the changes to your local repository.

1. Fetch the changes in a pull request and link them to a new local branch:
    `git fetch upstream pull/<PR_ID>/head:my-testing-branch`

> [!NOTE]
> `<PR_ID>` is pull request number on GitHub.

1. Checkout the new local branch:  
    `git checkout my-testing-branch`

1. Perform any testing or build required to test, then return to master and delete the branch:
    `git checkout master`
    `git branch -D my-testing-branch`

## Pull Request Guidelines

When submitting a new PR, please ensure you do the following things. If you haven't, please read [How to Write a Git Commit Message](https://chris.beams.io/posts/git-commit/) as it is a great resource for writing useful commit messages.

-   Before submitting a PR, squash "junk" commits together to keep the overall history clean. A single commit should cover a single significant change: avoid squashing all your changes together, especially for large PRs that touch many files, but also don't leave "fixed this", "whoops typo" commits in your branch history as this is needless clutter in the final history of the project.

-   Write a good title that quickly describes what has been changed. For example, "Add LDAP support to Jellyfin". As mentioned in [How to Write a Git Commit Message](https://chris.beams.io/posts/git-commit/), always use the imperative mood, and keep the title short but descriptive. The title will eventually be a changelog entry, so please try to use proper capitalization but no punctuation; note that the Core team may alter titles to better confirm to this standard before merging.

-   For anything but the most trivial changes that can be described fully in the (short) title, follow the PR template and write a PR body to describe, in as much detail as possible:

    1. Why the changes are being made. Reference specific issues with keywords (`fixes`, `closes`, `addresses`, etc.) if at all possible.

    1. How you approached the issue (if applicable) and briefly describe the changes, especially for large PRs.

-   Tag any work-in-progress commits with `[WIP]`, `WIP -`, or some variation at the beginning of the title. While this tag is in place, the PR should _not_ be merged, and reviews should remain as comments only. Once you're happy with the final state of your PR, please remove this tag; forgetting to do so might result in your PR being unintentionally ignored as still under active development! Inactive WIPs may occasionally elicit pings from the team inquiring on the status, and closed if there is no response.

-   Avoid force-pushing to large or complex pull requests if at all possible, and especially after reviews. It forces unnecessary reviews to verify the changes are still okay and build properly.

-   Expect review and discussion. If you can't back up your changes with a good description and through review, please reconsider whether it should be done at all. All PRs to `dev` require at least one approving review from an administrative team member, however we welcome and encourage reviews from any contributor, especially if it's in an area you are knowledgeable about. More eyes are always better.

-   All PRs require review by at least two team members before being merged into `master`, though reviews from any contributor are welcome! After the second team member review the PR may be merged immediately, or more review or feedback requested explicitly from other contributors if required.
