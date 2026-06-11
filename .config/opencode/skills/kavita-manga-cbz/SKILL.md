---
name: kavita-manga-cbz
description: Convert manga volume folders into Kavita-compatible CBZ archives with embedded ComicInfo.xml metadata.
license: MIT
compatibility: opencode
metadata:
  audience: users
  workflow: manga
---

## What this skill does

Converts a loose folder of manga volumes (each containing page images) into `.cbz` archives that Kavita can scan directly. Optionally embeds a `ComicInfo.xml` in volume 1 for metadata.

## When to use

Use this when you have downloaded manga volumes as folders of `.jpg` (or `.png`) images and want to serve them via Kavita.

## Process

### 1. Explore the structure

Check what the volume folders look like:

```bash
ls -la <series-directory>
```

Common patterns:

- **Flat**: `01/` → `cover.jpg`, `i-000.jpg`, `i-001.jpg`, … — images directly in volume folder
- **Double-nested**: `Series Name 1/` → `Series Name 1/` → `cover.jpg`, `i-000.jpg`, … — same-named subfolder inside each volume
- **Cover naming**: `cover.jpg`, `cover-01.jpg`, or `000-cover.jpg`

### 2. Determine naming convention

Use a consistent, sortable naming scheme:

```
Series Name v01.cbz
Series Name v02.cbz
…
```

Keep the series name in its original language.

### 3. Create the CBZ archives

For each volume, zip the images in sorted order using `ZIP_STORED` (no compression — JPEGs don't benefit from deflate). The archive member path should mirror the CBZ filename:

```
Series Name v01/
  cover.jpg
  i-000.jpg
  i-001.jpg
  …
  ComicInfo.xml       (v01 only)
```

Key rules:

- **Order**: sort alphabetically — zero-padded names (`i-000.jpg`) sort correctly
- **Cover**: if the cover is named `cover-XX.jpg` or `000-cover.jpg`, rename it to `cover.jpg` inside the archive
- **Compression**: use `ZIP_STORED` (not `ZIP_DEFLATED`) — faster on read, no size benefit for JPEGs

### 4. Add ComicInfo.xml (volume 1 only)

Embed a `ComicInfo.xml` inside the first volume's CBZ. Required fields:

| Field | Description |
|-------|-------------|
| `<Series>` | Series name in original language |
| `<Number>` | Volume number (1) |
| `<Count>` | Total number of volumes |
| `<Writer>` | Author name |
| `<Penciller>` | Author name (usually same as Writer) |
| `<Genre>` | Comma-separated genre tags |
| `<Summary>` | Brief synopsis |

Reference example (from Liar Game):

```xml
<?xml version="1.0"?>
<ComicInfo xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <Series>Liar Game</Series>
  <Writer>Shinobu Kaitani</Writer>
  <Penciller>Shinobu Kaitani</Penciller>
  <Genre>Psychological, Thriller, Drama, Mystery</Genre>
  <Summary>A congenitally honest college student named Nao Kanzaki receives a package containing 100 million yen and a card stating she is a contestant in the Liar Game Tournament...</Summary>
  <Count>19</Count>
</ComicInfo>
```

### 5. Cleanup

After each CBZ is successfully created, remove the original folder to avoid duplicates.

## Python reference

Use a script like this:

```python
import zipfile, os, shutil

volumes = [(1, "01"), (2, "02"), …]  # (vol_number, folder_name)

for vol_num, folder_name in volumes:
    cbz_name = f"Series Name v{vol_num:02d}.cbz"
    image_dir = os.path.join(BASE, folder_name)

    images = sorted([f for f in os.listdir(image_dir) if f.lower().endswith(('.jpg','.png'))])

    with zipfile.ZipFile(cbz_name, 'w', zipfile.ZIP_STORED) as zf:
        for img in images:
            src = os.path.join(image_dir, img)
            # Rename cover-XX.jpg → cover.jpg
            if img.startswith("cover-"):
                arcname = f"{cbz_name.replace('.cbz','')}/cover.jpg"
            else:
                arcname = f"{cbz_name.replace('.cbz','')}/{img}"
            zf.write(src, arcname)

        if vol_num == 1:
            zf.writestr(f"{cbz_name.replace('.cbz','')}/ComicInfo.xml", COMICINFO_XML)

    shutil.rmtree(image_dir)
```

Handle double-nested folders by adjusting `image_dir`:

```python
image_dir = os.path.join(BASE, folder_name, folder_name)  # when nested
```
