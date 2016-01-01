# iOS Client
iOS client for the expert-finder service (name TBD).

## `cocoapods` setup for first use
This repo uses Cocoapods for dependency management. dependencies and their
version numbers are saved in the repo (see `Podfile`), but the files themselves
are not. The first time you use this repo, run

    sudo gem install cocoapods
    pod install

This will set up the project dependencies.

## Using `synx` to synchronize project directories
By default, Xcode puts all source code files in the project root directory,
which is messy. If you've created new groups or files, before you commit, please
use `synx` to organize the project directory structure based on its
representation in Xcode.

Install:
    sudo gem install synx

Run (do this before you commit if you've added new files/groups in Xcode):
    synx ./iosClient.xcodeproj
