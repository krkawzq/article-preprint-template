# Makefile for the scientific manuscript (main.tex)
# preprint.cls template, pdflatex + bibtex (preprint.bst).

MAIN     := main
TEX      := $(MAIN).tex
PDF      := $(MAIN).pdf
BIB      := refs.bib
CLS      := preprint.cls
BST      := preprint.bst
SECTIONS := $(wildcard sections/*.tex)
# Image assets pulled in by the manuscript (logos, placeholder figures). Listing
# them as prerequisites makes `make pdf` compare timestamps and rebuild when any
# asset under assets/ is newer than the PDF.
ASSETS   := $(wildcard assets/*)

LATEXMK  := latexmk
PDFLATEX := pdflatex
BIBTEX   := bibtex

LATEXMK_FLAGS  := -pdf -interaction=nonstopmode -halt-on-error -file-line-error
PDFLATEX_FLAGS := -interaction=nonstopmode -halt-on-error -file-line-error

# The class (preprint.cls) and bib style (preprint.bst) live in this
# directory, which is already on LaTeX's default search path; no extra
# TEXINPUTS / BSTINPUTS needed.

# Cache / aux extensions produced by pdflatex / bibtex / latexmk.
AUX_EXTS := aux bbl blg log out toc lof lot fdb_latexmk fls synctex.gz \
            idx ilg ind brf

.PHONY: all pdf quick bib clean distclean watch view help

all: pdf

## pdf: full build with bibliography (uses latexmk if available)
pdf: $(PDF)

$(PDF): $(TEX) $(BIB) $(SECTIONS) $(CLS) $(BST) $(ASSETS)
	@if command -v $(LATEXMK) >/dev/null 2>&1; then \
	  echo ">>> latexmk $(LATEXMK_FLAGS) $(MAIN)"; \
	  $(LATEXMK) $(LATEXMK_FLAGS) $(MAIN); \
	else \
	  echo ">>> latexmk not found, falling back to pdflatex + bibtex"; \
	  $(PDFLATEX) $(PDFLATEX_FLAGS) $(MAIN) && \
	  { $(BIBTEX) $(MAIN) || echo ">>> bibtex returned non-zero (likely no citations yet); continuing"; } && \
	  $(PDFLATEX) $(PDFLATEX_FLAGS) $(MAIN) && \
	  $(PDFLATEX) $(PDFLATEX_FLAGS) $(MAIN); \
	fi
	@# Refresh the PDF mtime on success so a touch-only asset change settles:
	@# latexmk skips a recompile when content is unchanged, which would leave
	@# the PDF older than the touched asset and make `make` re-run every time.
	@test -f $(PDF) && touch $(PDF) || true

## quick: single pdflatex pass (no bibliography refresh) for fast iteration
quick:
	$(PDFLATEX) $(PDFLATEX_FLAGS) $(MAIN)

## bib: rerun bibtex against the current .aux
bib:
	$(BIBTEX) $(MAIN)

## watch: continuous rebuild + preview (requires latexmk)
watch:
	$(LATEXMK) $(LATEXMK_FLAGS) -pvc $(MAIN)

## view: open the built PDF
view: $(PDF)
	@if   command -v xdg-open >/dev/null 2>&1; then xdg-open $(PDF); \
	elif  command -v open     >/dev/null 2>&1; then open $(PDF); \
	else  echo "No PDF viewer found (xdg-open / open)"; fi

## clean: remove auxiliary / cache files, keep the PDF
clean:
	@for ext in $(AUX_EXTS); do \
	  rm -f *.$$ext; \
	done
	@if command -v $(LATEXMK) >/dev/null 2>&1; then $(LATEXMK) -c >/dev/null 2>&1 || true; fi
	@echo "cleaned aux files."

## distclean: clean + remove the built PDF
distclean: clean
	rm -f $(PDF)
	@if command -v $(LATEXMK) >/dev/null 2>&1; then $(LATEXMK) -C >/dev/null 2>&1 || true; fi
	@echo "removed $(PDF)."

## help: list available targets
help:
	@echo "Targets:"
	@grep -E '^## ' $(MAKEFILE_LIST) | sed -e 's/^## /  /'
