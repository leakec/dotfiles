import os
from subprocess import Popen
from pathlib import Path
from random import choice

quotes = [
    "I'm afraid to move for fear of getting some of the world on me. - Alana (Sergio De La Pava)",
    "Do not pray for an easy life, pray for the strength to endure a difficult one - Bruce Lee",
]

pic_file = Path("/tmp/swww_pics.txt")


with open(pic_file,"r") as f:
    lines = f.readlines()
    counter = (int(lines[-1])-1)%(len(lines)-1)
    pic = lines[counter].strip()

env = os.environ
env["WALLPAPER"] = pic
env["QUOTE"] = choice(quotes)

Popen(["hyprlock"],env=env)
