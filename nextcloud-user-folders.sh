#!/bin/bash -e
# Script to symlink user folders to Nextcloud folders,
# so that files in these folder are automatically synced to Nextcloud.

for FOLDER in Desktop Documents Music Pictures Templates Videos; do
	$(rm -r "$HOME/$FOLDER" | true) && ln -s "$HOME/Nextcloud/$FOLDER" "$HOME/$FOLDER"
	xdg-user-dirs-update --set "$FOLDER" "$HOME/Nextcloud/$FOLDER"
done
