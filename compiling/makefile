path_to_manuscript = /manuscript/
manuscript_file = $(path_to_manuscript)manuscript
latex_template = pandoc-template.latex
latex-intermediate = latex-intermediate.tex

manuscript:
	make pandoc-intermediate
	make latex-pdf

pandoc-intermediate:
	cd /manuscript; \
		pandoc \
		--bibliography=bibliography.bib \
		--standalone \
		--template=/manuscribble/$(latex_template) \
		--output=$(path_to_manuscript)pandoc-intermediate.tex \
		--from markdown_github+yaml_metadata_block+fenced_code_blocks+backtick_code_blocks+fenced_code_attributes \
		--to latex \
		$(manuscript_file).md

latex-pdf:
	cd /manuscript && \
		pandoc \
			manuscript.tex \
			--to latex \
			--standalone \
			--output manuscript2.tex
