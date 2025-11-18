# Georgia Tech Theme - Quick Reference

## Document Setup

```yaml
---
title: "My Presentation"
subtitle: "Optional Subtitle"
author:
    - name: Author Name
    affiliation: 
      - Your Affiliation
    email: your.email@example.com

date: last-modified
date-format: "MMMM D, YYYY"
---
```

## Slide Structure

```markdown
# Section Title              # Level 1 = Section slide (with section background)

## Slide Title              # Level 2 = Content slide (with regular background)

Content goes here
```

## Highlight Classes

### Static Highlights

```markdown
::: {.hl-purple}
Purple highlighted text
:::

::: {.hl-blue}
Blue highlighted text
:::

::: {.hl-electric}
Electric (cyan) highlighted text
:::

::: {.hl-canopy}
Canopy (green) highlighted text
:::

::: {.hl-buzz}
Buzz (yellow) highlighted text
:::

::: {.hl-horizon}
Horizon (orange) highlighted text
:::
```

### Animated Highlights (Fragment)

```markdown
::: {.fragment .hl-purple}
This appears on click with purple highlight
:::

::: {.fragment .hl-blue}
This appears on next click with blue highlight
:::
```

## Callouts

```markdown
::: {.callout-note}
## Note Title
Note content with yellow styling
:::

::: {.callout-tip}
## Tip Title
Tip content with lime green styling
:::

::: {.callout-important}
## Important
Important content with electric blue styling
:::

::: {.callout-caution}
## Caution
Caution content with red-orange styling
:::

::: {.callout-warning}
## Warning
Warning content with bright yellow styling
:::
```

## Layout Classes

### Horizontal Layout

```markdown
::: {.horiz}
![](image1.png){width=300}
![](image2.png){width=300}
:::
```

Arranges content in a horizontal row, centered.

## Blockquotes

```markdown
> This is a quote with gray text and gold left border
```

## Common RevealJS Options

```yaml
format:
  gatech-revealjs:
    slide-number: true              # Show slide numbers
    incremental: true               # Lists appear one item at a time
    transition: slide               # Transition effect (slide, fade, none, etc.)
    navigation-mode: linear         # Linear navigation (no vertical slides)
    controls: true                  # Show navigation controls
    progress: true                  # Show progress bar
    mouse-wheel: false              # Disable scroll navigation
    preview-links: false            # Open links in iframe
```

## Fragments (Progressive Reveal)

```markdown
::: {.fragment}
Appears on click
:::

::: {.fragment .fade-in}
Fades in
:::

::: {.fragment .fade-out}
Fades out
:::

::: {.fragment .highlight-current-blue}
Highlighted in blue when current
:::

::: {.fragment .grow}
Grows when appearing
:::

::: {.fragment .shrink}
Shrinks when appearing
:::
```

## Columns

```markdown
::: {.columns}

:::: {.column width="50%"}
Left column content
::::

:::: {.column width="50%"}
Right column content
::::

:::
```

## Images

```markdown
![Caption text](image.png)

![Caption](image.png){width=500}

![Caption](image.png){.absolute top=100 left=50 width=300}
```

## Speaker Notes

```markdown
::: {.notes}
These are speaker notes.
Only visible in presenter mode (press 's' during presentation).
:::
```

## Code Blocks

````markdown
```python
def hello():
    print("Hello, Georgia Tech!")
```
````

With highlighting:

````markdown
```{.python code-line-numbers="1-2|3-4"}
def hello():
    print("Hello, Georgia Tech!")
def goodbye():
    print("Goodbye!")
```
````

## Color Palette Quick Reference

| Color Name      | Hex Code  | Usage                    |
| --------------- | --------- | ------------------------ |
| Navy Blue       | `#003057` | Primary brand, body text |
| Tech Gold       | `#b3a369` | Primary accent           |
| Buzz Gold       | `#eaaa00` | Bright accent            |
| Gray Matter     | `#54585a` | Secondary text           |
| Bright Purple   | `#7800ff` | `.hl-purple`             |
| Bright Blue     | `#2961ff` | `.hl-blue`               |
| Bright Electric | `#00ffff` | `.hl-electric`           |
| Bright Canopy   | `#00ec9c` | `.hl-canopy`             |
| Bright Buzz     | `#ffcc00` | `.hl-buzz`               |
| Bright Horizon  | `#ff640f` | `.hl-horizon`            |

## Rendering Commands

```bash
# Render to HTML
quarto render presentation.qmd

# Preview with live reload
quarto preview presentation.qmd

# Render to PDF
quarto render presentation.qmd --to pdf

# Render to PowerPoint
quarto render presentation.qmd --to pptx
```

## Keyboard Shortcuts (During Presentation)

| Key        | Action                   |
| ---------- | ------------------------ |
| `f`        | Fullscreen               |
| `s`        | Speaker notes view       |
| `o`        | Overview mode            |
| `b`        | Pause (black screen)     |
| `?`        | Show keyboard shortcuts  |
| `Esc`      | Exit fullscreen/overview |
| Arrow keys | Navigate slides          |
| Space      | Next slide               |

## File Locations for Customization

| What to Change   | File Location                                   |
| ---------------- | ----------------------------------------------- |
| Colors           | `_extensions/gatech/custom.scss` (lines 3-67)   |
| Backgrounds      | `_extensions/gatech/assets/`                    |
| Background paths | `_extensions/gatech/custom.scss` (lines 77-105) |
| Typography       | `_extensions/gatech/custom.scss` (line 59)      |
| Spacing defaults | `_extensions/gatech/custom.scss` (lines 70-73)  |

## Example Presentation Structure

```markdown
---
title: "My Research"
subtitle: "Georgia Tech"
author: "John Doe"
date: "2025-11-18"
format:
  gatech-revealjs:
    slide-number: true
    incremental: false
---

# Introduction {.section}

## Research Question

::: {.hl-purple}
What is the impact of X on Y?
:::

## Methodology

::: {.columns}
:::: {.column width="50%"}
- Data collection
- Statistical analysis
::::
:::: {.column width="50%"}
![](methodology.png)
::::
:::

# Results {.section}

## Key Findings

::: {.fragment .hl-blue}
Finding 1: Significant correlation
:::

::: {.fragment .hl-canopy}
Finding 2: Positive trend
:::

::: {.callout-important}
## Critical Insight
This changes everything!
:::

# Conclusion {.section}

## Summary

::: {.fragment}
- Major contribution 1
:::

::: {.fragment}
- Major contribution 2
:::

::: {.fragment .hl-horizon}
**Thank you for your attention!**
:::
```

## Troubleshooting

| Issue                   | Solution                                                |
| ----------------------- | ------------------------------------------------------- |
| Backgrounds not showing | Check paths in `custom.scss`, ensure files in `assets/` |
| Colors not applying     | Re-render with `quarto render --no-cache`               |
| Fragments not working   | Ensure `.fragment` class is used correctly              |
| PDF export issues       | Use `quarto render file.qmd --to pdf`                   |

For detailed documentation, see [THEME_DOCUMENTATION.md](_extensions/gatech/THEME_DOCUMENTATION.md)
