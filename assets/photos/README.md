# Photos for the Friday Dashboard

Drop image files in here, then reference the filename from the `DASHBOARD`
data block at the top of `/index.html`. Nothing else needs changing —
the page picks them up automatically, and any photo whose file is missing
is simply skipped, so the page never shows a broken image.

## Files the dashboard is already looking for

| Filename | Used for | Status |
|---|---|---|
| `gym-hero.jpg` | Hero background — a wide, real photo of the gym (people climbing, the main wall, the outdoor area). Landscape, ideally 2000px wide or more. | **missing — add this one first** |
| `feedback-tablet.jpg` | Log entry 01 · the wall-mounted guest feedback tablet, in place in the gym. | **missing** |
| `logo.png` | Header and footer logo mark. | present |
| `signs/*.jpg` / `signs/*.png` | The 27-sign before/after gallery in area 03. | present (12 files) |

The hero currently renders a layered contour-and-grain fallback panel. As soon
as `gym-hero.jpg` exists and is named in the data block, it becomes a real
photographic hero with an ink overlay.

## Adding a photo to a log entry

In `index.html`, inside the area's `log` array:

```js
photos: [
  { src:"assets/photos/my-new-photo.jpg", cap:"Short caption" }
]
```

Photos open in the lightbox on tap. Keep files under about 500 KB each so the
page stays quick on a phone.
