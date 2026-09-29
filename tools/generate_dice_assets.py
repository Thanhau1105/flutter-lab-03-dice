"""Generate six consistent PNG dice faces for the Flutter asset bundle."""

from pathlib import Path

from PIL import Image, ImageDraw


ROOT = Path(__file__).resolve().parents[1]
OUTPUT = ROOT / "assets"
OUTPUT.mkdir(exist_ok=True)

SCALE = 2
SIZE = 512 * SCALE
ORANGE = (236, 75, 38, 255)
PIP = (221, 69, 34, 255)
WHITE = (255, 255, 255, 255)

positions = {
    "top_left": (166, 166),
    "top_right": (346, 166),
    "middle_left": (166, 256),
    "center": (256, 256),
    "middle_right": (346, 256),
    "bottom_left": (166, 346),
    "bottom_right": (346, 346),
}

faces = {
    1: ("center",),
    2: ("top_left", "bottom_right"),
    3: ("top_left", "center", "bottom_right"),
    4: ("top_left", "top_right", "bottom_left", "bottom_right"),
    5: ("top_left", "top_right", "center", "bottom_left", "bottom_right"),
    6: (
        "top_left",
        "top_right",
        "middle_left",
        "middle_right",
        "bottom_left",
        "bottom_right",
    ),
}


for value, pips in faces.items():
    image = Image.new("RGBA", (SIZE, SIZE), (0, 0, 0, 0))
    draw = ImageDraw.Draw(image)
    bounds = tuple(v * SCALE for v in (40, 40, 472, 472))
    draw.rounded_rectangle(
        bounds,
        radius=80 * SCALE,
        fill=WHITE,
        outline=ORANGE,
        width=28 * SCALE,
    )

    for pip in pips:
        x, y = positions[pip]
        radius = 28
        draw.ellipse(
            tuple(v * SCALE for v in (x - radius, y - radius, x + radius, y + radius)),
            fill=PIP,
        )

    image.resize((512, 512), Image.Resampling.LANCZOS).save(
        OUTPUT / f"dice_{value}.png"
    )
