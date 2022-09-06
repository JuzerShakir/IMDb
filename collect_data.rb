require "watir"
require "webdrivers"
require "csv"
require_relative "extract_metadata.rb"

# sets default timeout from 30sec to 3sec
Watir.default_timeout = 3

module IMDb
    class CollectData
        include ExtractMetadata
        attr_reader :url, :errors

        def initialize url
            @url = url
            @errors = error_message ? true : false
        end

        def error_message
            if valid_url?
                connect_n_fetch
                return "Content Type is not supported" if !content_type_supported?
                return "Ratings doesn't exist" if !ratings_exists?
            else
                return "Invalid URL"
            end
        end

        private

            def connect_n_fetch
                @browser = Watir::Browser.new :chrome, headless: true
                @browser.goto @url
            end

            # * create hash for HTML attribute and its value
            def set_attr(value, attribute = "data-testid")
                {"#{attribute}".to_sym => value }
            end

            def extract_data(tag, attrb, *methods)
                unless @errors
                    html = @browser.send(tag, attrb)
                    methods.inject(html) { |o, a| o.send(*a) }
                end
            end

            # * returns true if rating exists
            def ratings_exists?
                attrb = set_attr("hero-rating-bar__aggregate-rating")
                extract_data(:div, attrb, :exists?)
            end

            # * know the content type of the imdb page : movie, tv-series, episode or game and only support movie and tvseries types
            def content_type
                attrb = set_attr("hero-title-block__metadata")
                extract_data(:ul, attrb, :text, :split, :first)
            end

            def content_type_supported?
                content_type.match?(/\A(\d+|TV)/)
            end

            # * check link validation & Valid URL input?
            def valid_url?
                valid_url = /(\Ahttps:\/\/www.imdb.com\/title\/tt\d{7}\/)/i
                @url.match?(valid_url)
            end
    end
end