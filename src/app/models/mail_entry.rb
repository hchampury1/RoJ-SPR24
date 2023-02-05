# Project name: ACCR Mail Manager
# Description: Mail database and management system for ACCR community partner
# Filename: mail_entry.rb
# Description: Contains the filtering and sorting functions for mail entry listings
# Last modified on: 4/7/22
# Code written by Team 13

class MailEntry < ApplicationRecord
    has_one_attached :document

    #has_one_attached :document
  
    # self.search_label: A function to return Mail Entries matching the provided label
    # Inputs: search_label, general_search, no_action_placeholder
    #  - search_label: The value that needs to be matched, or the no_action_placeholder (see below)
    #  - general_search (default, false): Whether the function is being used for filtering or a general search.
    #                                     If false, the function is used for filtering, and no_action_placeholders are considered
    #                                     If true, the function is used for searching, placeholders are ignored. This is to prevent
    #                                     a user from providing a general search term of "Any" for example and matching every entry in the database.
    #  - no_action_placeholder (default, ""): The value signifying no filtering should be performed against the specific attribute, and that all entries should be returned
    #                                         This is ignored if general_search is true
    # Outputs: none
    # Returns: List of Mail Entries matching the filter/search
    def self.search_label(search_label, general_search = false, no_action_placeholder = "")
        if search_label
            if general_search == false && search_label == no_action_placeholder # placeholder val provided, no filter should be performed
                return MailEntry.all
            else
                MailEntry.where("lower(label) LIKE ?", "%#{search_label.downcase}%")  # return any label containing their search, even with partial matches or different letter cases
            end
        else # parameter not provided
            MailEntry.all
        end
    end

    # self.search_sender: A function to return Mail Entries matching the provided sender name
    # Inputs: search_sender, general_search, no_action_placeholder
    #  - search_sender: The value that needs to be matched, or the no_action_placeholder (see below)
    #  - general_search (default, false): Whether the function is being used for filtering or a general search.
    #                                     If false, the function is used for filtering, and no_action_placeholders are considered
    #                                     If true, the function is used for searching, placeholders are ignored. This is to prevent
    #                                     a user from providing a general search term of "Any" for example and matching every entry in the database.
    #  - no_action_placeholder (default, ""): The value signifying no filtering should be performed against the specific attribute, and that all entries should be returned
    #                                         This is ignored if general_search is true
    # Outputs: none
    # Returns: List of Mail Entries matching the filter/search
    def self.search_sender(search_sender, general_search = false, no_action_placeholder = "")
        # note: may lead to issues if sender can be empty (if thats allowed)
        if search_sender
            if general_search == false && search_sender == no_action_placeholder # placeholder val provided, no filter should be performed
                return MailEntry.all
            else
                MailEntry.where("lower(sender_name) LIKE ?", "%#{search_sender.downcase}%")  # return any sender containing their search, even with partial matches or different letter cases
            end
        else # parameter not provided
            MailEntry.all
        end
    end

    # self.search_case_status: A function to return Mail Entries matching the provided case status
    # Inputs: search_case_status, general_search, no_action_placeholder
    #  - search_case_status: The value or description that needs to be matched, or the no_action_placeholder (see below)
    #  - general_search (default, false): Whether the function is being used for filtering or a general search.
    #                                     If false, the function is used for filtering, and no_action_placeholders are considered
    #                                     If true, the function is used for searching, placeholders are ignored. This is to prevent
    #                                     a user from providing a general search term of "Any" for example and matching every entry in the database.
    #                                     Additionally, the function attempts to convert the case_status from a string to an integer, via helper method
    #  - no_action_placeholder (default, "-1"): The value signifying no filtering should be performed against the specific attribute, and that all entries should be returned
    #                                         This is ignored if general_search is true
    # Outputs: none
    # Returns: List of Mail Entries matching the filter/search
    def self.search_case_status(search_case_status, general_search = false, no_action_placeholder = "-1")
        if search_case_status
            if general_search == false && search_case_status == no_action_placeholder # placeholder val provided, no filter should be performed
                return MailEntry.all
            elsif general_search == false
                # cast to int, if possible. If this isn't able to be done (ex the term is a label name), return nothing
                begin
                    search_case_status = Integer(search_case_status)
                rescue
                    return MailEntry.none
                end
                MailEntry.where(case_status: search_case_status)
            else # general search needs special implementation
                status_int = case_status_from_description(search_case_status)
                if status_int.to_s != no_action_placeholder # assumes that no_action_placeholder is an integer
                    # use it as above
                    MailEntry.where(case_status: status_int)
                else # not found, return nothing
                    MailEntry.none
                end
            end
        else # parameter not provided
            MailEntry.all
        end
    end

    # self.search_inmate_id: A function to return Mail Entries matching the provided inmate id
    # Inputs: search_inmate_id, general_search, no_action_placeholder
    #  - search_inmate_id: The value that needs to be matched, or the no_action_placeholder (see below)
    #  - general_search (default, false): Whether the function is being used for filtering or a general search.
    #                                     If false, the function is used for filtering, and no_action_placeholders are considered
    #                                     If true, the function is used for searching, placeholders are ignored. This is to prevent
    #                                     a user from providing a general search term of "Any" for example and matching every entry in the database.
    #  - no_action_placeholder (default, ""): The value signifying no filtering should be performed against the specific attribute, and that all entries should be returned
    #                                         This is ignored if general_search is true
    # Outputs: none
    # Returns: List of Mail Entries matching the filter/search
    def self.search_inmate_id(search_inmate_id, general_search = false, no_action_placeholder = "")
        if search_inmate_id
            if general_search == false && search_inmate_id == no_action_placeholder # placeholder val provided, no filter should be performed
                return MailEntry.all
            else
                MailEntry.where("CAST (inmate_id AS TEXT) LIKE ?", "%#{search_inmate_id}%") # return any inmate_id containing their search, even with partial matches or different letter cases
                # need the typecast since inmate_id is currently stored as an integer
            end
        else # parameter not provided
            MailEntry.all
        end
    end

    # self.search_current_age: A function to return Mail Entries matching the provided current age
    # Inputs: search_current_age, general_search, no_action_placeholder
    #  - search_current_age: The value that needs to be matched, or the no_action_placeholder (see below)
    #  - general_search (default, false): Whether the function is being used for filtering or a general search.
    #                                     If false, the function is used for filtering, and no_action_placeholders are considered
    #                                     If true, the function is used for searching, placeholders are ignored. This is to prevent
    #                                     a user from providing a general search term of "Any" for example and matching every entry in the database.
    #  - no_action_placeholder (default, ""): The value signifying no filtering should be performed against the specific attribute, and that all entries should be returned
    #                                         This is ignored if general_search is true
    # Outputs: none
    # Returns: List of Mail Entries matching the filter/search
    def self.search_current_age(search_current_age, general_search = false, no_action_placeholder = "")
        if search_current_age
            if general_search == false && search_current_age == no_action_placeholder # placeholder val provided, no filter should be performed
                return MailEntry.all
            else
                # cast to int, if possible. If this isn't able to be done (ex the term is a label name), return nothing
                begin
                    search_current_age = Integer(search_current_age)
                rescue
                    return MailEntry.none
                end
                MailEntry.where(current_age: search_current_age)
            end
        else # parameter not provided
            MailEntry.all
        end
    end

    # self.search_crime_age: A function to return Mail Entries matching the provided crime age
    # Inputs: search_crime_age, general_search, no_action_placeholder
    #  - search_crime_age: The value that needs to be matched, or the no_action_placeholder (see below)
    #  - general_search (default, false): Whether the function is being used for filtering or a general search.
    #                                     If false, the function is used for filtering, and no_action_placeholders are considered
    #                                     If true, the function is used for searching, placeholders are ignored. This is to prevent
    #                                     a user from providing a general search term of "Any" for example and matching every entry in the database.
    #  - no_action_placeholder (default, ""): The value signifying no filtering should be performed against the specific attribute, and that all entries should be returned
    #                                         This is ignored if general_search is true
    # Outputs: none
    # Returns: List of Mail Entries matching the filter/search
    def self.search_crime_age(search_crime_age, general_search = false, no_action_placeholder = "")
        if search_crime_age
            if general_search == false && search_crime_age == no_action_placeholder # placeholder val provided, no filter should be performed
                return MailEntry.all
            else
                # cast to int, if possible. If this isn't able to be done (ex the term is a label name), return nothing
                begin
                    search_crime_age = Integer(search_crime_age)
                rescue
                    return MailEntry.none
                end
                MailEntry.where(crime_age: search_crime_age)
            end
        else # parameter not provided
            MailEntry.all
        end
    end

    # self.search_home_institution: A function to return Mail Entries matching the provided home institution
    # Inputs: search_home_institution, general_search, no_action_placeholder
    #  - search_home_institution: The value that needs to be matched, or the no_action_placeholder (see below)
    #  - general_search (default, false): Whether the function is being used for filtering or a general search.
    #                                     If false, the function is used for filtering, and no_action_placeholders are considered
    #                                     If true, the function is used for searching, placeholders are ignored. This is to prevent
    #                                     a user from providing a general search term of "Any" for example and matching every entry in the database.
    #  - no_action_placeholder (default, "Any"): The value signifying no filtering should be performed against the specific attribute, and that all entries should be returned
    #                                         This is ignored if general_search is true
    # Outputs: none
    # Returns: List of Mail Entries matching the filter/search
    def self.search_home_institution(search_home_institution, general_search = false, no_action_placeholder = "Any")
        # partial matches / case insensitivity needed due to general search
        if search_home_institution
            if general_search == false && search_home_institution == no_action_placeholder # placeholder val provided, no filter should be performed
                return MailEntry.all
            else
                MailEntry.where("lower(home_institution) LIKE ?", "%#{search_home_institution.downcase}%")  # return any home institution containing their search, even with partial matches or different letter cases
            end
        else # parameter not provided
            MailEntry.all
        end
    end

    # self.search_offender_race: A function to return Mail Entries matching the provided offender race
    # Inputs: search_offender_race, general_search, no_action_placeholder
    #  - search_offender_race: The value that needs to be matched, or the no_action_placeholder (see below)
    #  - general_search (default, false): Whether the function is being used for filtering or a general search.
    #                                     If false, the function is used for filtering, and no_action_placeholders are considered
    #                                     If true, the function is used for searching, placeholders are ignored. This is to prevent
    #                                     a user from providing a general search term of "Any" for example and matching every entry in the database.
    #  - no_action_placeholder (default, "Any"): The value signifying no filtering should be performed against the specific attribute, and that all entries should be returned
    #                                         This is ignored if general_search is true
    # Outputs: none
    # Returns: List of Mail Entries matching the filter/search
    def self.search_offender_race(search_offender_race, general_search = false, no_action_placeholder = "Any")
        # partial matches / case insensitivity needed due to general search
        if search_offender_race
            if general_search == false && search_offender_race == no_action_placeholder # placeholder val provided, no filter should be performed
                return MailEntry.all
            else
                MailEntry.where("lower(offender_race) LIKE ?", "%#{search_offender_race.downcase}%")  # return any offender race containing their search, even with partial matches or different letter cases
            end
        else # parameter not provided
            MailEntry.all
        end
    end

    # self.search_victim_race: A function to return Mail Entries matching the provided victim race
    # Inputs: search_victim_race, general_search, no_action_placeholder
    #  - search_victim_race: The value that needs to be matched, or the no_action_placeholder (see below)
    #  - general_search (default, false): Whether the function is being used for filtering or a general search.
    #                                     If false, the function is used for filtering, and no_action_placeholders are considered
    #                                     If true, the function is used for searching, placeholders are ignored. This is to prevent
    #                                     a user from providing a general search term of "Any" for example and matching every entry in the database.
    #  - no_action_placeholder (default, "Any"): The value signifying no filtering should be performed against the specific attribute, and that all entries should be returned
    #                                         This is ignored if general_search is true
    # Outputs: none
    # Returns: List of Mail Entries matching the filter/search
    def self.search_victim_race(search_victim_race, general_search = false, no_action_placeholder = "Any")
        # partial matches / case insensitivity needed due to general search
        if search_victim_race
            if general_search == false && search_victim_race == no_action_placeholder # placeholder val provided, no filter should be performed
                return MailEntry.all
            else
                MailEntry.where("lower(victim_race) LIKE ?", "%#{search_victim_race.downcase}%")  # return any victim race containing their search, even with partial matches or different letter cases
            end
        else # parameter not provided
            MailEntry.all
        end
    end

    # self.search_date: A function to return Mail Entries strictly within the range of specified dates
    # Inputs: search_date_upper, search_date_lower, no_action_placeholder
    #  - search_date_upper: If provided, all return mail entries have a date strictly before this value
    #  - search_date_lower: If provided, all return mail entries have a date strictly after this value
    #  - no_action_placeholder (default, ""): The value signifying no filtering should be performed against the specific attribute, and that all entries should be returned
    # Outputs: none
    # Returns: List of Mail Entries matching the filter
    def self.search_date(search_date_upper, search_date_lower, no_action_placeholder = "")
        # general_search not applicable, due to only being used in filtering
        if search_date_upper && search_date_lower # both parameters exist (e.g, direct page access or search on date button pressed)
            if search_date_upper != no_action_placeholder && search_date_lower != no_action_placeholder # both non empty
                MailEntry.where("date > ? AND date < ?", search_date_lower, search_date_upper)
            elsif search_date_lower != no_action_placeholder # lower bound specified
                MailEntry.where("date > ?", search_date_lower)
            elsif search_date_upper != no_action_placeholder # upper bound specified
                MailEntry.where("date < ?", search_date_upper)
            else # neither specified, don't filter
                MailEntry.all
            end
        elsif search_date_lower # only lower bound exists (rare, only direct page access)
            if search_date_lower != no_action_placeholder # specified, we can handle it
                MailEntry.where("date > ?", search_date_lower)
            else # not specified, don't filter
                MailEntry.all
            end
        elsif search_date_upper # only upper bound exists (rare, only direct page access)
            if search_date_upper != no_action_placeholder # specified, we can handle it
                MailEntry.where("date < ?", search_date_upper)
            else # not specified, don't filter
                MailEntry.all
            end
        else # none specified, don't filter
            MailEntry.all
        end    
    end

    # self.search_date: A function to return Mail Entries fully or partially matching the provided date
    # Inputs: search_date, no_action_placeholder
    #  - search_date: The value that needs to be matched, or the no_action_placeholder (see below). Must be in mm/dd/yyyy format if provided in full, partial should use / for separation
    #  - no_action_placeholder (default, ""): The value signifying no filtering should be performed against the specific attribute, and that all entries should be returned
    # Outputs: none
    # Returns: List of Mail Entries matching the search
    def self.search_single_date(search_date, no_action_placeholder = "")
        # general_search not applicable, due to only being used in general search
        # functions similar to search_date, but due to the nature of general searches looks for a single date as opposed to a range
        if search_date && search_date != no_action_placeholder
            # need to deal with formatting
            MailEntry.where("TO_CHAR(date, 'mm/dd/yyyy') LIKE ?", "%#{search_date}%") # ideally this will work for partial dates, though formatting may need to be considered
        else # no search term (should not occur)
            MailEntry.all
        end
    end

    # self.sort: A function to return provided Mail Entries (by id) in a desired sort order
    # Inputs: ids, method, no_action_placeholder
    #  - ids: The listing of mail entries, represented by their ids, to be returned in a desired ordering
    #  - method: The ordering method. Currently only supports Oldest and Newest for non default behavior
    #  - no_action_placeholder (default, "None"): The value signifying don't sort
    # Outputs: none
    # Returns: Mail Entries list as specified by ids, in a desired ordering
    def self.sort(ids, method, no_action_placeholder = "None")
        if method == nil || method == no_action_placeholder # method is equal to placeholder or not provided, don't sort
            return MailEntry.where("id IN (?)", ids)
        elsif method == "Sender (A-Z)" # by sender name
            return MailEntry.where("id IN (?)", ids).order(:sender_name) 
        elsif method == "Sender (Z-A)" # by sender name
            return MailEntry.where("id IN (?)", ids).order(sender_name: :desc)
        elsif method == "Oldest" # by date
            return MailEntry.where("id IN (?)", ids).order(:date) 
        elsif method == "Newest" # by date
            return MailEntry.where("id IN (?)", ids).order(date: :desc)
        elsif method == "Label (A-Z)" # by mail label
            return MailEntry.where("id IN (?)", ids).order(:label) 
        elsif method == "Label (Z-A)" # by mail label
            return MailEntry.where("id IN (?)", ids).order(label: :desc)
        else # default to no ordering
            return MailEntry.where("id IN (?)", ids)
        end
    end

    # filter tag functionality (in tags model)

    # util methods
    # gets the index of the case status, if present
    def self.case_status_from_description(status_description) 
        # this could be accomplished by a SQL query but due to lack of table this is done here

        # this array should match the one in mail_entries_herlper.rb.
        case_status_description_mapping = ["Not Started", "In Progress", "Complete"] # case status description = case status index into array
        status_description = status_description.downcase # lowercase, for case insensitivity
        match_index = -1 # not matched
        for i in 0...case_status_description_mapping.length do
            if case_status_description_mapping[i].downcase.match?(status_description) # partial or full match
                match_index = i
                break
            end
        end
        return match_index
    end

private
    #added by team 14
    # def mail_entry_params
    #     params.require(:mail_entry).permit(:label, :date, )
    # end

end
