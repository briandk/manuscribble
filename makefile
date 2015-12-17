my_manuscript = JLS_Rebecca_Manuscript
render_script = /vagrant/render_manuscript.R
run_in_r = sudo R --vanilla -f

using-vagrant:
	vagrant ssh -c  "$(run_in_r) $(render_script) --args  /vagrant/Drafts/$(my_manuscript).Rmd" && \
  open Drafts/$(my_manuscript).pdf

locally:
	R --vanilla -f render_manuscript.R --args Drafts/$(my_manuscript).Rmd && \
	open Drafts/$(my_manuscript).pdf

using-docker:
	docker run -v /vagrant:/vagrant t R --vanilla -f $(render_script) --args manuscript.Rmd
