# preprint — two-column scientific manuscript template

A self-contained, platform- and author-neutral LaTeX template for scientific
preprints. Two-column PNAS/bioRxiv-style layout with a switchable one-column
**submission** version, a dual-logo title-page header, card-suit author-role
marks, monospace author emails, and a rich **math / theorem / table / box
toolkit** aligned with Springer/Nature conventions.

Engine: **pdfLaTeX + bibtex**, standard TeX Live only — no system fonts, no
XeLaTeX, no exotic packages.

## Files

```
template/
├── main.tex          # entry: layout, front matter, \input assembly
├── preprint.cls      # the document class (layout + toolkit)
├── preprint.bst      # bibliography style (abbrvnat-derived, numeric)
├── refs.bib          # bibliography database
├── Makefile          # make / quick / watch / clean / ...
├── assets/           # logo_left, logo_right (header), footer_logo, placeholder
└── sections/         # body: introduction / results / toolkit / discussion
                      #   / methods / supplementary[/_videos]
```

## Quick start

```latex
\documentclass[twocolumn]{preprint}   % preprint (default)
%\documentclass[submit]{preprint}     % submission: one column + line numbers
```

Build with `make` (or `latexmk -pdf main.tex`). Write the body in `sections/`;
reorder/add/drop chapters by editing the `\input` list in `main.tex`.

## Front matter

```latex
\title{...}\shorttitle{...}\leadauthor{...}
\author[1,\cofirst]{First Author}     % affiliations are numbered
\author[2]{Second Author}
\author[1,\corr]{Senior Author}
\affil[1]{First Institution, City, Country}
\emails{\{first,senior\}@inst-a.edu, second@inst-b.edu}  % shown above affils
```

Author-role marks (card suits): `\cofirst` ♦ co-first/equal · `\colead` ♠
co-lead · `\corr` ♣ corresponding. Blocks: `abstract`, `keywords`, `corrauthor`.

Prefer conventional footnote-symbol marks (`*` / `‡` / `†`) over card suits?
Pass the class option: `\documentclass[twocolumn,plainmarks]{preprint}`.

## Toolkit (built into `preprint.cls`, opt-in, no effect on default layout)

- **Theorems** (amsthm, Springer-style): `theorem` / `proposition` / `lemma` /
  `corollary` (shared counter), `definition` / `assumption`, `remark` /
  `example`, plus `proof` (QED).
- **Math**: operators `\argmax \argmin \Var \Cov \diag \tr \sign \softmax`;
  delimiters `\abs \norm \set \inner \ceil \floor`; sets `\R \N \Z \E`;
  notation `\vect \mat \trans`.
- **Emphasis**: `\good \bad \maybe \miss \hilite \best \secondbest`; marks
  `\cmark \xmark`.
- **Tables**: `booktabs` + `\mc` / `\mcb` (cell + sub-note) + `\na` + `Y` column.
- **Boxes**: `highlight`, `keypoint` (tcolorbox).
- **Algorithms**: `algorithm` + `algpseudocode` (pseudocode floats).
- **More tables/math**: `multirow`, `threeparttable` (table notes), `\mathscr`.
- **Units**: `siunitx` with custom `\Molar`, `\Units`, `\rpm`, …

See `sections/toolkit.tex` for a live demo (delete it in a real paper).

## Logos (replaceable, layout unchanged)

- `assets/logo_left.png`, `assets/logo_right.png` — title-page header
  (left / right); heights set in `preprint.cls`, `plain` page style.
- `assets/footer_logo.png` — small mark in the running footer.

Swap the PNGs in `assets/` to rebrand without touching the layout.

## Build targets

```
make          # full build (latexmk; falls back to pdflatex+bibtex)
make quick    # single pdflatex pass
make watch    # continuous rebuild + preview
make view     # open the PDF
make clean    # remove aux files (keep PDF)
make distclean# remove aux files and PDF
```
