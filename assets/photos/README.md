# Photos the dashboard is waiting for

The dashboard at `/index.html` never invents an image. Every slot listed here
is **empty on purpose** right now — no stock photo, no AI picture, no grey box
saying "image here". A slot with nothing in it simply collapses, and the layout
stays correct. Drop a file in and it appears.

## Two hard rules

1. **No identifiable guest faces.** The page is public on the open internet.
   Backs of heads, hands on holds, wide shots where nobody is recognisable —
   all fine. A face you could name — not fine, even if you have permission,
   because permission does not travel with a public URL.
2. **Relative paths only.** Everything lives under `assets/`. The page makes
   exactly one outside request (Google Fonts) and that stays true.

## What already exists

`assets/photos/signage/` — 12 real photographs of the gym signage, six
before/after pairs. These were already in the dashboard as embedded data and
have been pulled out into real files. They are used in area **03 Branding**
and in the implementation log for that area.

| File | What it is |
|---|---|
| `01-team-only-{before,after}` | Staff-room door sign |
| `02-wlan-{before,after}` | Guest WiFi card |
| `03-no-bottles-{before,after}` | Bistro bottle rule |
| `04-emergency-exit-{before,after}` | Emergency door |
| `05-price-list-{before,after}` | Price list |
| `06-gym-rules-{before,after}` | Hallenregeln |

`assets/brand/boulder-island-mark.png` — the coral mountain mark, used in the
header and the footer.

---

# The empty slots, in the order they appear on the page

## 1. Hero video — `assets/video/hero-drone.mp4`

**Status: empty.** No drone clip exists in this repository, so the hero is a
plain brand block: big headline, coral slab with the rule of thumb. That is a
finished design, not a placeholder — nothing looks broken.

| | |
|---|---|
| **Slot name** | `hero-drone` |
| **Format** | MP4, H.264, no audio track at all |
| **Orientation** | Landscape |
| **Size on disk** | **Under 5 MB.** This is the hard limit — the page is opened on phones. |
| **Dimensions** | 1920 × 1080 is plenty. 2560 wide maximum. |
| **Length** | 8–14 seconds, cut so the last frame matches the first (it loops) |
| **Motion** | Slow. A drifting push-in over the gym or the outdoor area. No fast orbits, no whip pans. |
| **Poster frame** | `assets/video/hero-drone-poster.jpg`, landscape, 1920 × 1080, under 300 KB. This is what people on a slow connection see. |

The video must be muted, looping, and must not autoplay when the visitor has
reduced motion switched on. The markup to paste into the hero, replacing the
`<!-- HERO MEDIA SLOT -->` comment in `index.html`:

```html
<div class="hero-media">
  <video autoplay muted loop playsinline
         poster="assets/video/hero-drone-poster.jpg"
         aria-label="Boulder Island from the air">
    <source src="assets/video/hero-drone.mp4" type="video/mp4">
  </video>
</div>
```

## 2. Section backgrounds — six slots

**Status: all empty.** Each of the six areas can carry one photograph as a
faint background behind its card header. Subtle grain is applied by the page,
so hand over a clean photo — do not add grain yourself.

| Slot name | Area | Orientation | Dimensions | Weight |
|---|---|---|---|---|
| `area-01-bg` | 01 Beginner Experience — the entrance or the desk | Landscape | 1600 × 900 | ≤ 250 KB |
| `area-02-bg` | 02 Events — the outdoor space, empty | Landscape | 1600 × 900 | ≤ 250 KB |
| `area-03-bg` | 03 Branding — a wall of the new signs | Landscape | 1600 × 900 | ≤ 250 KB |
| `area-04-bg` | 04 Route Setting — a fresh sector after a setting day | Landscape | 1600 × 900 | ≤ 250 KB |
| `area-05-bg` | 05 Social Media — the gym as it photographs best | Landscape | 1600 × 900 | ≤ 250 KB |
| `area-06-bg` | 06 Facility — the kids' area, or the roof on a hot day | Landscape | 1600 × 900 | ≤ 250 KB |

Put them in `assets/photos/areas/` named `area-01-bg.jpg` and so on.

## 3. Implementation-log photo slots — one per log entry

**Status: one filled, the rest empty.** Every entry in every area's
implementation log has an optional photo. Area 03's "27 signs redesigned"
entry carries `signage/06-gym-rules-after.png`; every other entry has `null`.

| | |
|---|---|
| **Slot name** | `log-photo` (one per entry) |
| **Orientation** | Either. Portrait reads better in the narrow log column. |
| **Dimensions** | Longest edge 1400 px |
| **Weight** | ≤ 200 KB each |

To fill one, set the `photo` field on that entry in `index.html`:

```js
{ date:"14.08.2026", kind:"Step",
  text:"The placards went up on the beginner wall.",
  photo:"assets/photos/areas/placards-up.jpg",
  link:null }
```

## 4. Austria assignment photo slots — eleven

**Status: all eleven empty.** Each of the eleven Austria cards has a reserved
photo slot. The space is already held, so a picture drops in without moving
the layout.

| | |
|---|---|
| **Slot name** | `aa-photo-01` … `aa-photo-11` |
| **Orientation** | Landscape reads best in the card grid |
| **Dimensions** | 1200 × 800 |
| **Weight** | ≤ 200 KB each |

To fill one, edit that card in `index.html`:

```html
<div class="aa-photo"><img src="assets/photos/austria/aa-photo-06.jpg" alt="The mother Plakat at the entrance"></div>
```

## 5. Friday feed photo slots

**Status: all empty.** Any Friday feed entry can carry a photo, which opens
in the lightbox when tapped.

| | |
|---|---|
| **Slot name** | `feed-photo` |
| **Orientation** | Either |
| **Dimensions** | Longest edge 1400 px |
| **Weight** | ≤ 200 KB each |

---

## Before you commit a photo

- Look at it once at full size and ask: could a member recognise themselves?
  If yes, do not use it.
- Resize it. A 4 MB phone photo on a page opened over mobile data is a real
  cost. `sips -Z 1600 photo.jpg` on a Mac, or any image tool, is enough.
- Give every `<img>` a real `alt` text — one short sentence saying what is in
  the picture. The dashboard is read out loud by screen readers and printed.
