import os
from subprocess import Popen
from pathlib import Path
pic_file = Path("/tmp/swww_pics.txt")


with open(pic_file,"r") as f:
    lines = f.readlines()
    counter = (int(lines[-1])-1)%(len(lines)-1)
    pic = lines[counter].strip()

env = os.environ
env["WALLPAPER"] = pic

Popen(["hyprlock"],env=env)
