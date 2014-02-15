VERSION=0.1

pandoc_bin=/usr/bin/pandoc
pdfbook_bin=/usr/bin/pdfbook

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
	@echo "Performing checks"
	$(eval pandoc_metadata=$(shell /usr/bin/awk -f $(utilsdir)/metadata.awk metadata.txt) )
	mkdir -p $(outputdir)
	rm -rf $(outputdir)/*

%-partie-1.epub:
	@echo "Génération de l'epub de la partie 1... "
	$(shell $(pandoc_bin) \
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
		$(pages_dir)/2-part-1*.md )

%-partie-2.epub:
	@echo "Génération de l'epub de la partie 2... "
	$(shell $(pandoc_bin) \
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
		$(pages_dir)/2-part-2*.md )

%.all: | %-partie-1.epub %-partie-2.epub
	@true

%: | %.check %.all
	@true
