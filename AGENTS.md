# Personal site maintenance

This repository is Masaki Murata’s personal GitHub Pages site, based on al-folio v1.
Read README.md before changing the site. Preserve real content, URLs, and Japanese
bibliography formatting. Do not reintroduce upstream sample content.

Runtime comes from pinned gems in Gemfile. Local overrides are permitted here.
Keep Gemfile and the plugins list in _config.yml in sync. Audit intentional
overrides with `bundle exec al-folio upgrade overrides audit` after gem updates.
This is a user site: upstream starter-only lint rules prohibiting overrides do
not apply. The baseurl is empty because this is a user GitHub Pages site.

Validate with `bundle exec jekyll build`, `bundle exec ruby test/site_test.rb`,
`bundle exec al-folio upgrade audit`, and the override audit.
The publication branch is main; never deploy a feature branch.
