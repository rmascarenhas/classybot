module ClassyBot

  require 'nokogiri'
  require 'open-uri'

  # Class responsible for downloading a joke page and
  # populating the database.
  class UrlFetcher 

    def self.fetch(url, &block)
      @url          = url
      @params       = {}
      @content      = []
      @repeat       = 1
      @docs         = []
      instance_eval &block

      execute!
    end

    # Specifies we are searching via a XPath expression.
    def self.xpath(selector)
      @selector = selector
      @method   = :xpath
    end

    # Tell us how many times we have to fetch the url (for random content url's)
    def self.repeat(times)
      @repeat = times
    end

    # Specifies we are searching using a CSS selector.
    def self.css(selector)
      @selector = selector
      @method   = :css
    end

    # Sets the table we will save when we are done fetching
    def self.section(table)
      @table = table
    end

    # Allows the usage of a parameter in the given URL.
    def self.param(name, options)
      @params[name.to_sym] = options[:value] || options[:range]
    end

  private

    # Effectively executes the fetching and insertion in the database.
    def self.execute!
      @repeat.times do
        @params.each { |key, value|
          case value
            when Range  then iterate_over(key)
            when String then download(url + "?#{key}=#{value}")
          end
        }

        download(@url) if @params.empty?
      end

      extract_content
      prepare_data

      MemorySystem.memorize(@table, @data)
    end

    # Downloads all the documents in case we have a range type parameter
    def self.iterate_over(key)
      @params[key].each { |n|
        download(@url + "?#{key}=#{n}")
      }
    end

    # Fetches the HTML page and pass it to Nokogiri
    def self.download(url)
      @docs << Nokogiri::HTML(open(url))
    end

    # Effectively parses the HTML via the XPath or CSS selector and extracting the text
    def self.extract_content
      @docs.each { |doc|
        @content += doc.send(@method, @selector).map { |element| element.text }
      }

      # a little sanitizing
      @content.delete_if { |c| c.empty? || c.start_with?("\n", '#') || c.length > 140 }
      @content.each { |c| c.gsub!(/\n|\t/, ' ') }
      @content.uniq!
    end

    def self.prepare_data
      @data = []
      @content.each { |c| @data << { text: c } }
    end

  end

end
