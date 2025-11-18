# Georgia Tech Quarto RevealJS Theme - Complete Documentation

## Table of Contents
1. [Overview](#overview)
2. [Architecture](#architecture)
3. [How SCSS Compilation Works](#how-scss-compilation-works)
4. [Color System](#color-system)
5. [Background Images](#background-images)
6. [Typography](#typography)
7. [Custom Classes and Components](#custom-classes-and-components)
8. [Callout Styling](#callout-styling)
9. [Using the Theme](#using-the-theme)
10. [Customization Guide](#customization-guide)
11. [File Structure Reference](#file-structure-reference)

---

## Overview

This is a **Quarto extension** that provides Georgia Tech-branded styling for RevealJS presentations. The theme implements the official Georgia Tech color palette, typography, and branded background images to create professional, on-brand presentations.

**Key Features:**
- Official Georgia Tech color palette (primary, secondary, and tertiary colors)
- Branded background images for title, section, and content slides
- Custom highlight classes with animation support
- Standardized callout styling
- Flexible layout utilities
- 1600x900 presentation dimensions optimized for widescreen displays

---

## Architecture

### Extension System

Quarto uses an **extension system** to allow custom formats. This theme is packaged as a RevealJS format extension that lives in the `_extensions/gatech/` directory.

**How it works:**

1. **Extension Registration** (`_extension.yml`):
   ```yaml
   title: Gatech
   author: Brendan Gould and Evanns Morales
   version: 1.0.0
   quarto-required: ">=1.7.0"
   contributes:
     formats:
       revealjs:
         width: 1600
         height: 900
         theme: [custom.scss]
         format-resources:
           - assets
   ```

   This file tells Quarto:
   - The extension name is "Gatech"
   - It requires Quarto version 1.7.0 or higher
   - It contributes a `revealjs` format
   - The format uses `custom.scss` as its theme
   - The `assets/` folder should be included as a resource

2. **Theme Application**:
   When you use `format: gatech-revealjs` in your document, Quarto:
   - Loads the extension from `_extensions/gatech/`
   - Compiles `custom.scss` to CSS
   - Merges it with RevealJS base styles
   - Copies assets to the output directory
   - Generates the final presentation

### Directory Structure

```
quarto-gatech/
├── _extensions/gatech/           # Extension package
│   ├── _extension.yml            # Extension configuration
│   ├── custom.scss               # Theme SCSS (THE MAIN FILE)
│   └── assets/                   # Background images
│       ├── background_title.png
│       ├── background_slide.png
│       ├── background_section_blank.jpg
│       ├── background_section_building.jpg
│       ├── background_section_car.jpg
│       └── background_section_students.jpg
│
├── template.qmd                  # Example presentation
├── template.html                 # Generated output (ignored by git)
├── template_files/               # Generated files (ignored by git)
│   └── libs/
│       └── revealjs/            # Compiled RevealJS + theme
└── assets/                       # Copied assets (ignored by git)
```

**Why this structure?**
- `_extensions/` is the standard Quarto location for extensions
- `gatech/` is the extension name (used in `format: gatech-revealjs`)
- Source files (`_extension.yml`, `custom.scss`, `assets/`) are version-controlled
- Generated files (`template.html`, `template_files/`, output `assets/`) are excluded from git

---

## How SCSS Compilation Works

### SCSS Structure

The `custom.scss` file is divided into two sections marked by special comments:

#### 1. `/*-- scss:defaults --*/` (Lines 1-74)

This section defines **SCSS variables** that can be used throughout the theme and are automatically exported to CSS custom properties.

**What happens here:**
```scss
$tech-gold: #b3a369 !default;
$navy-blue: #003057 !default;
```

These variables:
- Are prefixed with `$` (SCSS syntax)
- Use `!default` flag (allows overriding if needed)
- Get compiled to CSS custom properties like `--tech-gold: #b3a369`
- Can be referenced in the rules section: `color: $navy-blue;`

**Why use variables?**
- Single source of truth for colors
- Easy to update the entire theme
- Can be overridden by importing this file in another SCSS file

#### 2. `/*-- scss:rules --*/` (Lines 75-138)

This section defines **CSS rules** that style the presentation elements.

**What happens here:**
```scss
.reveal .backgrounds .quarto-title-block {
  background-image: url("/assets/background_title.png");
  background-size: cover;
}
```

These rules:
- Use standard CSS/SCSS syntax
- Can reference variables from the defaults section
- Get compiled directly to CSS
- Target specific RevealJS elements

### Compilation Process

When you render your presentation:

```
custom.scss (SCSS)
    ↓
[Quarto SCSS Compiler]
    ↓
Compiled CSS
    ↓
[Merged with RevealJS base styles]
    ↓
template_files/libs/revealjs/dist/theme/quarto-[hash].css
```

**Example of compilation:**

SCSS Input:
```scss
$navy-blue: #003057;
$body-color: $navy-blue;

.reveal .slides blockquote {
  color: $gray-matter;
  border-left: 4px solid $buzz-gold;
}
```

CSS Output:
```css
:root {
  --navy-blue: #003057;
  --body-color: #003057;
}

.reveal .slides blockquote {
  color: #54585a;
  border-left: 4px solid #eaaa00;
}
```

---

## Color System

The theme implements a comprehensive color palette based on Georgia Tech's brand guidelines.

### Primary Colors (Lines 3-10)

```scss
$tech-gold: #b3a369      // Primary gold accent
$navy-blue: #003057      // Primary brand color (also body text)
$white: #ffffff          // White

// Accessible variations for WCAG compliance
$tech-medium-gold: #a4925a  // For text on white backgrounds
$tech-dark-gold: #857437    // Darker gold for better contrast
```

**Usage:** Headers, primary UI elements, body text

### Secondary Colors (Lines 12-16)

```scss
$gray-matter: #54585a    // Dark gray
$pi-mile: #d6dbd4        // Light gray
$diploma: #f9f6e5        // Cream/off-white
$buzz-gold: #eaaa00      // Bright gold accent
```

**Usage:** Secondary text, borders, accents (e.g., blockquote borders use `$buzz-gold`)

### Tertiary Colors - CMYK Based (Lines 18-36)

```scss
$impact-purple: #5f249f
$bold-blue: #3a5dae
$olympic-teal: #008c95
$electric-blue: #64ccc9
$canopy-lime: #a4d233
$rat-cap: #ffcd00
$new-horizon: #e04f39
```

Stored in a map for programmatic access:
```scss
$tertiaries: (
  "purple": $impact-purple,
  "blue": $bold-blue,
  "teal": $olympic-teal,
  "electric": $electric-blue,
  "canopy": $canopy-lime,
  "cap": $rat-cap,
  "horizon": $new-horizon,
);
```

**Usage:** Used for callout styling (caution, warning, important, tip)

### Tertiary Colors - RGB Based "Brights" (Lines 38-53)

```scss
$bright-purple: #7800ff
$bright-blue: #2961ff
$bright-electric: #00ffff
$bright-canopy: #00ec9c
$bright-buzz: #ffcc00
$bright-horizon: #ff640f
```

Stored in a map:
```scss
$brights: (
  "purple": $bright-purple,
  "blue": $bright-blue,
  "electric": $bright-electric,
  "canopy": $bright-canopy,
  "buzz": $bright-buzz,
  "horizon": $bright-horizon,
);
```

**Usage:** Dynamic highlight classes (`.hl-purple`, `.hl-blue`, etc.)

**Why two tertiary palettes?**
- CMYK tertiaries: More subdued, print-friendly
- RGB brights: More vibrant, screen-optimized for presentations

### Special Colors (Lines 55-67)

```scss
$navy-stroke: #171543      // Dark stroke color
$pi-mile-stroke: #808080   // Gray stroke
$yellow: #fed76e           // Light yellow for notes

// Callout color mappings
$callout-color-note: $yellow
$callout-color-tip: $canopy-lime
$callout-color-caution: $new-horizon
$callout-color-warning: $rat-cap
$callout-color-important: $electric-blue
```

These map Quarto's callout types to Georgia Tech colors.

---

## Background Images

The theme uses three different background images depending on slide type.

### Image Files (`_extensions/gatech/assets/`)

| File                              | Size   | Usage                  |
| --------------------------------- | ------ | ---------------------- |
| `background_title.png`            | 204 KB | Opening title slide    |
| `background_slide.png`            | 28 KB  | Regular content slides |
| `background_section_blank.jpg`    | 41 KB  | Section divider slides |
| `background_section_building.jpg` | 113 KB | Alternative section bg |
| `background_section_car.jpg`      | 113 KB | Alternative section bg |
| `background_section_students.jpg` | 121 KB | Alternative section bg |

### Background Rules (Lines 77-105)

The theme applies backgrounds using CSS selectors:

#### 1. Title Slide Background (Lines 77-80, 92-95)

```scss
.reveal .backgrounds .quarto-title-block {
  background-image: url("/assets/background_title.png");
  background-size: cover;
}
```

**Triggers:** The first slide with YAML frontmatter (title, author, date)
**Appearance:** Georgia Tech branding with logo and graphics

#### 2. Section Slide Background (Lines 82-85, 97-100)

```scss
.reveal .backgrounds .title-slide {
  background-image: url("/assets/background_section_blank.jpg");
  background-size: cover;
}
```

**Triggers:** Slides created with `## Section Title` (level 1 headers in reveal)
**Appearance:** Branded section divider background

#### 3. Content Slide Background (Lines 87-90, 102-105)

```scss
.reveal .backgrounds {
  background-image: url("/assets/background_slide.png");
  background-size: cover;
}
```

**Triggers:** All other slides
**Appearance:** Subtle Georgia Tech branding in corner

### Why Duplicate Rules?

Notice each background has two rule sets:
- `.reveal .backgrounds` - For on-screen presentation
- `.reveal .slides .pdf-page .slide-background` - For PDF export

This ensures backgrounds appear correctly both in browser and when exported to PDF.

### Asset Path Resolution

Paths are absolute: `url("/assets/background_title.png")`

**How it works:**
1. Extension config specifies `format-resources: - assets`
2. Quarto copies `_extensions/gatech/assets/` to output `/assets/`
3. CSS references use absolute paths from web root
4. Browser/PDF renderer resolves paths correctly

---

## Typography

### Font Family (Line 59)

```scss
$font-family-sans-serif: "Roboto" !default;
```

**Implementation:**
- Roboto is a modern, readable sans-serif font
- The `!default` flag means it can be overridden
- RevealJS will load this font from its font resources

### Body Text Color (Line 61)

```scss
$body-color: $navy-blue !default;
```

All body text uses Georgia Tech's navy blue (`#003057`) instead of black, maintaining brand consistency while ensuring readability.

---

## Custom Classes and Components

### Horizontal Layout Class (Lines 115-120)

```scss
.horiz {
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
}
```

**Usage in markdown:**
```markdown
::: {.horiz}
Content arranged horizontally
:::
```

**What it does:**
- Creates a flexbox container
- Arranges children in a row
- Centers items both horizontally and vertically

**Example use cases:**
- Side-by-side images
- Logo arrangements
- Multi-column layouts

### Blockquote Styling (Lines 107-110)

```scss
.reveal .slides blockquote {
  color: $gray-matter;
  border-left: 4px solid $buzz-gold;
}
```

**Usage in markdown:**
```markdown
> This is a quote
```

**Appearance:**
- Text in gray matter color (`#54585a`)
- 4px bright gold left border (`#eaaa00`)
- Distinctive Georgia Tech styling

---

## Highlight Classes with Animation

The theme dynamically generates highlight classes for all "bright" colors.

### Generated Classes (Lines 122-137)

```scss
@each $color, $value in $brights {
  .hl-#{$color} {
    margin: $margin-default;           // 5px
    padding: $padding-default;         // 5px
    border-radius: $br-default;        // 10px
    background-color: rgba($value, $opacity-default);  // 50% opacity
  }

  .reveal .slides section .fragment.hl-#{$color} {
    background-color: rgba(0, 0, 0, 0);  // Transparent initially
  }

  .reveal .slides section .fragment.hl-#{$color}.visible {
    background-color: rgba($value, $opacity-default);  // Colored when visible
  }
}
```

### How It Works

**1. SCSS Loop:**
The `@each` loop iterates over the `$brights` map and generates classes for each color:
- `purple` → `.hl-purple`
- `blue` → `.hl-blue`
- `electric` → `.hl-electric`
- `canopy` → `.hl-canopy`
- `buzz` → `.hl-buzz`
- `horizon` → `.hl-horizon`

**2. Static Highlighting:**
```scss
.hl-purple {
  margin: 5px;
  padding: 5px;
  border-radius: 10px;
  background-color: rgba(#7800ff, 0.5);  // 50% transparent purple
}
```

**3. Fragment Animation:**
RevealJS "fragments" are elements that appear on click.

```scss
// Initially transparent
.fragment.hl-purple {
  background-color: transparent;
}

// Highlighted when visible
.fragment.hl-purple.visible {
  background-color: rgba(#7800ff, 0.5);
}
```

### Usage Examples

**Static highlight:**
```markdown
::: {.hl-purple}
This text has a purple highlight
:::
```

**Animated highlight (appears on click):**
```markdown
::: {.fragment .hl-blue}
This text appears with blue highlight when you click
:::
```

**Multiple fragments:**
```markdown
::: {.fragment .hl-canopy}
First click: canopy green highlight
:::

::: {.fragment .hl-horizon}
Second click: orange highlight
:::
```

---

## Callout Styling

Quarto has built-in callout blocks with five types. The theme maps these to Georgia Tech colors.

### Color Mappings (Lines 63-67)

```scss
$callout-color-note: $yellow           // #fed76e (light yellow)
$callout-color-tip: $canopy-lime       // #a4d233 (lime green)
$callout-color-caution: $new-horizon   // #e04f39 (red-orange)
$callout-color-warning: $rat-cap       // #ffcd00 (bright yellow)
$callout-color-important: $electric-blue  // #64ccc9 (teal)
```

### Usage in Presentations

```markdown
::: {.callout-note}
## Note
This is a note callout with yellow styling
:::

::: {.callout-tip}
## Tip
This is a tip callout with lime green styling
:::

::: {.callout-important}
## Important
This is an important callout with electric blue styling
:::

::: {.callout-caution}
## Caution
This is a caution callout with red-orange styling
:::

::: {.callout-warning}
## Warning
This is a warning callout with bright yellow styling
:::
```

### Visual Appearance

Quarto automatically:
- Adds an icon for each callout type
- Styles the border and background using the specified color
- Creates a header bar with the title
- Formats the content area

---

## Using the Theme

### Installation

1. **Clone or copy this repository:**
   ```bash
   git clone <repository-url> quarto-gatech
   cd quarto-gatech
   ```

2. **The extension is already installed** in `_extensions/gatech/`

### Creating a Presentation

1. **Create a new `.qmd` file:**
   ```bash
   touch my-presentation.qmd
   ```

2. **Add frontmatter:**
   ```yaml
   ---
   title: "My Presentation Title"
   subtitle: "Optional Subtitle"
   author: "Your Name"
   date: "2025-11-18"
   format:
     gatech-revealjs: default
   ---
   ```

3. **Add content:**
   ```markdown
   ## First Section

   This is a section divider slide.

   ### Content Slide

   - Bullet point 1
   - Bullet point 2

   ::: {.hl-purple}
   Highlighted text
   :::

   ### Another Slide

   ::: {.callout-tip}
   ## Pro Tip
   Use fragments for progressive reveal!
   :::

   ::: {.fragment .hl-blue}
   This appears on click
   :::
   ```

4. **Render:**
   ```bash
   quarto render my-presentation.qmd
   ```

   Or use preview mode:
   ```bash
   quarto preview my-presentation.qmd
   ```

### Slide Structure

**Title Slide (automatic):**
- Created from YAML frontmatter
- Uses `background_title.png`

**Section Slides (level 2 headers):**
```markdown
## Section Name
```
- Uses `background_section_blank.jpg`
- Acts as dividers between sections

**Content Slides (level 3 headers):**
```markdown
### Slide Title
```
- Uses `background_slide.png`
- Regular presentation content

---

## Customization Guide

### Changing Colors

**Location:** `_extensions/gatech/custom.scss`

**To change a color:**
1. Find the variable in the `scss:defaults` section
2. Update the hex value
3. Re-render your presentation

**Example - Change primary gold:**
```scss
$tech-gold: #b3a369 !default;  // Original
$tech-gold: #FFD700 !default;  // Changed to bright gold
```

### Changing Background Images

**Option 1: Replace image files**
1. Navigate to `_extensions/gatech/assets/`
2. Replace the image files (keep same names)
3. Ensure new images are optimized for web
4. Re-render

**Option 2: Use different image files**
1. Add new images to `assets/`
2. Update paths in `custom.scss` (lines 78, 83, 88)
3. Example:
   ```scss
   background-image: url("/assets/my-custom-title.png");
   ```

### Adding New Highlight Colors

**Add a new color to the brights map:**
```scss
$bright-orange: #ff6600 !default;

$brights: (
  "purple": $bright-purple,
  "blue": $bright-blue,
  "electric": $bright-electric,
  "canopy": $bright-canopy,
  "buzz": $bright-buzz,
  "horizon": $bright-horizon,
  "orange": $bright-orange,  // New color
);
```

This automatically generates `.hl-orange` class!

### Changing Typography

**Change font:**
```scss
$font-family-sans-serif: "Open Sans" !default;
```

**Change body text color:**
```scss
$body-color: #000000 !default;  // Black instead of navy
```

### Adjusting Spacing Defaults (Lines 70-73)

```scss
$br-default: 10px;           // Border radius
$padding-default: 5px;       // Internal spacing
$margin-default: 5px;        // External spacing
$opacity-default: 0.5;       // Highlight transparency
```

These affect all highlight classes and custom components.

### Creating New Custom Classes

Add new classes in the `scss:rules` section:

```scss
.my-custom-class {
  background-color: $tech-gold;
  padding: 20px;
  border: 2px solid $navy-blue;
}
```

Use in markdown:
```markdown
::: {.my-custom-class}
Content here
:::
```

---

## File Structure Reference

### Version-Controlled Files (in Git)

```
_extensions/gatech/
├── _extension.yml        # Extension configuration
├── custom.scss          # Theme source (EDIT THIS)
└── assets/              # Background images (REPLACE THESE)
    ├── background_title.png
    ├── background_slide.png
    ├── background_section_blank.jpg
    ├── background_section_building.jpg
    ├── background_section_car.jpg
    └── background_section_students.jpg

template.qmd             # Example presentation source
README.md                # Project readme
.gitignore              # Git ignore rules
```

### Generated Files (Ignored by Git)

```
template.html            # Rendered presentation
template_files/          # Supporting files
└── libs/
    ├── revealjs/       # RevealJS library + compiled theme
    │   └── dist/theme/quarto-[hash].css  # Final compiled CSS
    └── quarto-html/    # Quarto HTML utilities
assets/                  # Copied background images
```

### Key File Locations

| File                                            | Purpose              | Edit?                  |
| ----------------------------------------------- | -------------------- | ---------------------- |
| `_extensions/gatech/_extension.yml`             | Extension config     | Rarely                 |
| `_extensions/gatech/custom.scss`                | **Theme source**     | **YES**                |
| `_extensions/gatech/assets/*.png`               | Background images    | Replace as needed      |
| `template.qmd`                                  | Example presentation | Create your own        |
| `template_files/libs/revealjs/dist/theme/*.css` | Compiled output      | Never (auto-generated) |

---

## Advanced Topics

### SCSS Variables vs CSS Custom Properties

**SCSS variables** (`$tech-gold`):
- Only exist during compilation
- Cannot be changed at runtime
- Used in calculations and functions
- Scoped to SCSS files

**CSS custom properties** (`--tech-gold`):
- Exist in compiled CSS
- Can be changed with JavaScript
- Can be overridden in specific elements
- Available in browser DevTools

Quarto automatically exports SCSS variables as CSS custom properties in the `:root` scope.

### Inheritance and Overriding

The theme uses RevealJS's theme layering:

```
RevealJS base styles
    ↓
Quarto enhancements
    ↓
custom.scss (this theme)
```

**To override:**
- More specific selectors win
- Later rules override earlier rules
- Use `!important` as last resort (not recommended)

### PDF Export

When exporting to PDF:
```bash
quarto render my-presentation.qmd --to revealjs-pdf
```

The theme includes PDF-specific background rules (lines 92-105) to ensure backgrounds appear in the PDF output.

---

## Troubleshooting

### Backgrounds not showing

**Check:**
1. Asset files exist in `_extensions/gatech/assets/`
2. Paths are correct (absolute from web root)
3. Files aren't corrupted
4. Re-render with `quarto render --no-cache`

### Colors not applying

**Check:**
1. SCSS syntax is correct (colons, semicolons)
2. Variables defined before use
3. Quarto version >= 1.7.0
4. Re-render to recompile SCSS

### Custom classes not working

**Check:**
1. Class defined in `scss:rules` section (not `scss:defaults`)
2. Selector specificity (might need `.reveal .slides`)
3. Syntax errors in SCSS
4. Browser cache (hard refresh with Ctrl+Shift+R)

---

## Resources

- **Quarto Documentation:** https://quarto.org/docs/presentations/revealjs/
- **RevealJS Documentation:** https://revealjs.com/
- **SCSS Documentation:** https://sass-lang.com/documentation/
- **Georgia Tech Brand Guidelines:** (consult official GT brand resources)

---

## Summary

This Georgia Tech RevealJS theme is a well-architected Quarto extension that:

1. **Uses SCSS** for maintainable, variable-based styling
2. **Implements GT branding** through colors, typography, and backgrounds
3. **Provides custom utilities** like highlight classes and layout helpers
4. **Supports animations** through RevealJS fragment system
5. **Exports easily** to both HTML and PDF formats
6. **Remains customizable** through SCSS variables and asset replacement

The core of the theme is `custom.scss`, which compiles to CSS and merges with RevealJS base styles to create a professional, branded presentation format.
