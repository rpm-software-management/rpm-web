# Reference Manual page preprocessing
# - Converts man page references to links

module Manual
  class Generator < Jekyll::Generator
    def generate(site)
      manuals = site.pages.select { |p| p.dir.end_with?("/manual/") }
      prodata = site.data['projects'].select{ |p| p['name'] == "rpm" }[0]
      manuals.each do |page|
        baseurl = "https://rpm.org/docs/latest/man"
        pattern = prodata['manual']['pattern']
        page.content = page.content.gsub(
          /#{pattern}/, '[\1(\2)]('"#{baseurl}"'/\1.\2)')
      end
    end
  end
end
