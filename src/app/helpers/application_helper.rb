# frozen_string_literal: true

# Helper functions made here are accessable in all views
# for example, app_name is now accessable to all views
# Last modified on: 3/28/23 by Team 24 (Spring 2023)
module ApplicationHelper
  def app_name
    conf = app_config
    if conf.nil?
      'ACCR Mail Storage System'
    else
      conf.name
    end
  end

   # Modified 3/28/23
   # This function is called to sort column entries based on asc/desc order based 
   # on the triggered event (mouse click). The user will click on a column header and it will
   # redirect the user to a refreshed page based on the sorted attributes.
  def sortable(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    #icon_class = sort_column == column ? (sort_direction == "asc" ? "fa fa-sort-asc" : "fa fa-sort-desc") : "fa fa-sort"
    icon_class = "fa fa-sort"
    if column == sort_column
      icon_class = sort_direction == "asc" ? "fa fa-sort-asc" : "fa fa-sort-desc"
    end
    link_to "#{title} <i class='#{icon_class}'></i>".html_safe, {sort: column, direction: opposite_sort_direction(column), clear_sort: nil}, class: "sort-link", "data-column-name": title
  end
  
  #this function takes a column parameter and checks the current sort direction
  #It returns the opposite directionm either asc or desc
  #it is used by the above function to generate links with the opposite sort direction
  def opposite_sort_direction(column)
    if column == sort_column && sort_direction == "asc"
      "desc"
    elsif column == sort_column && sort_direction == "desc"
      "asc"
    else
      "asc"
    end
  end


  private

  def app_config
    AppConfig.first
  end
  
end
