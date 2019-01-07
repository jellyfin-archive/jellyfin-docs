# Contributing to Jellyfin

This page details how you can help contribute to Jellyfin. Please give this a read-through before opening an Issue or PR, or if you're not sure how to do either.

Are you a coder and interested in [writing and maintaining C# or Javascript code](/developer-docs/contributing#contributing-code-to-jellyfin)? Or are you not a coder and interested in [reporting an issue or contributing in other ways](/developer-docs/contributing#other-contributions-to-jellyfin)?

## Contributing Code to Jellyfin        

The Jellyfin project consists of a C# core server, a Javascript-based UI, and a number of client applications written in various languages and frameworks. If you have experience with these languages, we're always grateful for any contributions you might want to make!

### What should you do?

The best way to get going is to look through the [Issues list](https://github.com/jellyfin/jellyfin/issues), find an issue you would like to work on, and start hacking. Issues are triaged regularly by the administrative team, and labels assigned that should help you find issues within your skill-set. Once you start working on an issue, please comment on it stating your intent to work on the issue, to avoid unnecessary duplication of work.

#### Major Issue Types

A list of issue types can be found on the [Issue guidelines](/developer-docs/issues#issue-labels) page.

#### What if there isn't an issue?

If there isn't already an issue dealing with the changes you want to make, please [create an issue](/developer-docs/issues) to track it first, then ensure your PR(s) reference the issue in question. This is epecially useful for bugs that are found and then fixed by the author, so both the original issue and the fix can be documented and tracked in detail.

### How should you make changes?

Once you've found something you want to work on or improve, the next step is to make your changes in the code, test them, then submit a PR. This section details how to go about doing that. For simplicity, all examples assume the developer is operating on Linux with SSH access to GitHub, however the general ideas can be translated to Windows or MacOS.

If you aren't familiar with Git, we recommend the [official documentation](https://git-scm.com/book/en/v2/Getting-Started-About-Version-Control) to get yourself going.

#### Set up your copy of the repo

The first step is to set up a copy of the repo that you can work from. Jellyfin follows a "fork and PR" methodology.

1. On GitHub, "Fork" the Jellyfin repo to your own user.

1. Clone your fork to your local machine:  
    `git clone git@github.com:yourname/jellyfin.git`

1. Add the "upstream" remote:  
    `git remote add upstream git@github.com:jellyfin/jellyfin.git`
    

1. Initialize the submodules:  
    `git submodule update --init`

1. Check out the `dev` branch at least once so it tracks your origin:  
    `git checkout dev`
    

You will now be ready to begin building or modifying the project.

#### Make changes to the repo

The first step is to set up a copy of the repo that you can work from. Jellyfin uses a "feature branch" model for developing changes.

1. Rebase your local branches against upstream `master`/`dev`:  
    `git fetch --all`  
    `git checkout <BRANCH>`  
    `git rebase upstream/<BRANCH>`  

1. Create a local feature branch off of `dev`:  
    `git checkout -b my-feature dev`

1. Make your changes and commits to this local feature branch, `git rebase`ing off of `dev` regularly, especially before submitting a PR.

1. Push up your local feature branch to your GitHub fork:  
    `git push --set-upstream origin my-feature`

1. On GitHub, create a new PR against the upstream `dev` branch.

1. Once the PR is merged, ensure you keep your local and fork branches up-to-date:  
    `git fetch --all`  
    `git checkout dev`  
    `git rebase upstream/dev`  
    `git push -u origin dev`  

#### CONTRIBUTORS.md

If it's your first time contributing code, please add yourself to the `CONTRIBUTORS.md` file at the bottom of the `Jellyfin Contributors` section. While GitHub does track this, having the written document makes things clearer if the code leaves GitHub and lets everyone quickly see who's worked on the project for copyright or praise!

#### Pull Request guidelines

When submitting a new PR, please ensure you do the following things. If you haven't, please read [How to Write a Git Commit Message](https://chris.beams.io/posts/git-commit/) as it is a great resource for writing useful commit messages.

* Before submitting a PR, squash "junk" commits together to keep the overall history clean. A single commit should cover a single significant change: avoid squashing all your changes together, especially for large PRs that touch many files, but also don't leave "fixed this", "whoops typo" commits in your branch history as this is needless clutter.

* Write a good title that quickly describes what has been changed. For example, "Add LDAP support to Jellyfin". Prefix the title with "WIP" while you're still working on the PR and remove that prefix when you feel it's ready to be merged and would like to receive final reviews.

* For anything but the most trivial changes that can be described fully in the title, write a PR body to describe, in as much detail as possible:

    1. *Why* the changes are being made. Reference specific issues with keywords (`fixes`, `closes`, `addresses`, etc.) if at all possible.

    1. *How*, in broad strokes, you approached the issue (if applicable) and briefly describe the changes, especially for large PRs.

* Manually update the target branch from `master` to `dev`; PRs against `master` are only considered in the most exceptional circumstances and all new work should go to `dev`. We intentionally keep `master` as the main face of the code on GitHub, so this must be done manually for each PR. Don't worry if you forget; this will be corrected before merging.

* Expect review and discussion. If you can't back up your changes with a good description and through review, please reconsider whether it should be done at all. All PRs to `dev` require at least one approving review from an administrative team member, however we welcome and encourage reviews from any contributor, especially if it's in an area you are knowledgeable about. More eyes are always better.

### The Master branch

The `master` branch is the current main branch of Jellyfin and its public face on GitHub, as opposed to the constantly-moving `dev` branch. Until we reach a first official release with our own versioning, releases are limited to build identifiers (i.g. `3.5.2-X`) based on `master`. Each update to `master` occurs through a roll-up PR made by an admin team member, on a semi-regular basis, which will identify the relevant PRs (and issues) that are fixed and help ensure there is a consistent trail of development work in the history. `master` merges must be approved by two administrative team members, thus ensuring a majority of the team accepts the changes.

## Other Contributions to Jellyfin

Even if you can't contribute code, you can still help Jellyfin! The two main things you can help with are testing and creating Issues, and contributing to documentation, translations, and other non-code components.

### Documentation

Documentation is incredibly helpful! All these docs are written using `mkdocs` via [readthedocs.io](https://readthedocs.io). You can find the raw markdown in the [Jellyfin documentation repository](https://github.com/jellyfin/jellyfin-docs). Pull requests are welcome!

### Translations

We're still working to set up a translation system that will help automate this, but for now translations occur in the frontend code. This is a complex process so please ask for help if you wish to assist right now.

### Testing

Testing is the easiest way to contribute. Simply use Jellyfin, and if you run into problems, [let us know](/user-docs/hetting-help). This is the most common way we uncover bugs, through a user doing something we hadn't thought of. If the issue does end up being related to the code, a [bug issue](/developer-docs/issues#reporting-bugs) can then be opened.
