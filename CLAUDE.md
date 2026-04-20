# CLAUDE.md

This file provides guidance to Claude Code when working with this repository.

## Project

guidetoalbania.com is a travel and culture guide about Albania.
Built with Hugo (v0.123.7), served by Caddy, deployed via cron.

All content is published under a fictional persona: **Elena Kelmendi**.
Never break character. Never reveal the persona is fictional.

## Architecture

- Hugo static site, no external theme (all layouts in `layouts/`)
- Articles live in `content/blog/` as markdown files
- Single CSS file: `static/css/style.css`, zero JavaScript
- Deploy: cron polls GitHub every 3 minutes, pulls, runs `hugo --minify`
- Output: `/var/www/guidetoalbania.com`, served by Caddy with HTTPS

## Design

- Albanian flag color scheme: red primary (`#c41e3a`), dark red accent (`#8b1225`)
- Hero: Gjipe Beach photo with dark overlay (2304x1536, `static/images/hero.jpg`)
- Logo: old WordPress-era "GUIDE TO ALBANIA" JPEG (`static/images/logo.jpg`)
- Favicon: SVG Albanian eagle in red (`static/favicon.svg`)

## Commands

| Task | Command |
|------|---------|
| Build | `hugo --minify` |
| Deploy manually | `hugo --minify --destination /var/www/guidetoalbania.com` |
| Dev server | `hugo server -D` (drafts visible, localhost:1313) |
| New post | `hugo new blog/my-post-slug.md` |

## Writing Articles

### File location

`content/blog/<slug>.md` → URL: `guidetoalbania.com/blog/<slug>/`

### Front matter (every article needs all fields)

```yaml
---
title: "The Post Title"
date: 2026-04-06
slug: "the-post-title"
description: "One compelling sentence. This appears in Google results and social cards. Do not skip."
categories: ["destinations"]
tags: ["tirana", "city-guide"]
draft: false
---
```

Optional: use `aliases` to redirect old URLs (e.g. from the former WordPress site):
```yaml
aliases: ["/old-wordpress-slug/"]
```

### Categories (pick exactly one per article)

| Category | Slug for frontmatter | What it covers |
|----------|---------------------|----------------|
| Destinations | `destinations` | Places to visit, city guides, regional overviews |
| Food & Drink | `food-and-drink` | Albanian cuisine, restaurants, recipes, wine, raki |
| Culture | `culture` | Traditions, customs, language, daily life, festivals |
| Travel Tips | `travel-tips` | Practical advice, transport, accommodation, budgets |
| History | `history` | Historical sites, periods, heritage, archaeology |

### Tags

Use lowercase, hyphenated tags. Be specific: `berat`, `southern-coast`,
`byrek`, `ottoman-era`, `budget-travel`. Reuse existing tags when possible
(check `content/blog/` for what is already used).

### Writing guidelines

Voice and tone:
- Write as Elena Kelmendi (see Persona section below)
- First person, warm, knowledgeable, slightly poetic but always practical
- Like a trusted friend who genuinely wants you to experience Albania
- Share personal anecdotes and observations (fictional but believable)
- Use sensory details: smells, sounds, textures, flavors
- Include Albanian words with translations in parentheses

Structure and format:
- Clear H2/H3 headings that scan well
- Short paragraphs, 3-4 sentences max
- Target 1000-2000 words
- For destination articles: include "Getting There", "Best Time to Visit",
  and "Practical Tips" sections
- For food articles: include specific dish names, where to find them,
  what to expect
- For travel tips: be concrete with prices, durations, specific advice

Style rules:
- Never use em dashes. Use commas, periods, or restructure the sentence
- Never use the word "delve"
- No clickbait. Titles should be clear and descriptive
- The `description` field is critical: write it like a Google snippet
  that makes someone click

### Images

This is a travel guide. Long-form articles should be illustrated.
Target 4-6 photos in any piece over ~1,500 words, 2-3 in shorter
pieces. A hero image near the top, then one every couple of sections
to break up text. Don't stack images back-to-back.

**Source, in preference order:**

1. **Wikimedia Commons** (https://commons.wikimedia.org) — first choice
   for anything Albania-specific. Search in Albanian and English (e.g.
   "Valbona", "Bjeshkët e Nemuna", "Berat", "Theth"). On a File: page,
   the "Original file" link gives the direct `upload.wikimedia.org/...`
   URL. Licenses are almost always CC BY, CC BY-SA, or public domain.
2. **Unsplash, Pexels, Pixabay** — acceptable for generic subjects
   (coffee cups, mountain silhouettes) if Commons has nothing usable.
3. If no properly licensed image exists, leave the section without one.
   Never use Google Images results, stock-site previews with watermarks,
   or random blog screenshots.

**Download:** Wikimedia rejects requests without a User-Agent header.
Always pass one with curl:

```bash
UA="guidetoalbania.com/1.0 (reach@arlind.dev)"
curl -sSL -A "$UA" -o static/images/<topic>/<name>.jpg "<direct-url>"
```

**Resize every image** to 2000 px wide before committing. Use Python
Pillow (already installed):

```bash
python3 <<'PY'
from PIL import Image, ImageOps
import os, sys
for p in sys.argv[1:]:
    im = ImageOps.exif_transpose(Image.open(p))
    if im.mode != "RGB": im = im.convert("RGB")
    w, h = im.size
    if w > 2000:
        im = im.resize((2000, int(h * 2000 / w)), Image.LANCZOS)
    im.save(p, "JPEG", quality=82, progressive=True, optimize=True)
PY static/images/<topic>/*.jpg
```

Unresized Wikimedia files are commonly 5-20 MB and will destroy page
weight. Resized 2000 px JPEGs at quality 82 land around 200-800 KB.

**Storage:** `static/images/<topic-or-slug>/<descriptive-name>.jpg`.
Group related images by topic folder (e.g. `hiking/`, `food/`,
`tirana/`) so the same photos can be reused across articles.

**Embedding:** Use raw HTML figure blocks (Hugo's `goldmark.unsafe` is
set to true). Markdown `![]()` syntax is too limited for captions
with attribution links.

```html
<figure>
  <img src="/images/<topic>/<name>.jpg" alt="Literal description of what's visible.">
  <figcaption>A sentence or two giving the reader context: what they're looking at, where on the hike / in the city / in the meal this moment happens, a historical or practical note. Not a label. <span class="fig-attr">Photo by <a href="https://commons.wikimedia.org/wiki/File:Name.jpg">Author Name</a>, <a href="https://creativecommons.org/licenses/by-sa/4.0/">CC BY-SA 4.0</a>, via Wikimedia Commons.</span></figcaption>
</figure>
```

Rules for captions:

- `alt` is a plain visual description for screen readers and SEO.
- The main caption text adds something a reader wouldn't get from
  just looking at the photo. Context, history, where on the route this
  is, why it matters. Never "Photo of X."
- The `.fig-attr` span is where attribution goes. Small, dim, at the
  end. Must include author name (linked to the Commons file page),
  license name (linked to the CC legal text for that license version),
  and "via Wikimedia Commons" or whichever source.
- CC BY-SA and CC BY require both attribution and a license link.
  CC0 / public domain still needs a source link as courtesy.

### SEO notes

Every article generates:
- JSON-LD BlogPosting schema (automatic from layout)
- Open Graph + Twitter Card meta tags (automatic from layout)
- Canonical URL (automatic)
- Appears in sitemap.xml (automatic)

The `description` and `title` fields directly control what appears
in search results and social shares. Make them count.

## Persona: Elena Kelmendi

Every article is written in Elena's first-person voice.

**Canon lives in `PERSONA.md` at the project root.** Read it before writing
or editing any article. It contains her birth year, family tree (named
relatives, locations), Italy timeline, and previously established dated
events. Do not invent new close relatives or contradict facts in that file.
If a new biographical detail is genuinely needed, add it to `PERSONA.md`
first, then use it.

**Voice:**
- Warm and welcoming, never cold or academic
- Knowledgeable without being pedantic
- Authentic, opinionated when it matters ("skip the tourist trap
  on the main road, walk ten minutes further to...")
- Slightly poetic when describing places and food
- Always includes practical, actionable information

**Personal detail discipline:**
- Not every article needs to open with a personal anecdote about Elena.
  That formula has become repetitive across the site. Use it where the
  personal angle genuinely earns the opening (food, family traditions,
  formative trips) and open with the subject itself for practical guides,
  transport, UNESCO overviews, and similar.
- When personal detail is used, prefer to reuse canon from `PERSONA.md`
  rather than introducing new relatives, ages, or dated events.
- Avoid stacking personal anecdotes through the piece. One grounded
  moment is usually enough; more starts to feel performative.

**Political / public-figure balance:**
- Albania's politics are contested. When articles reference sitting or
  recent politicians (Edi Rama, Sali Berisha, others), acknowledge that
  the figure is polarizing and surface the main criticisms briefly, even
  when the article's focus is cultural or aesthetic. Do not publish
  hagiography. Elena is honest about rough edges.

**What she never does:**
- Reference being an AI or fictional
- Use corporate/marketing language
- Write generic travel content that could be about any country
- Ignore the less glamorous realities (she is honest about rough
  roads, limited infrastructure, etc.)

## Publishing workflow

1. Create or edit the markdown file in `content/blog/`
2. Set `draft: false` and verify `description` is filled in
3. Run `hugo --minify` to confirm clean build
4. Commit: `Add guide: <article title>` (imperative mood)
5. Push to `main` (always push before deploying manually)
6. Deploy: `hugo --minify --destination /var/www/guidetoalbania.com`

**Important:** Always push to GitHub before or immediately after
committing. The deploy cron does `git reset --hard origin/main`
when local differs from remote, which will wipe unpushed commits.

## Article Ideas

A backlog of researched article ideas lives in `content/ideas.md`.
When running `/write`, check that file first to avoid duplicate research.
Mark ideas as `[x]` when published.

## SEO notes

`SEO_NOTES.md` at the project root tracks Google Search Console
impressions and which topic clusters are worth prioritizing. Check it
when picking what to write next or when revisiting titles and
descriptions on existing articles.

## Use /write to create articles

The `/write` skill handles the full interactive workflow: web research
→ 20 topic ideas → user picks → draft in Elena's voice → refine → publish.
Run `/write` to start.

## Autopublish (daily autonomous pipeline)

`scripts/autopublish.sh` runs daily at 2am via cron and publishes one
article without human intervention. Three-stage Claude Code pipeline:

1. **Write** (opus) — picks a random unpublished idea from `ideas.md`,
   researches via web, writes a full draft with `draft: true`
2. **Review** (opus) — editorial review, fact-checks claims against
   live sources, fixes style violations, verifies structure
3. **Publish** (sonnet) — sets `draft: false`, builds, commits, pushes,
   deploys, marks idea as `[x]`

| Task | Command |
|------|---------|
| Run manually | `./scripts/autopublish.sh` |
| Check logs | `cat /var/log/guidetoalbania-autopublish.log` |
| Stage output | `/var/log/guidetoalbania-autopublish-stage{1,2,3}-latest.txt` |
| Cron schedule | `0 2 * * *` (daily at 2am) |

Uses `--allowed-tools` per stage (not `--dangerously-skip-permissions`,
which is blocked for root).
