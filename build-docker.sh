#!/bin/bash

wget -N https://hg.prosody.im/prosody-modules/raw-file/tip/mod_carbons/mod_carbons.lua https://hg.prosody.im/prosody-modules/raw-file/tip/mod_smacks/mod_smacks.lua

docker build -t m0wer/prosody:latest .
