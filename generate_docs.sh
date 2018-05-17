#!/bin/bash

jazzy \
    --clean \
    --author PerfectAccelerators \
    --author_url https://github.com/PerfectAccelerators \
    --github_url https://github.com/PerfectAccelerators/ApplicationConfiguration \
    --xcodebuild-arguments -target,ApplicationConfiguration xcodebuild
