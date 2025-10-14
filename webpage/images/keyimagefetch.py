import urllib.request
from PIL import Image

colors = [
    "blue",
    "crimson",
    "gold",
    "green",
    "orange",
    "purple",
    "silver",
    "yellow"
]

shapes = [
    "corner",
    "crescent",
    "diamond",
    "pentagon",
    "triangle",
    "rectangle",
    "shield",
    "wedge"
]

baseurl = "https://runescape.wiki/images"

for color in colors:
    for shape in shapes:
        cappedcolor = color.capitalize()
        urllib.request.urlretrieve(f"{baseurl}/{cappedcolor}_{shape}_key.png", f"./webpage/images/keys/{color}{shape}.png")