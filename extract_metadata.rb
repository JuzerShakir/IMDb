module IMDb
    module ExtractMetadata
        # * 1 title
        def title
            unless @session_closed
                attrb = set_attr("hero-title-block__title")
                extract_data(:h1, attrb, :text)
            end
        end

        # * 2 rating
        def ratings
            unless @session_closed
                attrb = set_attr("hero-rating-bar__aggregate-rating__score")
                html = extract_data(:div, attrb, :span, :html)
                html.scan(/\d[.]{1}\d/).pop.to_f
            end
        end

        # * 3 type of content: Movie or TV
        def type
            (content_type == "TV" ? "TV Show" : "Movie") unless @session_closed
        end

        # * 4 director name
        def director
            unless @session_closed
                attrb = set_attr("title-pc-principal-credit")
                html = extract_data(:li, attrb, :html)
                html.scan(/([a-z ]+)<\/a>/i).flatten.pop
            end
        end

        # * 5 runtime in minutes
        def runtime
            if !@session_closed && @browser.span(text: "Runtime").present?
                attrb = set_attr("title-techspec_runtime")
                html = extract_data(:li, attrb, :text)
                h, m = html.scan(/\d+/).map(&:to_i)
                m.nil? ? h*60 : (h*60) + m
            end
        end

        # * 6 release_date
        def release_date
            if !@session_closed && @browser.link(text: "Release date").present?
                attrb = set_attr("title-details-releasedate")
                Date.parse(extract_data(:li, attrb, :text, :lines, :last))
            end
        end

        # * 7 budget
        def budget
            if !@session_closed && @browser.span(text: "Budget").present?
                attrb = set_attr("title-boxoffice-budget")
                extract_data(:li, attrb, :li, :text, :split, :first)
            end
        end

        # * 8 revenue
        def revenue
            if !@session_closed && @browser.span(text: "Gross worldwide").present?
                attrb = set_attr("title-boxoffice-cumulativeworldwidegross")
                extract_data(:li, attrb, :li, :text, :split, :first)
            end
        end

        # * 9 genres
        def genres
            unless @session_closed
                attrb = set_attr("genres")
                html = extract_data(:div, attrb, :text)
                html.gsub("\n", ' ').split
            end
        end

        # * 10 tagline
        def tagline
            unless @session_closed
                attrb = set_attr("plot-xl")
                # @browser.window.maximize
                html = extract_data(:span, attrb, :html)
                html.scan(/>([a-z ,.]+)</i).flatten.pop
            end
        end

        # * 11 storyline
        def story
            unless @session_closed
                attrb = set_attr("storyline-plot-summary")
                extract_data(:div, attrb, :text)
            end
        end

        # * 12 total users rated
        def popularity
            unless @session_closed
                attrb = { css: ".sc-7ab21ed2-3.dPVcnq" }
                html = extract_data(:div, attrb, :html)
                html.scan(/>([0-9.M|K]+)/).flatten.pop
            end
        end

        # * 13 casts
        def casts
            unless @session_closed
                attrb = set_attr("title-cast-item__actor")
                html = extract_data(:as, attrb, :map)
                html.each(&:text)
            end
        end

        # * 14 production companies
        def produced_by
            unless @session_closed
                attrb = set_attr("title-details-companies")
                html = extract_data(:li, attrb, :div, :ul)
                html.map(&:text)
            end
        end
    end
end
