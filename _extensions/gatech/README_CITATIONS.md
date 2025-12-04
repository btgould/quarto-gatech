# Quick Reference: Per-Slide Citations

## What Does This Do?

Citations like `[@smith2020]` automatically show their full reference at the bottom of the slide where they appear.

```
Your slide text with citation [1] ←───────────┐
                                              │
                                              │
─────────────────────────────────────────     │ Links these
[1] Smith, J. (2020). Paper Title... ←────────┘
```

## Usage

Just cite normally in your `.qmd` file:

```markdown
## My Slide

This is interesting [see @smith2020].
```

The reference appears automatically at the slide bottom.

## Files Involved

| File | Purpose | Edit When You Want To... |
|------|---------|--------------------------|
| `assets/slide-refs.js` | Finds citations and adds references | Change which slides get references or debugging |
| `custom.scss` (lines 139-209) | Styles the reference display | Change position, size, colors, or appearance |
| `_extension.yml` (lines 53-55) | Enables the feature | Disable the feature entirely |
| `SLIDE_REFERENCES_FEATURE.md` | Full documentation | Learn how it works in detail |

## Common Customizations

### Make References Smaller

In `custom.scss`, line 172:

```scss
font-size: 0.35em;  // Was 0.45em
```

### Move References Higher/Lower

In `custom.scss`, line 167:

```scss
bottom: 100px;  // Was 60px (higher up)
bottom: 30px;   // Was 60px (lower down)
```

### Change Background Transparency

In `custom.scss`, line 181:

```scss
background: rgba(255, 255, 255, 0.85);  // Was 0.95 (more transparent)
```

### Remove Background Completely

In `custom.scss`, line 181:

```scss
background: transparent;
```

### Disable Feature Temporarily

In your `.qmd` header:

```yaml
format:
  revealjs:
    include-after-body: []
```

### Disable Feature Permanently

In `_extension.yml`, comment out lines 53-55:

```yaml
# include-after-body:
#   - text: |
#       <script src="_extensions/gatech/assets/slide-refs.js"></script>
```

## Troubleshooting

| Problem | Solution |
|---------|----------|
| References not showing | Ensure you have `# References` section at end of `.qmd` |
| All references on every slide | Check slide structure (use `## ` for slides, `# ` for sections) |
| Overlapping text | Reduce `font-size` or increase `bottom` value in CSS |
| Wrong citation style | Check `csl:` in YAML header |

## Quick Test

Add this to a slide:

```markdown
## Test Slide

Testing citations [@10684122].
```

Render and check if the full reference appears at the bottom of that slide.

## More Info

See `SLIDE_REFERENCES_FEATURE.md` for complete documentation including:
- How it works under the hood
- Advanced customization examples
- Integration notes
- Known limitations
