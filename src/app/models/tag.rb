# Project name: ACCR Mail Manager
# Description: Mail database and management system for ACCR community partner
# Filename: tag.rb
# Description: Contains filtering/searching code specific to tags
# Last modified on: 4/8/22
# Code written by Team 13

class Tag < ApplicationRecord
    def self.search_tags(search_tags, general_search = false, no_action_placeholder = "")
        if general_search == false # filtering via checkboxes or other interface (ex multiselect dropdown)
            # partial matches + case insensitivity do not need to be considered
            if search_tags
                list = MailEntry.none
                # due to needing to have different IDs for the appropriate labeling (enhancing accessibility by
                # making the area to click to select the checkbox larger), this ends up being passed as a hash
                search_tags = search_tags[0].values
                search_tags.each { |tag|
                    e = Join.where(tag_id: tag).pluck(:mail_id)
                    list = list | MailEntry.where(id: e)
                }
                list
            else
                MailEntry.all
            end
        else
            # partial matches + case insensitivity need to be considered, due to generic text field
            if search_tags
                matches = self.where("lower(name) LIKE ?", "%#{search_tags.downcase}%").pluck(:id)
                puts matches
                e = Join.where("tag_id IN (?)", matches).pluck(:mail_id)
                MailEntry.where(id: e)
            else
                MailEntry.all
            end
        end
    end

    # def self.search_tags_general(search_tags)
    #     if search_tags && search_tags != ""
    #         entry = self.where(name: search_tags).pick(:id)
    #         e = Join.where(tag_id: entry).pluck(:mail_id)
    #         MailEntry.where(id: e)
    #     else
    #         MailEntry.all
    #     end
    # end
end