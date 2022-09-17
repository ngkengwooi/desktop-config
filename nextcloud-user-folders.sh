#!/bin/bash -e
# Script to symlink user folders to Nextcloud folders,
# so that files in these folder are automatically synced to Nextcloud.

for FOLDER in Desktop Documents Downloads Music Pictures Public Templates Videos; do
	if [ ! -d "$HOME/Nextcloud/$FOLDER" ]; then
		mkdir -p "$HOME/Nextcloud/$FOLDER"
	fi
	$(rm -r "$HOME/$FOLDER" | true) && ln -s "$HOME/Nextcloud/$FOLDER" "$HOME/$FOLDER"
	xdg-user-dirs-update --set "$FOLDER" "$HOME/Nextcloud/$FOLDER"
done
