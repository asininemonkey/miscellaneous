#!/usr/bin/env bash

pkg update

pkg upgrade --yes

pkg install --yes \
    oh-my-posh \
    openssh \
    tree \
    wget
