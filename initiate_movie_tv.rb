require "watir"
require "webdrivers"
require "csv"
require_relative "extract_metadata.rb"

# sets default timeout from 30sec to 3sec
Watir.default_timeout = 3

module IMDb
    class InitiateMovieTV
        include ExtractMetadata
        attr_reader :url, :errors, :error_messages, :session_closed

        def initialize url
            @url = url
            @error_messages = []
            @errors = false
            @session_closed = false
            validate_input
            if @error_messages.any?
                @errors = true
                close_connection if @browser
                @session_closed = true
            end
        end

        def close_connection
            @browser.close
            @session_closed = true
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
                html = @browser.send(tag, attrb)
                methods.inject(html) { |o, a| o.send(*a) }
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

            def validate_input
                if valid_url?
                    connect_n_fetch
                    @error_messages << "Content Type is not supported" if !content_type_supported?
                    @error_messages << "Ratings doesn't exist" if !ratings_exists?
                else
                    @error_messages << "Invalid URL"
                end
            end
    end
end