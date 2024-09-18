module Jekyll
  class TagPageGenerator < Generator
    safe true

    def generate(site)
      # Print all available layouts for debugging
      puts "Available layouts:"
      site.layouts.each_key do |layout|
        puts "- #{layout}"
      end

      if site.layouts.key? 'tag'
        puts "Generating tag pages..."
        site.tags.each do |tag, posts|
          slugified_tag = slugify(tag)  # Manually slugify the tag
          puts "Generating page for tag: #{slugified_tag}"
          write_tag_page(site, File.join('tags', slugified_tag), tag)
        end
      else
        puts "No 'tag' layout found!"
      end
    end

    def write_tag_page(site, dir, tag)
      index = TagPage.new(site, site.source, dir, tag)
      index.render(site.layouts, site.site_payload)
      index.write(site.dest)
      site.pages << index
    end

    def slugify(tag)
      # This method converts a string into a URL-friendly slug
      tag.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    end
  end

  class TagPage < Page
    def initialize(site, base, dir, tag)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'tag.html')
      self.data['tag'] = tag
      self.data['title'] = "Posts Tagged: #{tag}"
    end
  end
end
