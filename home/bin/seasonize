#!/usr/bin/env python3

import re
import pathlib
import os

episode_regex = re.compile(r"Episode (\d+)")
season_regex = re.compile(r"Season (\d+) ")

for name in os.listdir():
    episode_result = episode_regex.search(name)
    season_result = season_regex.search(name)
    if episode_result is not None:
        season = season_result.group(1) if season_result is not None else '1'
        episode = episode_result.group(1)
        extensions = ''.join(pathlib.Path(name).suffixes)

        new_name = f"S{season}E{episode}{extensions}"
        if os.path.exists(new_name):
            print(f"Tried to rename '{name}' to '{new_name}' but it already exists, skipping...")
        else:
            os.rename(name, new_name)