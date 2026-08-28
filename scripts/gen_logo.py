#!/usr/bin/env python3
"""Generator for the Guide to Albania logo assets.

Draws the double-headed eagle mark (heraldic 'displayed' pose, flat single
colour) as parametric SVG paths, then emits the three brand assets:

    layouts/partials/logo.html   inline mark + wordmark for the site header
                                 (currentColor -> themed by CSS variables)
    static/favicon.svg           flag-black eagle on a red rounded tile
    static/images/logo.svg       standalone lockup, theme-aware via
                                 prefers-color-scheme, for use off-site

The mark is built from solid shapes with notched perimeters (the way the
flag eagle is drawn): fans of wide petal-shaped feathers separated by
narrow V slits, a teardrop chest, and per-side neck / skull / hooked-beak
pieces. Every piece is its own <path> so overlaps simply paint over each
other; the right half is mirrored about x=60. Design space: 120x100,
y down; content occupies roughly x 8..112, y 4..84.

Run from the repo root:  python3 scripts/gen_logo.py
Tweak the parameter tables / path constants, re-run, rebuild.
"""
import math
import os

CX = 60.0

def polar(c, theta_deg, r):
    t = math.radians(theta_deg)
    return (c[0] + r * math.cos(t), c[1] + r * math.sin(t))

def fmt(p):
    return f"{p[0]:.2f} {p[1]:.2f}"

def fan_path(centre, feathers, notch_frac, slit_deg=2.0, edge_frac=0.80):
    """Closed fan of wide petal-shaped feathers with pointed apexes,
    separated by narrow V slits (the flag-eagle construction).

    Perimeter per feather: rise from the slit edge to the apex, fall to the
    next slit edge (two convex quadratics), then plunge into the narrow
    notch and back out. Feather bodies stay wide; only the slit is cut."""
    s = 1.0 if feathers[-1][0] > feathers[0][0] else -1.0
    pts = [f"M {fmt(centre)}"]
    n = len(feathers)
    for i, (theta, length) in enumerate(feathers):
        apex = polar(centre, theta, length)
        if i == 0:
            # leading edge bows slightly outward so the edge feather has body
            c0 = polar(centre, theta - 5.0 * s, length * 0.58)
            pts.append(f"Q {fmt(c0)} {fmt(apex)}")
        else:
            ptheta, plen = feathers[i - 1]
            mid = (ptheta + theta) / 2.0
            nr = min(plen, length) * notch_frac
            # slit: edge on the previous feather, notch, edge on this feather
            e1a = mid - slit_deg * s
            e2a = mid + slit_deg * s
            e1 = polar(centre, e1a, plen * edge_frac)
            e2 = polar(centre, e2a, length * edge_frac)
            notch = polar(centre, mid, nr)
            # falling side of the previous feather (convex petal side)
            c1 = polar(centre, (ptheta + e1a) / 2.0, (plen + plen * edge_frac) / 2.0 * 1.04)
            pts.append(f"Q {fmt(c1)} {fmt(e1)}")
            pts.append(f"L {fmt(notch)} L {fmt(e2)}")
            # rising side of this feather
            c2 = polar(centre, (theta + e2a) / 2.0, (length + length * edge_frac) / 2.0 * 1.04)
            pts.append(f"Q {fmt(c2)} {fmt(apex)}")
        if i == n - 1:
            # trailing edge bows outward too
            c9 = polar(centre, theta + 5.0 * s, length * 0.58)
            pts.append(f"Q {fmt(c9)} {fmt(centre)} Z")
    return " ".join(pts)

# ---------------------------------------------------------------- right wing
F = (70.0, 40.0)
WING_FEATHERS = [
    (-64, 24),
    (-52, 33),
    (-40, 42),
    (-27, 46),
    (-15, 44),
    ( -3, 37),
    ( 10, 28),
]

def wing_path():
    return fan_path(F, WING_FEATHERS, notch_frac=0.55)

# ---------------------------------------------------------------- tail (full)
T = (60.0, 52.0)
TAIL_FEATHERS = [
    (114, 22),
    (101, 27),
    ( 90, 30),
    ( 79, 27),
    ( 66, 22),
]

def tail_path():
    return fan_path(T, TAIL_FEATHERS, notch_frac=0.55, edge_frac=0.84)

# ---------------------------------------------------------------- body (full)
def body_path():
    return ("M 60.00 28.00 "
            "C 65.60 29.00 68.20 33.50 68.00 39.50 "
            "C 67.80 45.00 64.50 50.50 60.00 54.00 "
            "C 55.50 50.50 52.20 45.00 52.00 39.50 "
            "C 51.80 33.50 54.40 29.00 60.00 28.00 Z")

# ---------------------------------------------------------------- neck + head
def neck_path():
    """Tapered band from the chest to under the skull, leaning outward.
    Both caps are buried (chest below, skull above)."""
    return ("M 57.90 30.20 "
            "C 59.30 23.00 61.40 16.00 63.30 10.60 "
            "L 69.10 12.00 "
            "C 67.80 18.00 66.40 24.50 65.60 31.60 "
            "Q 61.60 33.80 57.90 30.20 Z")

def skull_path():
    """Round skull dome."""
    x, y, r = 66.2, 9.4, 3.95
    return (f"M {x - r:.2f} {y:.2f} "
            f"a {r} {r} 0 1 0 {2*r:.2f} 0 "
            f"a {r} {r} 0 1 0 {-2*r:.2f} 0 Z")

def beak_path():
    """Crescent hook: convex outer edge, concave underside, sharp tip.
    The base chord is buried inside the skull circle."""
    return ("M 66.80 6.40 "
            "Q 72.70 6.60 74.90 11.40 "
            "Q 71.40 10.10 68.40 11.90 "
            "Z")

# ---------------------------------------------------------------- assembly
# Content bbox of the eagle in its 120x100 design space (with ~1u margin)
VB = "8 4 104 80"
VB_X, VB_Y, VB_W, VB_H = 8, 4, 104, 80

def right_paths():
    return [wing_path(), neck_path(), skull_path(), beak_path()]

def centre_paths():
    return [body_path(), tail_path()]

def flat_group(fill="currentColor"):
    """Both halves as explicit paths inside a mirror transform group --
    no <use>/<defs>/id, safe to inline anywhere and to minify."""
    r = "".join(f'<path d="{d}"/>' for d in right_paths())
    c = "".join(f'<path d="{d}"/>' for d in centre_paths())
    return (f'<g fill="{fill}">'
            f'<g>{r}</g>'
            f'<g transform="matrix(-1 0 0 1 120 0)">{r}</g>'
            f'{c}</g>')

def emit(root):
    partial = f'''{{{{- /* Site logo: double-headed eagle mark (inline SVG, themed via
     currentColor -> var(--primary)) + wordmark. Generated by
     scripts/gen_logo.py; edit the wordmark freely, regenerate the mark
     rather than hand-editing paths. */ -}}}}
<svg class="logo-mark" viewBox="{VB}" xmlns="http://www.w3.org/2000/svg" role="img" aria-hidden="true" focusable="false">{flat_group()}</svg>
<span class="logo-text">
  <span class="logo-kicker">Guide to</span>
  <span class="logo-name">Albania</span>
</span>
'''
    with open(os.path.join(root, "layouts/partials/logo.html"), "w") as f:
        f.write(partial)

    # Red rounded tile, flag-black eagle nearly filling it.
    scale = min(28.0 / VB_W, 24.0 / VB_H)
    w, h = VB_W * scale, VB_H * scale
    tx = (32 - w) / 2 - VB_X * scale
    ty = (32 - h) / 2 - VB_Y * scale
    favicon = (f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32">\n'
               f'  <rect width="32" height="32" rx="6" fill="#E41E20"/>\n'
               f'  <g transform="translate({tx:.2f} {ty:.2f}) scale({scale:.4f})">'
               f'{flat_group(fill="#1A1A1A")}</g>\n'
               f'</svg>\n')
    with open(os.path.join(root, "static/favicon.svg"), "w") as f:
        f.write(favicon)

    # Full lockup as a self-contained, theme-aware file for use off-site.
    standalone = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 80" width="320" height="80">
  <style>
    .mark {{ color: #c41e3a; }}
    .kicker {{ font: 600 10.5px -apple-system, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
              letter-spacing: 3.6px; fill: #5a5a5a; }}
    .name {{ font: 700 30px Georgia, 'Times New Roman', serif; fill: #2c2c2c; }}
    @media (prefers-color-scheme: dark) {{
      .mark {{ color: #f05a5a; }}
      .kicker {{ fill: #9a9590; }}
      .name {{ fill: #e0ddd8; }}
    }}
  </style>
  <g class="mark"><g transform="translate(10 8) scale(0.7857) translate(-{VB_X} -{VB_Y})">{flat_group()}</g></g>
  <text class="kicker" x="106" y="34">GUIDE TO</text>
  <text class="name" x="104" y="62">Albania</text>
</svg>
'''
    with open(os.path.join(root, "static/images/logo.svg"), "w") as f:
        f.write(standalone)

    print("wrote layouts/partials/logo.html, static/favicon.svg, static/images/logo.svg")

if __name__ == "__main__":
    emit(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
