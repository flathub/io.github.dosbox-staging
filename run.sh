#!/usr/bin/env bash

clear
flatpak-builder --repo=testing-repo --force-clean build-dir io.github.dosbox-staging.yml
flatpak --user remote-add --if-not-exists --no-gpg-verify dos-testing-repo testing-repo
flatpak --user install dos-testing-repo io.github.dosbox-staging -y
flatpak --user install dos-testing-repo io.github.dosbox-staging.Debug -y
flatpak update -y
