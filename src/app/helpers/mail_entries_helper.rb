# Project name: ACCR Mail Manager
# Description: Mail database and management system for ACCR community partner
# Filename: mail_entries_helper.rb
# Description: Includes shared utility methods for mail entries
# Last modified on: 4/13/22
# Code written by Team 13

module MailEntriesHelper

    # formats the case status from an integer into its converted description
    def format_case_status(status_int) 

        # this array should match the one in mail_entries.rb.
        case_status_description_mapping = ["Not Started", "In Progress", "Complete"] # case status description = case status index into array
        if status_int < 0 || status_int >= case_status_description_mapping.length
            # unrecognized status, handle accordingly (should be rare in most cases)
            return "Unknown"
        else 
            # index into array to get description
            return case_status_description_mapping[status_int]
        end
    end

    # returns the list of options for race (to be used elsewhere)
    def race_options(placeholder_option = nil)
        if placeholder_option != nil
            return [placeholder_option, "White", "Black or African American", "Asian", "American Indian or Alaska Native", "Native Hawaiian or Other Pacific Islander", "Other"]
        else
            return ["White", "Black or African American", "Asian", "American Indian or Alaska Native", "Native Hawaiian or Other Pacific Islander", "Other"]
        end
    end

    # returns the list of options for case_status (to be used elsewhere)
    def case_status_options(placeholder_option = nil)
        listing = [] # different select options
        if placeholder_option != nil
            placeholder = [placeholder_option, -1] # -1 acts as placeholder: description, value
            listing = [placeholder]
        end
        code = 0
        description = format_case_status(code)
        while description != "Unknown"
            listing.append([description, code])
            code = code + 1
            description = format_case_status(code)
        end
        return listing
    end
end
