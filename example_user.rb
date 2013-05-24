# ----------------------------------------------------------------------
#
# Example User
#
# Code for the user in this app.
#
# Created by: Ross Bamford
# File first created: 2013 05 22 at 11:51:59
# Edit date: 
#
# ----------------------------------------------------------------------

# ----------------------------------------------------------------------
# 
# CHANGE LOG
#
# Number:
# Date:
# Changes: 
# 
# ----------------------------------------------------------------------

class User
    attr_accessor :name, :email
    
    def initialize(attributes = {})
        @name = attributes[:name]
        @email = attributes[:email]
    end
    
    def formatted_email
        "#{@name} <#{@email}>"
    end
end