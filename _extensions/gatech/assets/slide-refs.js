/**
 * slide-refs.js
 *
 * FEATURE: Per-Slide Citation References
 *
 * PURPOSE:
 * This script automatically displays full bibliographic references at the bottom
 * of each slide where citations appear. This allows the audience to immediately
 * see what paper/source is being referenced without waiting for the final
 * references slide.
 *
 * HOW IT WORKS:
 * 1. Waits for RevealJS to fully load the presentation
 * 2. Collects all references from the References slide into a lookup table
 * 3. Scans each content slide for citations
 * 4. For each slide with citations, appends the corresponding full references
 *    to the bottom of that specific slide
 *
 * TECHNICAL DETAILS:
 * - Runs after RevealJS 'ready' event to ensure DOM is fully constructed
 * - Uses cloneNode() to duplicate references without removing them from the
 *   References slide (they still appear at the end)
 * - Handles RevealJS's nested section structure (sections contain slides)
 * - Styled via custom.scss with .slide-references class
 *
 * USAGE:
 * Just use standard Quarto citations in your slides:
 *   [See @citation-key for details]  →  "See [1] for details"
 *   [@citation-key]                  →  "[1]"
 *
 * The full reference will automatically appear at the slide bottom.
 *
 * CUSTOMIZATION:
 * - To change positioning/styling: edit custom.scss .slide-references
 * - To change which slides get references: modify the querySelector on line 53
 * - To change reference format: edit the CSL file in your project
 */

Reveal.on('ready', function() {
  // STEP 1: Collect all references from the References slide
  // -------------------------------------------------------
  // Find the #refs div which contains all bibliography entries.
  // Quarto/Pandoc generates this automatically at the end of the document.
  const refsSection = document.querySelector('#refs');

  // If there's no references section, nothing to do
  if (!refsSection) return;

  // Create a lookup table (object) to store all references by their ID.
  // Key: reference ID (e.g., "ref-smith2020")
  // Value: cloned DOM node of the full reference entry
  const allRefs = {};

  // Each reference has class .csl-entry and an id like "ref-citationkey"
  refsSection.querySelectorAll('.csl-entry').forEach(ref => {
    // Clone the node deeply (true) to copy all child elements and text
    // This allows us to reuse the reference without removing it from
    // the original References slide
    allRefs[ref.id] = ref.cloneNode(true);
  });

  // STEP 2: Process each individual slide
  // -------------------------------------
  // RevealJS structure: Level 1 headers create parent sections,
  // Level 2 headers create slides within those sections.
  // We only want to process the actual content slides (level2),
  // not the parent section containers.
  document.querySelectorAll('.reveal .slides section.level2').forEach(slide => {

    // IMPORTANT: Skip parent sections that contain nested slides
    // If this section contains other sections, it's a container, not a content slide
    if (slide.querySelector('section')) return;

    // STEP 3: Find citations that belong directly to THIS slide
    // ---------------------------------------------------------
    // We need to be careful here because of nested sections.
    // A citation in a nested slide shouldn't be attributed to the parent section.
    const citations = [];

    // Find all citation spans in this slide
    // Citations are rendered as <span class="citation" data-cites="citationkey">
    slide.querySelectorAll('.citation[data-cites]').forEach(cite => {
      // Check if this citation's immediate parent section is THIS slide
      // (not a nested section or parent section)
      let parent = cite.closest('section');

      // Only include citations that directly belong to this slide
      if (parent === slide) {
        citations.push(cite);
      }
    });

    // If this slide has no citations, skip it
    if (citations.length === 0) return;

    // STEP 4: Extract citation keys and find corresponding references
    // ---------------------------------------------------------------
    // Use a Set to automatically handle duplicates
    // (if someone cites the same paper twice on one slide)
    const citedRefs = new Set();

    citations.forEach(cite => {
      // data-cites can contain multiple space-separated citation keys
      // Example: data-cites="smith2020 jones2021"
      const cites = cite.getAttribute('data-cites').split(' ');

      cites.forEach(citeKey => {
        // Convert citation key to reference ID format
        // Citation key: "smith2020" → Reference ID: "ref-smith2020"
        const refId = 'ref-' + citeKey;

        // If we found this reference in our lookup table, add it
        if (allRefs[refId]) {
          citedRefs.add(refId);
        }
      });
    });

    // STEP 5: Create and append the references div to this slide
    // ----------------------------------------------------------
    if (citedRefs.size > 0) {
      // Create a container div for this slide's references
      const slideRefs = document.createElement('div');

      // This class is styled in custom.scss to position at bottom of slide
      slideRefs.className = 'slide-references';

      // Append each cited reference to the container
      citedRefs.forEach(refId => {
        // Clone again because we might reuse the same reference on multiple slides
        slideRefs.appendChild(allRefs[refId].cloneNode(true));
      });

      // PLACEMENT STRATEGY: Place citations below footnotes if they exist
      // Footnotes are rendered in Quarto as <aside> elements with .aside-footnotes
      // Also check for .footnotes class for other cases
      const footnotesAside = slide.querySelector('aside');

      if (footnotesAside) {
        // Insert citations after the footnotes aside element
        footnotesAside.parentNode.insertBefore(slideRefs, footnotesAside.nextSibling);
      } else {
        // No footnotes: add the references container to the end of the slide
        slide.appendChild(slideRefs);
      }
    }
  });
});
