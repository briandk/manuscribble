path_to_manuscript = /manuscript/
manuscript_file = manuscript
latex_template = pandoc-template.latex
manuscript:
	make pandoc-intermediate
	# make latex-pdf
	# make clean

pandoc-intermediate:
	pandoc \
		--from markdown+autolink_bare_uris+ascii_identifiers+tex_math_single_backslash+implicit_figures+pipe_tables+raw_html+fenced_code_blocks+auto_identifiers+ascii_identifiers+backtick_code_blocks+autolink_bare_uris+yaml_metadata_block \
		--to latex \
		--natbib \
		$(path_to_manuscript)$(manuscript_file).md \
		--standalone \
		--template=$(latex_template) \
		--output=$(path_to_manuscript)pandoc-intermediate.tex
		# --from markdown+autolink_bare_uris+ascii_identifiers+tex_math_single_backslash+implicit_figures+pipe_tables+raw_html+fenced_code_blocks+auto_identifiers+ascii_identifiers+backtick_code_blocks+autolink_bare_uris+yaml_metadata_block \
		# --standalone \
		# --template=$(latex_template) \
		# --natbib \
		# $(path_to_manuscript)$(manuscript_file).md \
		# --output=$(path_to_manuscript)pandoc-intermediate.tex


latex-pdf:
	pdflatex $(path_to_manuscript)$(manuscript_file)
	bibtex $(path_to_manuscript)$(manuscript_file)
	pdflatex $(path_to_manuscript)$(manuscript_file)
	pdflatex $(path_to_manuscript)$(manuscript_file)


clean:
	echo "CLEANING!"
	cd /manuscript; rm \
		*.aux \
		*.bbl \
		*.blg \
		*.log \
		pandoc-intermediate.tex
