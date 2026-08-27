# SEO Notes

Working notes on how guidetoalbania.com is performing in search, and
which topics to prioritize. Update as new data comes in.

## Google Search Console (snapshot 2026-08-27, last 90 days)

Site totals: **278 clicks, 37.8K impressions, 0.7% CTR, avg position 16.5.**

### Top pages

| Page | Clicks | Impr. | CTR |
|------|-------:|------:|----:|
| albanian-raki-guide-how-its-made | 29 | 6,322 | 0.46% |
| must-visit-southern-albanian-beaches | 32 | 4,159 | 0.77% |
| burrnesha-albanian-sworn-virgins | 15 | 3,172 | 0.47% |
| tave-kosi-albanias-national-dish | 27 | 3,067 | 0.88% |
| albanian-gliko-fruit-preserves-in-syrup | 50 | 2,941 | 1.70% |
| famous-hiking-trails-in-albania | 18 | 2,301 | 0.78% |
| nightlife-in-albania-something-for-everyone | 9 | 2,246 | 0.40% |
| xhiro-the-albanian-evening-walk | 39 | 1,549 | 2.52% |
| hiking-in-albania-first-timers-guide | 7 | 1,310 | 0.53% |
| how-tirana-got-its-colors | 17 | 770 | 2.21% |

### Highest-impression queries

```
query                        clicks  impr.  position
burrnesha                         4    915      11.6
burrnesha albania                 2    743      10.4
best places to walk               0    693       8.9
hiking albania                    0    505      77.3
gliko                             0    490       8.1
gliko albania                     5    438       7.2
south albania beaches             2    408       9.0
albania mountains hiking          0    394      80.3
theth valbona hike                0    240      40.7
best hiking trails nearby         0    229       9.9
nightlife albania                 0    225      32.7
tave kosi                         0    220      37.1
xhiro                             0    218       7.0
albanian cuisine                  0    206      42.8
```

## What this tells us

**1. The CTR problem is now bigger than the ranking problem.**
Site-wide CTR is 0.7%. Pages ranking at positions 7 to 11 are converting
at 0.4 to 0.5%, roughly a fifth of what those positions should return.
The pattern is concentrated on definitional queries ("what is raki made
of", "raki alcohol percentage", "burrnesha meaning"), which is the
signature of AI Overviews answering in the SERP. Raki alone carries
6,322 impressions for 29 clicks.

Writing more content on those topics will not help. Titles, descriptions,
and content that survives an AI summary (specific prices, named
restaurants, opinionated picks) are the levers.

**2. Head hiking terms are unwinnable right now.**
`hiking albania` sits at position 77.3 (505 impr.), `albania mountains
hiking` at 80.3 (394 impr.), `albania hiking` at 76.4 (166 impr.).
Four articles into the hiking cluster and still page 8. This is a domain
authority problem, not a coverage problem. Do not write another broad
hiking listicle expecting it to rank.

**3. "Near me" hiking queries were the real gap.**
Google ranks the site at positions 7 to 11 across ~27 near-me and
near-Tirana hiking queries totalling 567 impressions, with 1 click,
because no page matched the intent. Plus `best places to walk` (693
impr., pos 8.9) landing on the xhiro essay. Addressed 2026-08-27 by
`hiking-near-tirana-day-hikes`. **Watch this one, it is the test of
whether intent-matching beats authority on this domain.**

**4. Correction to the April 2026 note.**
That snapshot listed `is albania safe` at 144 impressions and made it
priority #2. Live 90-day data shows **1 impression at position 2.0**.
Caveat: no safety page exists, so Google has little to rank and low
impressions partly reflect that absence rather than absent demand. Still
worth writing, but it is not the data-backed top priority the old note
implied.

**5. Gliko and xhiro punch above their weight.**
2.52% and 1.70% CTR against a 0.7% site average. Both are topics with
almost no English-language competition. Niche-and-uncontested beats
high-volume-and-crowded on a domain this young.

## Priorities

1. **Fix CTR on the top 4 pages.** Raki, beaches, burrnesha, nightlife
   hold ~15,700 impressions between them and return 85 clicks. Rewrite
   titles and descriptions first, measure, then touch content.
2. **Find more uncontested niches** in the gliko/xhiro mould rather than
   chasing head terms the domain cannot rank for yet.
3. **Intent-match existing rankings.** Look for queries where position is
   already under 15 but no page actually answers the question.
4. Safety piece (`is albania safe`), framed on the real risk being road
   traffic rather than crime. Albania's homicide rate is 1.1/100k, below
   France, while road fatalities run 3 to 4x the EU average.

## Process notes

- Pull live GSC data before picking a topic. The April 2026 snapshot was
  four months stale and pointed at the wrong priority.
- Sort the query report by **impressions**, not clicks. The opportunities
  are all zero-click rows.
- Check position before assuming a topic is a content gap. Position 8
  with no clicks is a CTR job. Position 77 is an authority job. Only
  "ranks well, wrong page" is a writing job.
- Titles and descriptions are the direct levers for CTR. Revisit them
  when an article is getting impressions but no clicks.
