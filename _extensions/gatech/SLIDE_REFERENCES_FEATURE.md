# Per-Slide Citation References Feature

## Overview

This feature automatically displays full bibliographic references at the bottom of each slide where citations appear. This allows your audience to immediately see what paper or source you're referencing without waiting for the References slide at the end.

## Why This Feature Exists

In academic presentations, it's common to cite papers throughout your slides. Normally, audiences have to:
1. See a citation like "[1]" in your slide
2. Wait until the end of your presentation
3. Find the corresponding reference in the References slide

With this feature, the full reference (author, year, title, publication, etc.) appears right at the bottom of the slide where you cite it, providing immediate context to your audience.

## How It Works

### The Technical Flow

```
┌─────────────────────────────────────────────────────────────┐
│ 1. You write: [See @smith2020 for details]                  │
└─────────────────────────────────────────────────────────────┘
                           ↓
┌─────────────────────────────────────────────────────────────┐
│ 2. Quarto/Pandoc renders it as:                             │
│    "See [1] for details"                                    │
│    (with citation metadata in HTML)                         │
└─────────────────────────────────────────────────────────────┘
                           ↓
┌─────────────────────────────────────────────────────────────┐
│ 3. slide-refs.js (JavaScript) runs when slide loads         │
│    - Finds all citations on each slide                      │
│    - Looks up their full references from References slide   │
│    - Clones and appends them to the bottom of each slide    │
└─────────────────────────────────────────────────────────────┘
                           ↓
┌─────────────────────────────────────────────────────────────┐
│ 4. custom.scss (CSS) styles the references                  │
│    - Positions them at the bottom                           │
│    - Adds separator line and background                     │
│    - Makes text smaller and readable                        │
└─────────────────────────────────────────────────────────────┘
```

### File Structure

```
_extensions/gatech/
├── _extension.yml          # Configures the feature (includes JS)
├── custom.scss             # Styles the references (.slide-references)
├── assets/
│   └── slide-refs.js       # Core logic (finds and clones references)
└── SLIDE_REFERENCES_FEATURE.md  # This documentation file
```

## Usage

### Basic Citation

In your `.qmd` file:

```markdown
## My Slide

Some content here. [See @smith2020 for details]
```

Result on slide:
- Text shows: "Some content here. See [1] for details"
- Bottom of slide shows: "[1] Smith, J. (2020). Paper Title. Journal Name, 15(3), 123-145."

### Multiple Citations

```markdown
## My Slide

Based on recent work [@smith2020; @jones2021].
```

Result on slide:
- Text shows: "Based on recent work [1, 2]."
- Bottom of slide shows both references:
  - "[1] Smith, J. (2020)..."
  - "[2] Jones, A. (2021)..."

### Citation with Text

```markdown
## My Slide

As shown by @smith2020, the results are significant.
```

Result on slide:
- Text shows: "As shown by Smith (2020), the results are significant."
- Bottom of slide shows: "[1] Smith, J. (2020)..."

## Customization

### Changing Reference Position

Edit `_extensions/gatech/custom.scss`:

```scss
.reveal .slide-references {
  bottom: 100px;  // Move higher up the slide
  left: 40px;     // Less inset from left
  right: 40px;    // Less inset from right
}
```

### Changing Reference Size

```scss
.reveal .slide-references {
  font-size: 0.5em;  // Larger (default is 0.45em)
}
```

### Changing Background Opacity

```scss
.reveal .slide-references {
  background: rgba(255, 255, 255, 0.85);  // More transparent (was 0.95)
}
```

### Removing Background Entirely

```scss
.reveal .slide-references {
  background: transparent;
  border-top: 2px solid #333;  // Keep separator visible
}
```

### Changing Separator Style

```scss
.reveal .slide-references {
  border-top: 3px dashed #b3a369;  // Georgia Tech gold, dashed
}
```

### Changing Which Slides Get References

Edit `_extensions/gatech/assets/slide-refs.js`, line 68:

```javascript
// Default: Only level 2 slides (## headers)
document.querySelectorAll('.reveal .slides section.level2').forEach(slide => {

// Alternative: All slides including level 1
document.querySelectorAll('.reveal .slides section').forEach(slide => {
```

## Disabling the Feature

### Temporary Disable (One Presentation)

In your `.qmd` file header, override the include:

```yaml
format:
  revealjs:
    include-after-body: []
```

### Permanent Disable (All Presentations)

Edit `_extensions/gatech/_extension.yml` and comment out:

```yaml
# include-after-body:
#   - text: |
#       <script src="_extensions/gatech/assets/slide-refs.js"></script>
```

## Troubleshooting

### References Not Appearing

**Check 1: Do you have a References slide?**

Your `.qmd` needs:

```markdown
# References
## References
```

at the end.

**Check 2: Is your bibliography configured?**

Your YAML header needs:

```yaml
bibliography: references.bib
csl: _extensions/gatech/assets/ieee.csl
```

**Check 3: Open browser console (F12)**

Look for JavaScript errors. Common issues:
- Script path incorrect
- RevealJS not loaded yet

### References Appearing on Wrong Slides

This usually happens with nested sections. The JavaScript filters for `.level2` sections.

**Solution:** Ensure your presentation structure is:

```markdown
# Section (level 1 - creates section break)
## Slide 1 (level 2 - actual slide)
## Slide 2 (level 2 - actual slide)

# Another Section (level 1)
## Slide 3 (level 2)
```

### References Overlapping with Content

**Solution 1: Reduce reference font size**

```scss
.reveal .slide-references {
  font-size: 0.35em;  // Smaller
}
```

**Solution 2: Move references lower**

```scss
.reveal .slide-references {
  bottom: 40px;  // Closer to bottom edge
}
```

**Solution 3: Keep slides concise**

The references take up space, so design slides with this in mind.

### References Not Using IEEE Format

**Check:** Your YAML should have:

```yaml
csl: _extensions/gatech/assets/ieee.csl
```

**Alternative:** Use a different CSL file:

```yaml
csl: apa.csl  # Or any other CSL style
```

Find CSL files at: https://www.zotero.org/styles

## Advanced Customization Examples

### Different Styles for Different Reference Counts

Want references to look different when there's only one vs. many?

```scss
.reveal .slide-references {
  font-size: 0.45em;

  // If only one reference, make it larger
  .csl-entry:only-child {
    font-size: 1.2em;
  }
}
```

### Add Icon Before References

```scss
.reveal .slide-references::before {
  content: "📚 ";
  display: inline-block;
  margin-right: 8px;
}
```

### Fade In Animation

```scss
.reveal .slide-references {
  animation: fadeIn 0.5s ease-in;
}

@keyframes fadeIn {
  from { opacity: 0; }
  to { opacity: 1; }
}
```

### Custom Color for References Section

```scss
.reveal .slide-references {
  background: rgba(179, 163, 105, 0.1);  // Georgia Tech Gold tint
  border-top: 2px solid #b3a369;         // Gold border
}
```

## Integration with Other Features

### Works With

- ✅ All standard Quarto citation formats
- ✅ Multiple bibliographies
- ✅ Custom CSL styles
- ✅ RevealJS fragments and animations
- ✅ Speaker notes
- ✅ PDF export
- ✅ Two-column layouts

### Known Limitations

- References are client-side (JavaScript), so they won't appear in:
  - PDF export (unless you print from browser with JS enabled)
  - Static HTML viewers without JavaScript
- Very long reference lists may overflow the slide

## Maintenance Notes

### When Updating Quarto

If you update Quarto and references stop working:

1. Check if RevealJS HTML structure changed
2. Inspect a rendered slide's HTML (View Source)
3. Update selectors in `slide-refs.js` if needed

### When Updating the Theme

If you modify `custom.scss`, be careful not to change:
- `.reveal .slide-references` positioning
- `.csl-entry`, `.csl-left-margin`, `.csl-right-inline` display properties

These are critical for the feature to work correctly.

## Credits

This feature was developed to solve the common academic presentation problem of audiences not being able to see citation sources until the end of the talk.

**Implementation:**
- JavaScript: `slide-refs.js` (clones and positions references)
- CSS: `custom.scss` (styles the references)
- Integration: `_extension.yml` (enables the feature)

**Architecture Decision:**
We chose client-side JavaScript instead of a Lua filter because:
1. References are generated by Pandoc's citeproc after Lua filters run
2. JavaScript has direct access to the final HTML DOM
3. Easier to customize for users familiar with web development

## Questions or Issues?

If you encounter bugs or have feature requests, document them in your project's issue tracker or contact the theme maintainers.
