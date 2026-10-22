# Run after jekyll build. SITE_DEST may point to a temporary build directory.
require "nokogiri"
require "bibtex"
require "yaml"
require "pathname"
root = Pathname.new(ENV.fetch("SITE_DEST", "_site"))
def check(condition, message)
  abort message unless condition
end
routes = %w[index.html research/index.html publications/index.html lecture/index.html graduationthesis/index.html news/index.html repositories/index.html projects/1_attentive_listening_responses/index.html projects/2_caption/index.html]
routes.each { |route| check(root.join(route).file?, "Missing route: #{route}") }
doc = Nokogiri::HTML(root.join("publications/index.html").read)
bib = BibTeX.open("_bibliography/papers.bib")
entries = bib.entries.values
check(doc.css(".bibliography > li").size == entries.size, "Publication count changed")
check(doc.css("#bibsearch").size == 1, "Bibliography search missing or duplicated")
entries.each do |entry|
  node = doc.at_css("[id='#{entry.key}']")
  check(node, "Missing publication #{entry.key}")
  # Compare all displayed authors independently with the BibTeX data, including order.
  expected = entry.author.to_a.first(10).map do |name|
    entry[:language].to_s == "ja" ? "#{name.last} #{name.first}" : "#{name.first} #{name.last}"
  end.join(", ")
  actual = node.at_css(".author").text.gsub(/\s+/, " ").strip
  check(actual == expected, "Author mismatch #{entry.key}: #{actual.inspect} != #{expected.inspect}")
  %i[volume number pages].each do |field|
    next unless entry[field]
    check(node.css(".periodical").text.include?(entry[field].to_s.gsub("--", "–")), "Missing #{field} for #{entry.key}")
  end
end
check(Dir.glob("_posts/*").empty?, "Sample posts reintroduced")
check(Dir.glob("_projects/*").size == 2, "Unexpected project content")
check(!root.join("blog/index.html").exist?, "Sample blog output reintroduced")
check(!doc.text.include?("Albert Einstein"), "Sample bibliography reintroduced")
# Verify local links and asset URLs throughout the site's HTML.
missing = []
root.glob("**/*.html").each do |file|
  page = Nokogiri::HTML(file.read)
  page.css("[href], [src]").each do |element|
    value = element["href"] || element["src"]
    next if value.nil? || value.empty? || value.start_with?("#", "//") || value.match?(/^[a-z][a-z0-9+.-]*:/i)
    path = value.split(/[?#]/, 2).first
    next if path.nil? || path.empty?
    target = path.start_with?("/") ? root.join(path.delete_prefix("/")) : file.dirname.join(path)
    next if target.exist? || target.join("index.html").file?
    missing << "#{file.relative_path_from(root)}: #{value}"
  end
end
check(missing.empty?, "Broken internal links:\n#{missing.uniq.join("\n")}")
puts "PASS: #{routes.size} core routes, #{entries.size} publications and author lists, bibliography search, sample removal, internal links."
