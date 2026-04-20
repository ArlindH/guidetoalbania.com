#!/bin/bash
set -euo pipefail

# =============================================================================
# autopublish.sh — Daily autonomous article publishing pipeline
#
# Picks the first unpublished idea from content/ideas.md, writes a draft,
# reviews it, and publishes it. Designed to run via cron at 2am daily.
#
# Cron entry:
#   0 2 * * * /root/projects/guidetoalbania.com/scripts/autopublish.sh >> /var/log/guidetoalbania-autopublish.log 2>&1
# =============================================================================

SITE_DIR="/root/projects/guidetoalbania.com"
LOG_TAG="guidetoalbania-autopublish"
LOCK_FILE="/tmp/guidetoalbania-autopublish.lock"
LOG_DIR="/var/log"
CLAUDE="/root/.local/bin/claude"
TODAY=$(date +%Y-%m-%d)

# Tools needed per stage
WRITE_TOOLS="Read,Write,Glob,Grep,Bash,WebSearch,WebFetch"
REVIEW_TOOLS="Read,Edit,Grep,Bash,WebSearch,WebFetch"
PUBLISH_TOOLS="Read,Edit,Bash,Grep"

# --- Logging ---
log() {
    local msg="[$(date '+%Y-%m-%d %H:%M:%S')] $*"
    echo "$msg"
    logger -t "$LOG_TAG" -- "$*"
}

# --- Lock: prevent concurrent runs ---
exec 9>"$LOCK_FILE"
if ! flock -n 9; then
    log "SKIP: Another instance is already running."
    exit 0
fi
log "=== Autopublish pipeline starting ==="

cd "$SITE_DIR"

# --- Pre-flight checks ---
git fetch origin main --quiet
git reset --hard origin/main --quiet
log "Git synced to origin/main ($(git rev-parse --short HEAD))"

if ! grep -qP '^\d+\. \[ \]' content/ideas.md; then
    log "No unpublished ideas remaining. Pipeline complete (no-op)."
    exit 0
fi

UNPUBLISHED_COUNT=$(grep -cP '^\d+\. \[ \]' content/ideas.md)
log "$UNPUBLISHED_COUNT unpublished ideas remaining. Claude will pick one at random."

if ! hugo version > /dev/null 2>&1; then
    log "ERROR: Hugo not available."
    exit 1
fi

# Record start time for fallback file detection
PIPELINE_START=$(date +%s)

# =============================================================================
# STAGE 1: Write Draft
# =============================================================================
log "--- Stage 1: Write Draft (model: claude-opus-4-7) ---"

STAGE1_PROMPT='You are writing an article for guidetoalbania.com. Read CLAUDE.md for all guidelines.

TASK:
1. Read content/ideas.md and find ALL ideas marked [ ] (not [x]). Pick one at RANDOM. Do not always pick the first one. Vary across categories to keep the site balanced.
2. Use WebSearch to research that specific topic thoroughly. Search for 3-5 different angles. Read at least 2 sources with WebFetch.
3. Read 2-3 existing articles in content/blog/ to match the established voice and structure.
4. Write a complete 1000-2000 word article as Elena Kelmendi following ALL guidelines in CLAUDE.md and the writing guidelines below.
5. Save it to content/blog/<slug>.md with draft: true and today'\''s date ('"$TODAY"').
6. The slug should be descriptive, lowercase, hyphenated (e.g. "berat-city-guide").

WRITING RULES:
- No em dashes anywhere. Use commas or periods instead.
- Never use the word "delve".
- No marketing language ("paradise", "hidden gem", "nestled", etc.).
- Include Albanian words with translations in parentheses.
- Include sensory details (smells, sounds, textures, flavors).
- Include practical information (prices in LEK, travel times, specific names).
- Write a compelling description under 160 characters for the frontmatter.
- For destination articles: include "Getting There", "Best Time to Visit", "Practical Tips" sections.
- For food articles: include origin story, where to find it, taste description.
- For culture articles: include context, what to expect, regional variations.
- For travel tips: be concrete with numbers and actionable advice.
- For history articles: connect past to present, what can you still see today.
- Open with a scene or personal moment, not a generic intro.
- Short paragraphs, 3-4 sentences max.
- Be honest about downsides (rough roads, limited infrastructure, heat).

After saving the file, your response MUST end with exactly this line (no markdown, no backticks):
DRAFT_FILE: content/blog/<the-actual-slug>.md'

STAGE1_OUTPUT=$("$CLAUDE" -p "$STAGE1_PROMPT" \
    --allowed-tools "$WRITE_TOOLS" \
    --model claude-opus-4-7 \
    --output-format text \
    2>/dev/null) || {
    log "ERROR: Stage 1 Claude invocation failed (exit code $?)"
    exit 1
}

echo "$STAGE1_OUTPUT" > "$LOG_DIR/guidetoalbania-autopublish-stage1-latest.txt"
log "Stage 1 output saved to $LOG_DIR/guidetoalbania-autopublish-stage1-latest.txt"

# Extract draft filename
DRAFT_FILE=$(echo "$STAGE1_OUTPUT" | grep '^DRAFT_FILE: ' | tail -1 | sed 's/^DRAFT_FILE: //')

# Fallback: find newest .md file modified after pipeline start
if [ -z "$DRAFT_FILE" ] || [ ! -f "$DRAFT_FILE" ]; then
    log "WARN: Could not extract DRAFT_FILE from output. Attempting fallback detection."
    DRAFT_FILE=$(find content/blog/ -name '*.md' -not -name '_index.md' -newer "$LOCK_FILE" -printf '%T@ %p\n' 2>/dev/null | sort -rn | head -1 | cut -d' ' -f2-)
fi

if [ -z "$DRAFT_FILE" ] || [ ! -f "$DRAFT_FILE" ]; then
    log "ERROR: Stage 1 did not produce a draft file. Aborting."
    log "Full output:"
    log "$STAGE1_OUTPUT"
    exit 1
fi

if ! grep -q 'draft: true' "$DRAFT_FILE"; then
    log "WARN: Draft file $DRAFT_FILE does not have draft: true. Continuing anyway."
fi

log "Stage 1 complete. Draft: $DRAFT_FILE"

# =============================================================================
# STAGE 2: Review & Refine
# =============================================================================
log "--- Stage 2: Review, Fact-Check & Refine (model: claude-opus-4-7) ---"

STAGE2_PROMPT='You are reviewing a draft article for guidetoalbania.com. Read CLAUDE.md for all guidelines.

DRAFT TO REVIEW: '"$DRAFT_FILE"'

Read the draft file and perform a thorough editorial review AND fact-check. Check for and fix ALL of the following:

FACT-CHECKING (do this first):
- Use WebSearch to verify key claims: prices, distances, travel times, historical dates, opening hours, restaurant names, and any specific facts mentioned in the article.
- Cross-reference at least 3-5 factual claims against real sources using WebFetch.
- Fix any inaccuracies you find (wrong prices, outdated info, incorrect historical facts, misspelled Albanian words, etc.).
- If a specific restaurant, hotel, or business is mentioned, verify it actually exists.
- Make sure travel logistics (bus routes, ferry schedules, road conditions) reflect current reality.

PERSONA CONSISTENCY:
- Voice sounds like Elena Kelmendi (warm, knowledgeable, first-person, slightly poetic but practical)
- Includes believable personal anecdotes
- Not generic, must be specifically about Albania
- Honest about downsides (rough roads, limited infrastructure, heat)

STYLE VIOLATIONS (fix every instance):
- Em dashes (—) or (--): replace with commas, periods, or restructure
- The word "delve": replace with alternative
- Marketing language ("paradise", "hidden paradise", "gem of Europe", "nestled"): rephrase
- Paragraphs longer than 4 sentences: break them up

CONTENT QUALITY:
- Albanian words included with translations in parentheses
- Sensory details present (smells, sounds, textures, flavors)
- Practical information included (prices in LEK, travel times, specific names)
- Description field is compelling AND under 160 characters

STRUCTURE (check against category in frontmatter):
- Destinations: must have "Getting There", "Best Time to Visit", and "Practical Tips" sections
- Food & Drink: must have origin story, where to find the best version, taste description
- Culture: must have context, what to expect, regional variations
- Travel Tips: must have concrete numbers, durations, prices
- History: must connect past to present

LENGTH:
- Must be 1000-2000 words (body only, not frontmatter)
- If too short, expand weak sections
- If too long, tighten prose

Fix all issues directly in the file using the Edit tool. Keep draft: true (publishing happens next).
After reviewing and fixing, summarize what you changed.'

STAGE2_OUTPUT=$("$CLAUDE" -p "$STAGE2_PROMPT" \
    --allowed-tools "$REVIEW_TOOLS" \
    --model claude-opus-4-7 \
    --output-format text \
    2>/dev/null) || {
    log "ERROR: Stage 2 Claude invocation failed (exit code $?)"
    exit 1
}

echo "$STAGE2_OUTPUT" > "$LOG_DIR/guidetoalbania-autopublish-stage2-latest.txt"
log "Stage 2 output saved to $LOG_DIR/guidetoalbania-autopublish-stage2-latest.txt"

if [ ! -f "$DRAFT_FILE" ]; then
    log "ERROR: Draft file $DRAFT_FILE disappeared after Stage 2. Aborting."
    exit 1
fi

log "Stage 2 complete."

# =============================================================================
# STAGE 3: Publish
# =============================================================================
log "--- Stage 3: Publish (model: claude-opus-4-7) ---"

STAGE3_PROMPT='You are publishing an article for guidetoalbania.com. Read CLAUDE.md for the publishing workflow.

ARTICLE TO PUBLISH: '"$DRAFT_FILE"'

Follow these steps EXACTLY in order:

1. Read the article file and set draft: false in the frontmatter using Edit.
2. Verify the description is under 160 characters. If too long, shorten it.
3. Verify the date is '"$TODAY"'. If not, fix it.
4. Run: hugo --minify
   This must succeed with zero errors. If it fails, fix the issue and retry.
5. Stage and commit the article:
   git add '"$DRAFT_FILE"'
   git commit -m "Add guide: <article title>"
   Use the actual title from the frontmatter.
6. Update content/ideas.md: find the matching idea and change [ ] to [x].
   git add content/ideas.md
   git commit -m "Mark idea published in backlog"
7. Push:
   git push origin main
8. Deploy:
   hugo --minify --destination /var/www/guidetoalbania.com

After completing all steps, your response MUST end with exactly this line:
PUBLISHED: <title> at guidetoalbania.com/blog/<slug>/'

STAGE3_OUTPUT=$("$CLAUDE" -p "$STAGE3_PROMPT" \
    --allowed-tools "$PUBLISH_TOOLS" \
    --model claude-opus-4-7 \
    --output-format text \
    2>/dev/null) || {
    log "ERROR: Stage 3 Claude invocation failed (exit code $?)"
    exit 1
}

echo "$STAGE3_OUTPUT" > "$LOG_DIR/guidetoalbania-autopublish-stage3-latest.txt"
log "Stage 3 output saved to $LOG_DIR/guidetoalbania-autopublish-stage3-latest.txt"

# --- Post-publish validation ---
if grep -q 'draft: true' "$DRAFT_FILE"; then
    log "ERROR: Article still has draft: true after Stage 3. Manual intervention needed."
    exit 1
fi

# Verify push succeeded
LOCAL=$(git rev-parse HEAD)
git fetch origin main --quiet
REMOTE=$(git rev-parse origin/main)
if [ "$LOCAL" != "$REMOTE" ]; then
    log "WARN: Local and remote differ. Attempting manual push..."
    git push origin main 2>&1 || log "ERROR: Manual push failed. Article committed locally but not pushed."
fi

# Extract published line
PUBLISHED_LINE=$(echo "$STAGE3_OUTPUT" | grep '^PUBLISHED: ' | tail -1 || echo "")

log "=== Autopublish pipeline complete ==="
log "Article: $DRAFT_FILE"
[ -n "$PUBLISHED_LINE" ] && log "$PUBLISHED_LINE"
log "========================================="
