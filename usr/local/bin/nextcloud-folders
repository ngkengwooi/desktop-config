#!/bin/bash -e
# Script to symlink user folders to Nextcloud folders,
# so that files in these folder are automatically synced to Nextcloud.
# Execute as unprivileged user.

for FOLDER in Desktop Documents Music Pictures Public Templates Videos; do
	mkdir -p "$HOME/Nextcloud/$FOLDER"
	$(rm -r "$HOME/$FOLDER" | true) && ln -s "$HOME/Nextcloud/$FOLDER" "$HOME/$FOLDER"
	xdg-user-dirs-update --set "$FOLDER" "$HOME/Nextcloud/$FOLDER"
done
