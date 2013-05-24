module ApplicationHelper

    # Returns the full title on a per-page basis.
    
    # Firstly, we define the full_title method, taking page_title as an input.
    def full_title(page_title)
    
        # Set the value for base_title. Now we have a string that will be the base string
        # for every page title in the application.
        base_title = "Ruby on Rails Tutorial Sample App"
        
        # Test to see if the page_title passed to the method is empty.
        if page_title.empty?
        
            # If the page_title passed to the method IS empty then we RETURN the base_title
            # defined above.
            base_title
        
        else
        
            # If the page_title passed to this method is NOT empty (ie. it has some string
            # value, then we RETURN an interpolated string which is the base_title defined
            # above followed by " | " followed by the page_title passed to this method.
            "#{base_title} | #{page_title}"

        end

    end

end
