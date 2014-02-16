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
templates_dir=$(make_dir)/epub
outputdir=$(make_dir)/output
utilsdir=$(make_dir)/epub
img_dir=$(make_dir)/../3-images
pages_dir=$(make_dir)/../2-markdown_chapitres

pandoc_config= \
	$(pandoc_metadata) \
	-V geometry:hmargin=3cm \
	-V geometry:vmargin=3.5cm \
	--listings \
	--no-highlight

%.check:
	@echo -n "Recherche de l'utilitaire pandoc... "
ifdef PANDOC
	@which pandoc
else
	@echo "NOT FOUND"
	@exit 1
endif
	@echo -n "Recherche de l'utilitaire unzip... "
ifdef UNZIP
	@which unzip
else
	@echo "NOT FOUND"
	@exit 1
endif
	@echo "Préparation du répertoire de sortie..."
	@mkdir -p $(outputdir)
	@rm -rf $(outputdir)/*
	@$(eval pandoc_metadata=$(shell /usr/bin/awk -f $(utilsdir)/metadata.awk metadata.txt) )

%-partie-1.epub:
	@echo "Génération de l'epub de la partie 1... "
	@$(pandoc_bin) \
		$(pandoc_config) \
		-t epub \
		--toc --toc-depth=2 \
		--template=$(templates_dir)/template.epub \
		--epub-stylesheet=$(templates_dir)/epub.stylesheet.css \
		--epub-metadata=$(make_dir)/epub.metadata.fr.xml \
		--epub-chapter-level=2 \
		--epub-cover-image=$(img_dir)/cover.jpg \
		-o $(outputdir)/$(@) \
		./metadata.md \
		$(pages_dir)/part-1/*.md
	@echo "Extraction de l'epub partie 1..."
	@$(unzip_bin) -qq \
		-d $(outputdir)/$(patsubst %.epub,%,$(@)) \
		$(outputdir)/$(@) \
		ch*.xhtml images*

%-partie-2.epub:
	@echo "Génération de l'epub de la partie 2... "
	@$(pandoc_bin) \
		$(pandoc_config) \
		-t epub \
		--toc --toc-depth=2 \
		--template=$(templates_dir)/template.epub \
		--epub-stylesheet=$(templates_dir)/epub.stylesheet.css \
		--epub-metadata=$(make_dir)/epub.metadata.fr.xml \
		--epub-chapter-level=2 \
		--epub-cover-image=$(img_dir)/cover.jpg \
		-o $(outputdir)/$(@) \
		./metadata.md \
		$(pages_dir)/part-2/*.md
	@echo "Extraction de l'epub partie 2..."
	@$(unzip_bin) -qq \
		-d $(outputdir)/$(patsubst %.epub,%,$(@)) \
		$(outputdir)/$(@) \
		ch*.xhtml images*

%.all: | %-partie-1.epub %-partie-2.epub
	@true

%: | %.check %.all
	@true
