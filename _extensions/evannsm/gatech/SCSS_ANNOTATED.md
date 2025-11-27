# Annotated SCSS Source Code

This is a line-by-line explanation of `_extensions/gatech/custom.scss`.

## Full Source with Annotations

```scss
/*-- scss:defaults --*/
// ↑ Special comment that tells Quarto: "These are SCSS variables"
// Variables defined here are:
// - Available to use in the scss:rules section below
// - Automatically exported as CSS custom properties (--variable-name)
// - Can be overridden by importing this file in another SCSS file

// <!-- Primary Colors -->
// The foundation of Georgia Tech's visual identity
$tech-gold: #b3a369 !default;
// ↑ Georgia Tech's primary gold color
// !default means "use this value unless it's already defined"
// Used for: accents, highlights, branding elements

$navy-blue: #003057 !default;
// ↑ Georgia Tech's primary navy color
// Used for: body text, headers, primary UI elements
// This is the dominant color of the theme

$white: #ffffff !default;
// ↑ Standard white
// Used for: text on dark backgrounds, clean spaces

// <!-- Accessible Tech Gold (For fonts on white backgrounds) -->
// These variants ensure WCAG accessibility compliance
$tech-medium-gold: #a4925a !default;
// ↑ Slightly darker gold for better contrast on white
// Use when gold text appears on light backgrounds

$tech-dark-gold: #857437 !default;
// ↑ Even darker gold for maximum contrast
// Use for small text or when accessibility is critical

// <!-- Secondary Colors -->
// Supporting colors from Georgia Tech's extended palette
$gray-matter: #54585a !default;
// ↑ Dark gray for secondary text
// Used for: blockquote text, de-emphasized content

$pi-mile: #d6dbd4 !default;
// ↑ Light gray (named after landmarks at GT)
// Used for: subtle backgrounds, dividers

$diploma: #f9f6e5 !default;
// ↑ Cream/off-white color
// Used for: warm backgrounds, alternative to pure white

$buzz-gold: #eaaa00 !default;
// ↑ Bright, vibrant gold (more saturated than tech-gold)
// Used for: blockquote borders, attention-grabbing accents

// <!-- Tertiary Colors -->
// <!-- CMYK-Based Tertiaries -->
// These are print-friendly tertiary colors from GT's brand guidelines
$impact-purple: #5f249f !default;
$bold-blue: #3a5dae !default;
$olympic-teal: #008c95 !default;
$electric-blue: #64ccc9 !default;
$canopy-lime: #a4d233 !default;
$rat-cap: #ffcd00 !default;
$new-horizon: #e04f39 !default;

// Store CMYK tertiaries in a map (SCSS data structure)
// Maps are like JavaScript objects: "key": value
$tertiaries : (
  "purple": $impact-purple,
  "blue": $bold-blue,
  "teal": $olympic-teal,
  "electric": $electric-blue,
  "canopy": $canopy-lime,
  "cap": $rat-cap,
  "horizon": $new-horizon,
);
// ↑ This map isn't currently used by the theme,
// but is available for future expansion or custom use

// <!-- RGB-Based Tertiaries ("Brights") -->
// Screen-optimized vibrant colors for digital presentations
$bright-purple: #7800ff !default;   // More vibrant than impact-purple
$bright-blue: #2961ff !default;     // More vibrant than bold-blue
$bright-electric: #00ffff !default; // Pure cyan - very vibrant
$bright-canopy: #00ec9c !default;   // Bright teal-green
$bright-buzz: #ffcc00 !default;     // Bright yellow
$bright-horizon: #ff640f !default;  // Bright orange

// Store RGB brights in a map
$brights : (
  "purple": $bright-purple,
  "blue": $bright-blue,
  "electric": $bright-electric,
  "canopy": $bright-canopy,
  "buzz": $bright-buzz,
  "horizon": $bright-horizon,
);
// ↑ THIS map IS actively used!
// The @each loop at line 122 iterates over this map
// to generate .hl-purple, .hl-blue, etc. classes

// Additional utility colors
$navy-stroke: #171543 !default;      // Very dark blue for strokes/borders
$pi-mile-stroke: #808080 !default;   // Medium gray for strokes
$yellow: #fed76e !default;           // Soft yellow for notes

// Typography settings
$font-family-sans-serif: "Roboto" !default;
// ↑ Sets the font for the entire presentation
// Roboto is a clean, modern sans-serif from Google Fonts
// RevealJS will automatically load this font

$body-color: $navy-blue !default;
// ↑ Sets the default text color to navy blue (instead of black)
// This applies to all body text unless overridden

// Callout color mappings
// Quarto has 5 built-in callout types: note, tip, important, caution, warning
// We map each to a Georgia Tech color
$callout-color-note: $yellow !default;            // Soft yellow - friendly
$callout-color-tip: $canopy-lime !default;        // Green - helpful
$callout-color-caution: $new-horizon !default;    // Orange - alert
$callout-color-warning: $rat-cap !default;        // Bright yellow - warning
$callout-color-important: $electric-blue !default; // Blue - informational

// Layout defaults
// These are used by custom classes (like .hl-* classes)
$br-default: 10px;        // Border radius for rounded corners
$padding-default: 5px;    // Internal spacing
$margin-default: 5px;     // External spacing
$opacity-default: 0.5;    // Transparency level (50%)

/*-- scss:rules --*/
// ↑ Special comment that tells Quarto: "These are CSS rules"
// Everything from here on is compiled directly to CSS

// BACKGROUND IMAGE RULES
// RevealJS uses specific selectors for different slide types
// Each slide type gets its own background image

// Title slide background (the first slide with YAML frontmatter)
.reveal .backgrounds .quarto-title-block {
  background-image: url("/assets/background_title.png");
  // ↑ Absolute path from web root
  // Quarto copies assets from _extensions/gatech/assets/ to /assets/
  background-size: cover;
  // ↑ Scales image to cover entire slide, may crop edges
}

// Section slide background (slides with level 2 headers: ## Title)
.reveal .backgrounds .title-slide {
  background-image: url("/assets/background_section_blank.jpg");
  background-size: cover;
}

// Regular content slide background (default for all other slides)
.reveal .backgrounds {
  background-image: url("/assets/background_slide.png");
  background-size: cover;
}

// PDF EXPORT VERSIONS
// When exporting to PDF, RevealJS uses different selectors
// These rules ensure backgrounds appear in PDF output

.reveal .slides .pdf-page .slide-background.quarto-title-block {
  background-image: url("/assets/background_title.png");
  background-size: cover;
}

.reveal .slides .pdf-page .slide-background.title-slide.slide {
  background-image: url("/assets/background_section_blank.jpg");
  background-size: cover;
}

.reveal .slides .pdf-page .slide-background.slide {
  background-image: url("/assets/background_slide.png");
  background-size: cover;
}

// BLOCKQUOTE STYLING
// Customizes the appearance of markdown blockquotes (> text)
.reveal .slides blockquote {
  color: $gray-matter;
  // ↑ Uses secondary gray color (de-emphasizes quoted text)
  border-left: 4px solid $buzz-gold;
  // ↑ Adds a thick gold left border for visual interest
  // This is a common design pattern for blockquotes
}

// CUSTOM CLASSES
// These are utility classes you can use in your presentations

// Horizontal layout utility
.horiz {
  display: flex;
  // ↑ Activates flexbox layout system
  flex-direction: row;
  // ↑ Arranges children horizontally (default, but explicit is good)
  justify-content: center;
  // ↑ Centers children horizontally
  align-items: center;
  // ↑ Centers children vertically
  // Result: content is centered both horizontally and vertically
}
// Usage in markdown:
// ::: {.horiz}
// Content here will be arranged horizontally
// :::

// DYNAMIC HIGHLIGHT CLASSES
// This is the most complex part of the theme!
// It uses SCSS's @each loop to generate multiple classes

@each $color, $value in $brights {
  // ↑ Loop through the $brights map
  // $color = key ("purple", "blue", etc.)
  // $value = hex value (#7800ff, #2961ff, etc.)

  // Generate static highlight class
  .hl-#{$color} {
    // ↑ #{$color} is SCSS interpolation
    // Generates: .hl-purple, .hl-blue, .hl-electric, etc.

    margin: $margin-default;
    // ↑ 5px margin around the highlighted area

    padding: $padding-default;
    // ↑ 5px padding inside the highlighted area

    border-radius: $br-default;
    // ↑ 10px rounded corners

    background-color: rgba($value, $opacity-default);
    // ↑ SCSS rgba() function creates semi-transparent color
    // rgba(#7800ff, 0.5) = 50% transparent purple
    // This is the key to the highlight effect!
  }

  // Generate fragment version (for animation)
  // Fragments are RevealJS elements that appear on click
  .reveal .slides section .fragment.hl-#{$color} {
    background-color: rgba(0, 0, 0, 0);
    // ↑ Fully transparent initially
    // The highlight is invisible until the fragment is revealed
  }

  .reveal .slides section .fragment.hl-#{$color}.visible {
    // ↑ .visible class is added by RevealJS when fragment appears
    background-color: rgba($value, $opacity-default);
    // ↑ Now apply the colored highlight
    // This creates a smooth transition from transparent to highlighted
  }
}

// WHAT THIS LOOP GENERATES:
// .hl-purple { ... }
// .hl-blue { ... }
// .hl-electric { ... }
// .hl-canopy { ... }
// .hl-buzz { ... }
// .hl-horizon { ... }
//
// .fragment.hl-purple { ... }
// .fragment.hl-blue { ... }
// (etc.)
//
// .fragment.hl-purple.visible { ... }
// .fragment.hl-blue.visible { ... }
// (etc.)

// TOTAL OUTPUT: 18 classes (6 colors × 3 variants)
```

## How Each Section Works

### Section 1: SCSS Defaults (Lines 1-74)

**Purpose:** Define variables that control the entire theme

**Key Concepts:**
- `$variable-name` - SCSS variable syntax
- `!default` - Allows overriding if variable is already defined
- Variables are compiled to CSS custom properties: `--variable-name`
- Maps (`$brights`, `$tertiaries`) are SCSS data structures similar to objects

**Organization:**
1. Primary colors (core brand identity)
2. Accessible variants (WCAG compliance)
3. Secondary colors (supporting elements)
4. Tertiary colors (accents and highlights)
5. Typography (fonts and text color)
6. Callout mappings (connect Quarto features to colors)
7. Layout defaults (spacing and opacity)

### Section 2: SCSS Rules (Lines 75-138)

**Purpose:** Define CSS rules that style the presentation

**Key Concepts:**
- Uses variables from defaults section: `color: $navy-blue`
- Target specific RevealJS selectors: `.reveal .slides`
- Create utility classes: `.horiz`, `.hl-*`
- Use SCSS loops to generate multiple similar classes

**Organization:**
1. Background images (on-screen versions)
2. Background images (PDF export versions)
3. Blockquote styling
4. Custom utility classes
5. Dynamic highlight class generation

## Advanced SCSS Techniques Used

### 1. SCSS Interpolation
```scss
.hl-#{$color} { ... }
```
Inserts variable value into selector name. Generates `.hl-purple`, `.hl-blue`, etc.

### 2. SCSS Functions
```scss
rgba($value, $opacity-default)
```
SCSS's `rgba()` can take a hex color and convert it to rgba with specified opacity.

### 3. SCSS Loops
```scss
@each $color, $value in $brights { ... }
```
Iterates over map, generating multiple classes with one code block.

### 4. Nested Selectors
```scss
.reveal .slides section .fragment.hl-#{$color}.visible { ... }
```
Creates specific selectors targeting exact elements in RevealJS structure.

## Why This Structure?

### Variables in Defaults
- **Single source of truth** - Change `$navy-blue` once, updates everywhere
- **Easy customization** - Users only need to modify variable definitions
- **Exported to CSS** - Variables become `--navy-blue` for runtime access

### Rules in Separate Section
- **Standard CSS** - Familiar syntax for most developers
- **RevealJS targeting** - Uses specific selectors for slide types
- **Dynamic generation** - SCSS loops create many classes efficiently

### Background Image Strategy
- **Automatic application** - Different backgrounds for different slide types
- **PDF compatibility** - Duplicate rules ensure PDF export works
- **Cover sizing** - Images scale to fill slides

### Fragment Animation
- **Progressive reveal** - Content appears on click
- **Smooth transitions** - Transparent → colored background
- **RevealJS integration** - Uses `.visible` class added by RevealJS

## Compilation Example

**SCSS Input:**
```scss
$bright-purple: #7800ff;
$opacity-default: 0.5;

.hl-purple {
  background-color: rgba($bright-purple, $opacity-default);
}
```

**CSS Output:**
```css
:root {
  --bright-purple: #7800ff;
  --opacity-default: 0.5;
}

.hl-purple {
  background-color: rgba(120, 0, 255, 0.5);
}
```

**What happened:**
1. Variables exported to `:root` as CSS custom properties
2. `rgba()` converted hex to RGB values
3. Opacity applied to create semi-transparent purple

## Customization Tips

### Add a New Color
```scss
// In scss:defaults
$bright-green: #00ff00 !default;

$brights: (
  "purple": $bright-purple,
  // ... other colors ...
  "green": $bright-green,  // Add here
);

// No changes needed in scss:rules!
// The @each loop automatically generates .hl-green
```

### Change Highlight Opacity
```scss
// In scss:defaults
$opacity-default: 0.3;  // Changed from 0.5 to 0.3 (more transparent)
```

### Add Custom Class
```scss
// In scss:rules
.my-box {
  background-color: $tech-gold;
  padding: 20px;
  border: 2px solid $navy-blue;
  border-radius: 5px;
}
```

### Change Font
```scss
// In scss:defaults
$font-family-sans-serif: "Open Sans" !default;
```

## Summary

The theme's SCSS is organized into:

1. **Defaults** - Variables defining colors, typography, spacing
2. **Rules** - CSS rules styling the presentation

**Key features:**
- Comprehensive color system (primary, secondary, tertiary)
- Automatic background images for different slide types
- Dynamic class generation using SCSS loops
- Fragment animation support for progressive reveals
- Easy customization through variable modification

The theme leverages SCSS's power (variables, functions, loops) to create a maintainable, customizable presentation format that implements Georgia Tech's brand guidelines.
