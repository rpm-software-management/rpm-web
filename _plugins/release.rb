# Release page preprocessing
# - Generates additional variables for use in templates
# - Merges latest snapshots into drafts
# - Offsets Markdown headings to configured level

module Release
  class Generator < Jekyll::Generator
    def generate(site)
      releases = site.collections['releases'].docs.sort{
        |a, b| a.data['version'] <=> b.data['version'] }
      parent = nil

      releases.each do |page|
        data = page.data
        project = data['project']
        version = data['version']
        draft = data['draft']
        snapshot = data['snapshot']
        slug = data['slug']
        prodata = site.data['projects'].select{ |p| p['name'] == project }[0]

        # Construct title
        title = "#{prodata['title']} #{version}"
        if snapshot then
          title += " #{snapshot.upcase}"
        end

        # Construct series
        series = version.gsub(/#{prodata['series_re']}/, '\1.x')

        # Determine if supported
        supported = prodata['stable'].include? series

        # Construct tarball URL
        tarball = prodata['tarball']
        baseurl = tarball['baseurl']
        if snapshot then
          dir = 'testing'
        else
          dir = "#{project}-#{series}"
        end
        name = "#{project}-#{slug}"
        ext = tarball['fileext']
        if draft then
          tarball = nil
        elsif data['tarball'] then
          tarball = data['tarball']
        else
          tarball = "#{baseurl}/#{dir}/#{name}.#{ext}"
        end

        # Add new variables to page
        data['title'] = title
        data['series'] = series
        data['supported'] = supported
        data['tarball'] = tarball

        # Merge parent snapshot if draft
        if draft then
          if parent.data['version'] == version then
            ['title', 'tarball', 'checksum'].each do|i|
              data[i] = parent.data[i]
            end
          end
        end

        # Offset headings
        offset = '#' + ('#' * data['heading_offset'])
        page.content = page.content.gsub(
          /^#{offset}/, '#' * site.config['heading_level'])

        parent = page
      end
    end
  end
end
