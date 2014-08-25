SHELL := /bin/bash
VERSION=0.5

PANDOC := $(shell pandoc --version 2>/dev/null)
UNZIP :=$(shell unzip -v 2>/dev/null)
pandoc_bin=/usr/bin/pandoc
unzip_bin=/usr/bin/unzip

fontsize=12pt
lang=french
geometry=portrait
paper=a4paper
hmargin=3cm
vmargin=3.5cm

# Common options for pandoc's calls
make_dir=$(shell pwd)
templates_dir=$(make_dir)/templates.epub
outputdir=$(make_dir)/../output
epubdir=$(make_dir)/../epub
utilsdir=$(make_dir)/templates.epub
img_dir=$(make_dir)/../images
pages_dir=$(make_dir)/../bookmd

pandoc_config= \
	$(pandoc_metadata) \
	-V geometry:hmargin=3cm \
	-V geometry:vmargin=3.5cm \
	--listings \
	--no-highlight

%.check:
	@echo -n "Searching pandoc... "
ifdef PANDOC
	@which pandoc
else
	@echo "NOT FOUND"
	@exit 1
endif
	@echo -n "Searching unzip... "
ifdef UNZIP
	@which unzip
else
	@echo "NOT FOUND"
	@exit 1
endif
	@echo "Preparing build environment..."
	@mkdir -p $(outputdir)
	@mkdir -p $(epubdir)
	@rm -rf $(outputdir)/*
	@rm -rf $(epubdir)/*

%-partie-1.epub:
	@echo "Generating part 1 epub... "
	@$(pandoc_bin) \
		$(pandoc_config) \
		-t epub \
		--toc --toc-depth=2 \
		--template=$(templates_dir)/template.epub \
		--epub-stylesheet=$(templates_dir)/epub.stylesheet.css \
		--epub-chapter-level=2 \
		--epub-cover-image=$(img_dir)/cover.jpg \
		-o $(outputdir)/$(@) \
		$(pages_dir)/part-1/metadata.md \
		$(pages_dir)/part-1/chapter-*.md
	@echo "Extracting part 1 epub..."
	@mkdir -p $(epubdir)/$(patsubst %.epub,%,$(@))
	@$(unzip_bin) -qq \
		-d $(epubdir)/$(patsubst %.epub,%,$(@)) \
		$(outputdir)/$(@)
	@echo "Applying custom theme epub..."
	@./bookscanner_customize_ebook.sh $(epubdir)/$(patsubst %.epub,%,$(@))
	@echo "Rebuilding epub..."
	@./bookscanner_regenerate_epub.sh $(epubdir)/$(patsubst %.epub,%,$(@)) $(outputdir)/$(@)
	@echo "Generating part 1 epub3... "
	@$(pandoc_bin) \
		$(pandoc_config) \
		-t epub3 \
		--toc --toc-depth=2 \
		--template=$(templates_dir)/template.epub3 \
		--epub-stylesheet=$(templates_dir)/epub.stylesheet.css \
		--epub-chapter-level=2 \
		--epub-cover-image=$(img_dir)/cover.jpg \
		-o $(outputdir)/$(patsubst %.epub,%,$(@)).3.epub \
		$(pages_dir)/part-1/metadata.md \
		$(pages_dir)/part-1/chapter-*.md
	@echo "Extracting part 1 epub3..."
	@mkdir -p $(epubdir)/$(patsubst %.epub,%,$(@)).3
	@$(unzip_bin) -qq \
		-d $(epubdir)/$(patsubst %.epub,%,$(@)).3 \
		$(outputdir)/$(patsubst %.epub,%,$(@)).3.epub
	@echo "Applying custom theme epub3..."
	@./bookscanner_customize_ebook.sh $(epubdir)/$(patsubst %.epub,%,$(@)).3
	@echo "Rebuilding epub3..."
	@./bookscanner_regenerate_epub.sh $(epubdir)/$(patsubst %.epub,%,$(@)).3 $(outputdir)/$(patsubst %.epub,%,$(@)).3.epub


%-partie-2.epub:
	@echo "Generating part 2 epub... "
	@$(pandoc_bin) \
		$(pandoc_config) \
		-t epub \
		--toc --toc-depth=2 \
		--template=$(templates_dir)/template.epub \
		--epub-stylesheet=$(templates_dir)/epub.stylesheet.css \
		--epub-chapter-level=2 \
		--epub-cover-image=$(img_dir)/cover.jpg \
		-o $(outputdir)/$(@) \
		$(pages_dir)/part-2/metadata.md \
		$(pages_dir)/part-2/chapter-*.md
	@$(pandoc_bin) \
		$(pandoc_config) \
		-t epub3 \
		--toc --toc-depth=2 \
		--template=$(templates_dir)/template.epub3 \
		--epub-stylesheet=$(templates_dir)/epub.stylesheet.css \
		--epub-chapter-level=2 \
		--epub-cover-image=$(img_dir)/cover.jpg \
		-o $(outputdir)/$(patsubst %.epub,%,$(@)).3.epub \
		$(pages_dir)/part-2/metadata.md \
		$(pages_dir)/part-2/chapter-*.md
	@echo "Extracting part 2 epub..."
	@mkdir -p $(epubdir)/$(patsubst %.epub,%,$(@))
	@$(unzip_bin) -qq \
		-d $(epubdir)/$(patsubst %.epub,%,$(@)) \
		$(outputdir)/$(@)
	@mkdir -p $(epubdir)/$(patsubst %.epub,%,$(@)).3
	@$(unzip_bin) -qq \
		-d $(epubdir)/$(patsubst %.epub,%,$(@)).3 \
		$(outputdir)/$(patsubst %.epub,%,$(@)).3.epub
	@echo "Applying custom theme..."
	@./bookscanner_customize_ebook.sh $(epubdir)/$(patsubst %.epub,%,$(@))
	@./bookscanner_customize_ebook.sh $(epubdir)/$(patsubst %.epub,%,$(@)).3
	@echo "Rebuilding epub..."
	@./bookscanner_regenerate_epub.sh $(epubdir)/$(patsubst %.epub,%,$(@)) $(outputdir)/$(@)
	@./bookscanner_regenerate_epub.sh $(epubdir)/$(patsubst %.epub,%,$(@)).3 $(outputdir)/$(patsubst %.epub,%,$(@)).3.epub

%.all: | %-partie-1.epub %-partie-2.epub
	@true

%: | %.check %.all
	@true
