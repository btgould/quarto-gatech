# Documentation Index: Per-Slide Citations Feature

This document helps you find the information you need about the per-slide citations feature.

## Quick Links

| What You Want | Where to Look |
|---------------|---------------|
| **Quick usage examples** | `README_CITATIONS.md` |
| **Full technical details** | `SLIDE_REFERENCES_FEATURE.md` |
| **Configuration** | `_extension.yml` (lines 11-13) |
| **JavaScript code** | `assets/slide-refs.js` |
| **Styling/positioning** | `custom.scss` (lines 139-209) |

## File Overview

### Documentation Files (Read These)

#### `README_CITATIONS.md` ⭐ START HERE
- **Purpose:** Quick reference guide
- **Contains:**
  - Simple explanation of what the feature does
  - Common customization snippets
  - Troubleshooting table
  - Quick test example
- **Read when:** You need to quickly customize something or troubleshoot

#### `SLIDE_REFERENCES_FEATURE.md` 📚 COMPREHENSIVE GUIDE
- **Purpose:** Complete technical documentation
- **Contains:**
  - How it works (technical flow diagram)
  - File structure explanation
  - Usage examples (basic, multiple, with text)
  - Customization examples (position, size, style)
  - Advanced examples (animations, icons, conditional styling)
  - Troubleshooting with solutions
  - Integration notes
  - Maintenance guidance
- **Read when:** You want to understand how it works or do advanced customization

#### `DOCUMENTATION_INDEX.md` 📋 THIS FILE
- **Purpose:** Navigate all documentation
- **Contains:** Links to all other documentation and code
- **Read when:** You're not sure where to find something

### Code Files (Edit These)

#### `assets/slide-refs.js` 🔧 CORE LOGIC
- **Purpose:** JavaScript that implements the feature
- **Contains:**
  - Header block: Overview of what the script does
  - Heavily commented code explaining each step:
    1. Collect references from References slide
    2. Process each individual slide
    3. Find citations on each slide
    4. Extract citation keys
    5. Append references to slides
- **Edit when:**
  - Debugging issues
  - Changing which slides get references
  - Modifying how references are detected
  - Understanding the implementation
- **Comment style:** Step-by-step with rationale

#### `custom.scss` 🎨 STYLING
- **Lines:** 139-209
- **Purpose:** CSS that positions and styles the references
- **Contains:**
  - Header block: Overview of positioning strategy and visual design
  - Inline comments explaining each property
  - Examples of customizations in the header
- **Edit when:**
  - Changing position (bottom, left, right)
  - Changing appearance (size, color, background)
  - Adjusting spacing or layout
  - Modifying separator style
- **Comment style:** Purpose and customization guidance

#### `_extension.yml` ⚙️ CONFIGURATION
- **Lines:** 11-13
- **Purpose:** Configures the Quarto extension
- **Contains:**
  - Minimal configuration
  - include-after-body: Loads slide-refs.js
  - For detailed documentation, see README files
- **Edit when:**
  - Enabling/disabling the feature (comment out lines 11-13)
  - Configuring extension-level settings

## Documentation Philosophy

The documentation is organized by audience and use case:

```
Want to use it?           → README_CITATIONS.md
Need quick customization? → README_CITATIONS.md
Want to understand it?    → SLIDE_REFERENCES_FEATURE.md
Need to modify code?      → Read comments in .js/.scss
```

## Code Comment Structure

### JavaScript (`slide-refs.js`)
```javascript
/**
 * Large header block:
 * - What the feature does
 * - Why it exists
 * - How it works (high level)
 * - Usage examples
 * - Customization pointers
 */

// STEP 1: High-level step description
// ---------------------------------------------
// Detailed explanation of what this section does
code();

// Inline comment explaining why/how
moreCode();
```

### SCSS (`custom.scss`)
```scss
// ============================================================
// SECTION HEADER
// ============================================================
// Purpose of this section
// How it works
// Customization examples
//
.selector {
  property: value;  // What this does and why
}
```

## Finding Specific Information

### "How do I change X?"

| What to Change | Where to Look | What to Edit |
|----------------|---------------|--------------|
| Position (up/down/left/right) | `custom.scss` line 167-169 | `bottom`, `left`, `right` values |
| Text size | `custom.scss` line 172 | `font-size` value |
| Background color/opacity | `custom.scss` line 181 | `background` rgba values |
| Separator line style | `custom.scss` line 176 | `border-top` properties |
| Which slides get references | `slide-refs.js` line 68 | querySelector selector |
| Enable/disable feature | `_extension.yml` line 53-55 | Comment out include-after-body |

### "Why isn't it working?"

1. **First:** Check `README_CITATIONS.md` → Troubleshooting table
2. **Then:** Check `SLIDE_REFERENCES_FEATURE.md` → Troubleshooting section
3. **Finally:** Read comments in `slide-refs.js` to understand the logic

### "How does X work internally?"

1. **High-level:** `SLIDE_REFERENCES_FEATURE.md` → "How It Works" section
2. **Architecture:** `_extension.yml` → Comment lines 30-52
3. **Implementation:** `slide-refs.js` → Read through step-by-step comments

### "Can I do Y with this feature?"

1. **Common customizations:** `README_CITATIONS.md` → Common Customizations
2. **Advanced customizations:** `SLIDE_REFERENCES_FEATURE.md` → Advanced Examples
3. **Limitations:** `SLIDE_REFERENCES_FEATURE.md` → Known Limitations

## Maintenance Guide

### When You Return to This Code

1. **Forgot how to use it?**
   - Open `README_CITATIONS.md` for quick reference
   - Or open `SLIDE_REFERENCES_FEATURE.md` for full details

2. **Need to modify styling?**
   - Open `custom.scss`, go to line 139
   - Read the header comment for customization examples
   - Edit properties with inline comment guidance

3. **Need to debug JavaScript?**
   - Open `slide-refs.js`
   - Read the header block for overview
   - Follow STEP 1-5 comments through the code
   - Each line has comments explaining why

4. **Forgot what files are involved?**
   - Open this file (`DOCUMENTATION_INDEX.md`)
   - Check "File Overview" section

### When Sharing This Code

Point people to:
1. `README_CITATIONS.md` for users
2. `SLIDE_REFERENCES_FEATURE.md` for detailed documentation
3. Code files have inline comments for developers

## Summary

Documentation is organized into separate files:

✅ **JavaScript** (`slide-refs.js`) - Step-by-step logic explanation with inline comments
✅ **SCSS** (`custom.scss`) - Property-by-property styling notes with customization examples
✅ **README** (`README_CITATIONS.md`) - Quick reference and troubleshooting
✅ **Feature Doc** (`SLIDE_REFERENCES_FEATURE.md`) - Comprehensive guide
✅ **This Index** (`DOCUMENTATION_INDEX.md`) - Navigation and organization

**Configuration files (`_extension.yml`, `template.qmd`) are kept clean - all documentation is in separate README files.**
