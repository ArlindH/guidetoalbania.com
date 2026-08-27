# SEO Notes

Working notes on how guidetoalbania.com is performing in search, and
which topics to prioritize. Update as new data comes in.

## Google Search Console (snapshot 2026-08-27 morning, last 90 days)

Site totals: **278 clicks, 37.8K impressions, 0.7% CTR, avg position 16.5.**

> Superseded the same afternoon by a re-pull taken immediately before the
> ten-article commercial batch shipped. See **Baseline at time of
> publishing** at the bottom of this file for the numbers to measure the
> batch against. The analysis in this section still holds; only the
> counts moved.

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
4. ~~Safety piece (`is albania safe`)~~ Published 2026-08-27 as
   `is-albania-safe`, framed on the real risk being road traffic rather
   than crime: homicide 1.4/100k (UNODC 2023) against a road death rate
   of 10.8/100k, so roughly eight times more likely to die on the road
   than be murdered. Note this one had almost no impressions to target,
   unlike priority 3. It is a bet on demand Google cannot currently see
   because no page existed. Worth checking in 90 days whether that bet
   paid, since it is the counter-example to the position-based triage
   rule above.

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

## Full query pull (2026-08-27, second pass, last 90 days)

Pulled the complete query report rather than the top rows. The picture
is more consistent than the earlier summary suggested.

### The domain splits cleanly in two

**Named entities rank. Categories do not.** There is no exception to
this in the data.

| Ranks at position 6 to 13 | Ranks at position 24 to 80 |
|---|---|
| gliko, xhiro, burrnesha, furgon, besa, tavë kosi, raki, south albania beaches, "most bunkers" trivia | albanian food, albanian cuisine, hiking albania, albanian mountains, nightlife albania, communist albania, butrint, best time to visit albania |

The lesson is not "write more". It is "write about a named thing with
thin English competition". Head terms on this domain are a waiting
game, not a writing task.

### The two biggest zero-click pages

| Page | Impr. | Clicks | Position |
|------|------:|-------:|---------:|
| albanian-highest-mountains | 1,541 | **0** | 34.6 |
| albanian-cuisine | 1,377 | **0** | 36.1 |

Together 2,918 impressions and zero clicks. Both are 2023 WordPress-era
pages sitting at position 35 on head terms. Note that
`albanian-cuisine` is already titled "15 Dishes You Need to Try (And
Where to Find Them)" and already covers byrek, fërgesë, qofte, flija,
japrak, trileçe and the rest. **Do not write another Albanian food
roundup.** It would cannibalize, not add.

### Query clusters, sized

| Cluster | ~Impr. | Position | Clicks | Verdict |
|---------|-------:|---------:|-------:|---------|
| Raki (how made, alcohol %) | ~1,500 | 7-11 | 29 | CTR job. AI Overview territory |
| South Albania beaches | ~1,300 | 7-9 | 32 | CTR job |
| Near-me hiking / walking | ~1,200 | 6-10 | 1 | Mostly unconvertible, searcher is not in Albania |
| Albanian food / cuisine | ~1,000 | 36-49 | 0 | Authority job, page already exists |
| Nightlife | ~800 | 16-33 | 9 | Middling |
| Bunkers trivia | ~380 | 9-14 | 1 | AI Overview territory |
| Highest mountains | ~250 | 9-80 | 0 | Authority job |
| Tavë kosi restaurant intent | ~150 | 8-11 | 0 | Small but high intent |

Almost every high-impression query already has a page ranking at a
decent position and returning nothing. That is the CTR finding again,
now with the full dataset behind it.

### Arithmetic worth keeping in view

37.8K impressions at 0.7% returns 278 clicks. The xhiro page converts
at 2.5% and gliko at 1.7% at similar positions, so the ceiling is real
rather than theoretical. Lifting the site to 2% would return roughly
750 clicks with no new content at all. A single new article, ranking
well, realistically adds 500 to 2,000 impressions over 90 days, which
is 10 to 30 clicks at current CTR.

**Titles and descriptions on the existing top ten pages are worth more
than the next five articles.** Write for other reasons, but do not
expect a new post to move the total.

## Monetization changed the target (2026-08-27)

Travelpayouts tracking went live in `layouts/partials/head.html`. Traffic
is no longer equal in value. A reader searching "which country has the
most bunkers" cannot be monetized. A reader searching "car rental
Tirana airport" is one click from a booking.

Reprioritize toward commercial intent: car rental, accommodation,
transfers, tours, insurance. The existing transport content already
proves the domain ranks here.

| Page | Impr. | Clicks | CTR | Position |
|------|------:|-------:|----:|---------:|
| how-to-use-furgons-in-albania | 521 | 6 | **1.2%** | 8.1 |
| how-to-explore-albanian-coastline-transport | 234 | 1 | 0.4% | 10.4 |

The furgon guide converts at nearly twice the site average and is the
only dedicated transport piece on the site. Car rental exists only as
one H2 inside the 2022 coastline article.

## Next article: renting a car / driving in Albania

Reasoning, in order of weight:

1. **No page exists.** Nothing to cannibalize. Every other big cluster
   is already covered by a page ranking at 8 to 11.
2. **Commercial intent.** Car rental is the highest-value Travelpayouts
   category that fits a guide site, ahead of everything except hotels.
3. **The domain ranks practical transport content.** Furgons at 8.1,
   coastline transport at 10.4, both without much effort.
4. **AI Overview resistant.** Deposit holds, the green card, the
   Kosovo and Montenegro cross-border rules, which roads actually need
   clearance, local agencies versus the international desks, real 2026
   daily rates. A summary cannot finish this job.
5. **Internal linking is already in place.** `is-albania-safe` argues
   that Albania's real danger is the road, with the crash statistics
   to support it. A driving guide is the natural next click, and each
   strengthens the other.

Runner-up: Albanian coffee culture (idea 9). Same named-entity shape
that made gliko and xhiro work, and the "most coffee bars per capita in
the world" statistic is the kind of superlative this domain already
ranks at position 9 to 12 for on bunkers. No commercial intent, though.

### Process notes, updated

- Pull the **full** query report, not the top 10 rows. The rows-per-page
  control in Search Console does not respond to a direct click. Open it
  with Enter, then arrow to the size. Or read the whole table off the
  page at once, which is faster.
- Check whether a page already covers the angle before recommending it.
  The "write a dish guide" idea died on contact with
  `albanian-cuisine-guide.md`, which had already done it.

## Commercial-intent batch, published 2026-08-27

Ten articles written in one run, back-dated across 2026-06-29 to
2026-08-20 to fill the gap between the May and August clusters rather
than landing ten same-day timestamps in the sitemap.

| Slug | Date | Target intent | Inline links |
|------|------|---------------|-------------:|
| tirana-airport-transport | 06-29 | airport transfer / "tirana airport to city" | 3 |
| albania-sim-card-esim | 07-04 | "sim card albania", "albania esim" | 2 |
| albania-travel-cost-budget | 07-09 | "how much does albania cost" | 3 |
| albania-itinerary-7-10-14-days | 07-15 | "albania itinerary 7 days" | 3 |
| driving-in-albania | 07-21 | "driving in albania" | 3 |
| where-to-stay-in-albania | 07-27 | "where to stay in albania" | 3 |
| day-trips-from-tirana | 08-02 | "day trips from tirana" | 3 |
| blue-eye-syri-i-kalter | 08-08 | "blue eye albania" | 2 |
| berat-guide | 08-14 | "berat albania" | 2 |
| solo-female-travel-albania | 08-20 | "is albania safe for solo female travellers" | 3 |

### Reasoning behind the selection

1. **Commercial intent over volume.** Every piece except Berat and the
   Blue Eye sits on a query where the reader is one click from a
   booking. The furgon guide's 1.2% CTR at position 8.1 is the evidence
   that this domain ranks practical transport content easily.
2. **AI Overview resistance.** Each piece leads with something a SERP
   summary cannot finish: the 400 lekë bus fare and the fact that Uber
   and Bolt do not exist here, the EU-roaming exclusion, the lek
   revaluation, the swim ban at the Blue Eye, real driving times.
3. **The lek angle is the one genuinely original claim** in the batch.
   EUR/ALL went from roughly 140 to about 92, so euro visitors are
   paying about a third more for unchanged Albanian prices. Nothing
   else writing about Albanian costs has accounted for this.
4. **Hub and spoke.** The itinerary piece links to eight others and is
   linked from six. That is the first real internal-link hub on the
   site.

### Deliberately not written

- **Riviera without a car.** Would have cannibalised
  `albanian-coastline-transport` (position 10.4), which already does
  mode-by-mode comparison for the whole coast. Replaced with
  `where-to-stay-in-albania`, which had zero coverage.
- **Another hiking listicle.** Head hiking terms are still at position
  76 to 80. Nothing has changed since the April note.

### Monetisation state at time of writing

Verified working, all five redirecting with tracking: Localrent
(87/2043), Kiwitaxi (1/647), Airalo (541/8310), EKTA (225/5869),
Welcome Pickups (627/8919).

**Klook (137/4110) was checked and rejected.** The Albania search on
klook.com returns Mexican day tours and sold-out Tirana hotels. Sending
readers there would not convert and would not be honest.

**`where-to-stay-in-albania` is the page to revisit when Booking.com or
Hostelworld unlock.** Accommodation is the largest travel spend and the
article currently carries transport and eSIM links only, because there
is no hotel program connected. Per the dashboard, those unlock after
roughly three months of stable traffic.

### What to watch

- Whether `driving-in-albania` and `renting-a-car-in-albania`
  cannibalise each other. They target different queries and cross-link,
  but if one suppresses the other, merge into the rental piece.
- Whether `day-trips-from-tirana` splits traffic with
  `hiking-near-tirana-day-hikes`. Same geography, different intent
  (sightseeing vs trails).
- Whether the back-dated publication dates get crawled and indexed
  normally, or whether Google discounts them for appearing in the
  sitemap all at once.

### Baseline at time of publishing

Re-pulled from Search Console immediately before the batch went live, so
there is a clean before-reading to measure it against. Last 90 days, web
search, taken 2026-08-27 afternoon (Search Console's own "last update"
was 5.5 hours earlier).

**Site totals: 287 clicks, 38.2K impressions, 0.8% CTR, avg position 16.4.**

Against the morning snapshot at the top of this file that is +9 clicks,
+0.4K impressions, +0.1pp CTR and a 0.1 improvement in average position.
Same-day drift, no signal in it. It is recorded because it is the
number the batch has to beat.

Top ten queries by impressions, with the morning figure in brackets
where it moved:

```
query                        clicks  impr.        position
burrnesha                         4    916  (915)     ~11.6
burrnesha albania                 2    749  (743)     ~10.4
best places to walk               0    704  (693)      ~8.9
gliko                             0    506  (490)      ~8.1
hiking albania                    0    501  (505)     ~77.3
gliko albania                     5    440  (438)      ~7.2
south albania beaches             2    411  (408)      ~9.0
albania mountains hiking          0    389  (394)     ~80.3
theth valbona hike                0    236  (240)     ~40.7
tave kosi                         0    232  (220)     ~37.1
```

**Caveat: this is the top ten rows only, not the full pull.** The
rows-per-page control resisted again, exactly as the process note above
warns: clicking 500 highlights it without applying, and Enter did not
commit it either. Positions are carried over from the morning pull
because the re-pull only exposed clicks and impressions, hence the
tildes. The full tail from the earlier second pass is still the better
reference for cluster sizing.

**Next pull worth doing properly:** filter to the ten new URLs
specifically, 28-day window, from about the end of September. Before
that there is not enough crawl history for the numbers to mean
anything. The three to watch first are `driving-in-albania` against
`renting-a-car-in-albania`, `day-trips-from-tirana` against
`hiking-near-tirana-day-hikes`, and whether `where-to-stay-in-albania`
picks up anything at all without a hotel program attached to it.

## Xhiro follow-up, published 2026-08-27

`albania-evening-promenades` — the first deliberate sequel to a page
that already ranks. Reasoning:

1. **The xhiro page is the site's best asset per impression** (2.52%
   CTR at position 7) and had **zero internal links in its body**, so
   its authority and readers dead-ended. The sequel gives that traffic
   somewhere to go; the parent now links to it from the top of its
   "Where to Experience" section.
2. **Intent split, not duplication.** Parent keeps the definitional
   query ("xhiro", what it is, why it persists). Sequel takes planning
   intent: named promenades (Lungomare, Vollga, Shën Gjergji, Kolë
   Idromeno, Hasan Tahsini, Taulantia), each a named entity with thin
   English competition, the shape that ranks on this domain.
3. **`best places to walk` (704 impr., pos 8.9, 0 clicks)** currently
   lands on the essay. The sequel is a better landing for it. Note
   this makes a third page in walking-adjacent territory alongside
   `hiking-near-tirana-day-hikes`; intents differ (boulevards vs
   trails) but watch for a three-way split.
4. **Monetization where the essay could carry none.** Culture piece
   rules kept affiliate links out of the parent. The sequel is a
   destinations piece with genuine transport need: Kiwitaxi (airport
   to Durrës first-evening angle) and Localrent (promenade-a-night
   southern loop), sub_id `albania-evening-promenades`.

Parent also got a small fact fix in passing: Myslym Shyri described as
weekend car-free rather than "the pedestrian shopping street" (it
carries traffic on weekdays; the everyday pedonale is Murat Toptani).

**Watch from late September:** whether the sequel takes impressions on
promenade-entity queries without pulling the parent off position 7 for
"xhiro". If the parent slips, the fix is sharpening the title/intent
split, not merging.

## Raki follow-up play (2026-08-27)

The raki guide is the site's biggest impression driver (6,322 impr, 29
clicks, position 7 to 11, 0.46% CTR on definitional queries that AI
Overviews eat) and it was a dead end in the link graph: zero inbound
internal links despite 17 articles mentioning raki, zero outbound
links, zero images. Three changes shipped together:

1. **New article `raki-trail-skrapar-permet`.** Converts definitional
   raki traffic into travel intent the SERP summary cannot finish:
   Çorovoda producers, Festa e Rakisë (October, "Skrapari në gotë"),
   Osumi canyon rafting seasons and prices, the unpaved
   Çorovodë–Piskovë 4x4 crossing vs the paved Vjosa loop, Bënja baths,
   and a bringing-raki-home section (customs allowances, the 70% rule).
   Named-entity targets with thin English competition: skrapar raki,
   çorovoda, osumi canyon, festa e rakisë, bogovë waterfall, raki mani.
   Monetized: Localrent + EKTA inline, `sub_id=raki-trail`, strip on.
2. **Raki guide retitled for CTR** (priority #1 above): "Albanian
   Raki: How It's Made, and How Not to Drink It", description
   rewritten first-person with a curiosity hook. The page also gained
   its first two images (including a 1999 Berat distilling photo from
   Commons) and its first internal links (trail piece + gliko).
3. **Six inbound links added** across berat-guide (x2), cuisine guide
   (x2), agroturizëm, and nightlife, pointing at the raki guide and
   the trail piece.

Watch from late September: raki guide CTR against the 0.46% baseline
(the title change is the isolated variable), whether the trail piece
picks up skrapar/osumi/festa impressions at all, and `raki-trail`
sub_id clicks in Travelpayouts. If the retitle moves CTR, repeat the
treatment on beaches, burrnesha, and nightlife per priority #1.
