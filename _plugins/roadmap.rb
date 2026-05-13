# Roadmap page preprocessing
# - Converts ticket references to links

module Roadmap
  class Generator < Jekyll::Generator
    def generate(site)
      roadmap = site.pages.find { |page| page.name == "roadmap.md" }
      prodata = site.data['projects'].select{ |p| p['name'] == "rpm" }[0]
      baseurl = prodata['ticket']['baseurl']
      pattern = prodata['ticket']['pattern']
      roadmap.content = roadmap.content.gsub(
        /#{pattern}/, '([#\1]('"#{baseurl}"'/\1))')
    end
  end
end
