path_to_manuscript = /manuscript/
manuscript_file = manuscript
latex_template = pandoc-template.latex
manuscript:
	make pandoc-intermediate
	# make latex-pdf
	# make clean

pandoc-intermediate:
	cd /manuscript && pandoc \
		--from markdown_github+citations \
		--bibliography=bibliography.bib \
		--standalone \
		--template=/manuscribble/$(latex_template) \
		--output=pandoc-intermediate.tex \
		--from markdown_github+autolink_bare_uris+ascii_identifiers+tex_math_single_backslash+implicit_figures+pipe_tables+raw_html+backtick_code_blocks+auto_identifiers+ascii_identifiers+backtick_code_blocks+autolink_bare_uris+yaml_metadata_block+fenced_code_attributes+citations \
		$(manuscript_file).md

latex-pdf:
	ls /manuscript
	cd $(path_to_manuscript) && \
		pdflatex manuscript && \
		bibtex manuscript && \
		pdflatex manuscript && \
		pdflatex manuscript

clean:
	echo "CLEANING!"
	cd /manuscript; rm \
		*.aux \
		*.bbl \
		*.blg \
		*.log \
		pandoc-intermediate.tex
