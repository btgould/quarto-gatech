# quarto-gatech

A Quarto format extension that applies Georgia Tech brand identity to RevealJS presentations.

## Install

```bash
quarto use template btgould/quarto-gatech
```

## Use

```yaml
---
title: My Talk
format: gatech-revealjs
---
```

Section headings (`#`) and slide headings (`##`) get GT-branded background images automatically. See `template.qmd` for a starting point.
Also uses official fonts and color scheme.

## Per-slide references

Every deck using `gatech-revealjs` shows the references it cites on each
slide, as a compact aside at the bottom of that slide. Full entries still
appear in the end-of-deck bibliography, and inline citations keep their
usual styling and hover popups.

Citations inside a fragment (`. . .` pauses or `:::{.fragment}` blocks)
appear along with that fragment; citations outside any fragment appear as
soon as the slide does. Decks without citations are unaffected.

Venue names are abbreviated in the asides according to
`_extensions/gatech/citation-abbrev.lua` — "Advances in Neural Information
Processing Systems" renders as "NeurIPS", for example. Add entries to that
list to cover venues it does not yet handle. Page ranges, volume/issue
numbers, and `doi:`/`Available:` tails are dropped from aside entries.

When exporting to PDF, asides are laid out in-line so that references are
not clipped off the bottom of the page.

