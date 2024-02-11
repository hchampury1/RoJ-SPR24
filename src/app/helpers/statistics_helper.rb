# Project name: AMSTR (ACCR System Management Tracker)
# Description: Pro-Bono Tracker for ACCR to oversee work done on several cases
# Filename: statistics_helper.rb
# Description: Handles calculations and retrival for data in Worklogs and CategoryView
# Last modified on: 4/21/23

module StatisticsHelper

  # Returns all of the tuples in worklog
  # Used primarily for admin view
  def get_total_tuples
    user_tuples = Donation.all
    return user_tuples
  end

  # Returns the number of entries in worklog
  # Used primarily for admin view
  def calculate_all_num_entries
    num_entries = get_total_tuples()
    total_entries = num_entries.count
    return total_entries
  end

  # Returns the total value of work done
  # by all users.
  def calculate_all_fees
    accr_fees = get_all_curr_month_val()
    total_fees = accr_fees.sum(:fees)
    return total_fees
  end

  # Returns all tuples in worklogs for current user
  def get_user_tuples
    user_tuples = Donation.where(:user_id => current_user.id)
    return user_tuples
  end

  # Returns every tuple this month in worklog
  # Used primarily for admin view
  def get_all_curr_month_val

    # We construct starting date and ending date strings which are then
    # used to parse for tuples in that range from the worklog table.
    # The start date and end date are the beginning and ending of the current month
    # in date form.
    curr_month = Date.today.strftime("%m")
    curr_year = Date.today.strftime("%Y")

    curr_month_end_day = Time.days_in_month(curr_month.to_i)

    curr_month_start_date = curr_year.to_s + '-' + curr_month.to_s + '-01'
    curr_month_end_date = curr_year.to_s  + '-' + curr_month.to_s + '-' + curr_month_end_day.to_s

    curr_month_tuples = Donation.where('date BETWEEN ? AND ?', curr_month_start_date, curr_month_end_date)

    #Modified 3/27/23
    return curr_month_tuples
  end

  # Returns every tuple last month in worklog
  # Used primarily for admin view
  def get_all_prev_month_val

    # We construct starting date and ending date strings which are then
    # used to parse for tuples in that range from the worklog table.
    # The start date and end date are the beginning and ending of the previous month
    # in date form.
    curr_month = Date.today.strftime("%m")
    curr_year = Date.today.strftime("%Y")
    prev_month = '0' + (curr_month.to_i-1).to_s
    prev_year = curr_year

    if curr_month.to_i == 1
      prev_year = curr_year.to_i - 1
      prev_month = "12"
    end

    #Changed on 3/5/23 -> needed to typecast year into an integer
    prev_month_end_day = Time.days_in_month(prev_month.to_i, prev_year.to_i) 


    prev_month_start_date = prev_year.to_s + '-' + prev_month.to_s + '-01'
    prev_month_end_date = prev_year.to_s  + '-' + prev_month.to_s + '-' + prev_month_end_day.to_s
    prev_month_tuples = Donation.where('date BETWEEN ? AND ?', prev_month_start_date, prev_month_end_date)
  end

  # Returns every tuple this month for the current user
  #Changed on 4/21/23 -> changing to all users
  def get_curr_month_user_val
    # This uses the logic which selects all the tuples within the current month
    # and isolates it further to just display the tuples created by the user
    curr_month_tuples = get_all_curr_month_val()
    final_tuples = curr_month_tuples #.where(user_id: current_user.id)

    return final_tuples
  end

  # IMPLEMENT
  # Returns every tuple last month for the current user
  # This uses the logic which selects all the tuples within the previous month
  # and isolates it further to just display the tuples created by the user

  # Returns every tuple last month for all users
  #Changed on 4/21/23 -> changing to all users
  def get_prev_month_user_val
    prev_month_tuples = get_all_prev_month_val()
    final_tuples = prev_month_tuples 
    return final_tuples
  end

  # Calculates the change in % for fees
  # from last month to this month using
  # every tuple.
  def calculate_month_change_fees_all
    # We retrieve the tuples for this month and last month
    # and then calculate the change in percentage for the fees
    curr_month_tuples = get_all_curr_month_val()
    curr_val = curr_month_tuples.sum(:fees)
    prev_month_tuples = get_all_prev_month_val()
    prev_val = prev_month_tuples.sum(:fees)

    total_change = calculate_total_change(curr_val, prev_val)

    percent_diff = assign_sign(curr_val, prev_val, total_change)

    return percent_diff
  end

  # Determines whether to display a decrease
  # or increase in percentage for the change
  def assign_sign(curr_val, prev_val, total_change)
    # If the value for this month is greater than the value
    # of last month, we know it's going to be a positive change
    # To display this intuitively to the user, we will concat a '+'
    # to indicate that this is an increase
    if curr_val > prev_val
      total_change = '+' + total_change.to_s
    else
      total_change = '-' + total_change.to_s
    end

    # If the user does not have enough data to calc the percentage
    # this will return a NaN value. If this is the case, we will display
    # a default 0
    if !total_change.eql? "-NaN"
      return total_change
    else
      return "-0"
    end
  end

  # Uses formula to calculate change in percentage using value
  # from current month and last month
  def calculate_total_change(curr_val, prev_val)
    return (((curr_val.to_f - prev_val) / ((curr_val.to_f + prev_val)/2)) * 100).round(2).abs
  end

  # Calculates the change in percentage for the fees
  # using this month and last month.
  # Used by non-admins
  def calculate_month_change_fees
    # We retrieve the USER tuples for this month and last month
    # and then calculate the change in percentage for the fees
    curr_month_tuples = get_curr_month_user_val()
    curr_val = curr_month_tuples.sum(:fees)
    prev_month_tuples = get_prev_month_user_val()
    prev_val = prev_month_tuples.sum(:fees)

    total_change = calculate_total_change(curr_val, prev_val)

    percent_diff = assign_sign(curr_val, prev_val, total_change)

    return percent_diff
  end

  # Calculates the change in percentage for
  # the number of  entries using this month and
  # last month. Used by non-admins
  def calculate_month_change_entries
    # We retrieve the USER tuples for this month and last month
    # and then calculate the change in percentage for the
    # number of entries
    curr_month_tuples = get_curr_month_user_val()
    curr_val = curr_month_tuples.count()
    prev_month_tuples = get_prev_month_user_val()
    prev_val = prev_month_tuples.count()

    total_change = calculate_total_change(curr_val, prev_val)

    percent_diff = assign_sign(curr_val, prev_val, total_change)

    return percent_diff

  end

  # Calculates the change in percentage for
  # the number of projects contributed to
  # using this month and last month.
  # Used by non-admins
  def calculate_month_change_projects
    # We retrieve the USER tuples for this month and last month
    # and then calculate the change in percentage for the
    # number of projects contributed to
    curr_month_tuples = get_curr_month_user_val()
    curr_val = curr_month_tuples.distinct.count(:project_id)
    prev_month_tuples = get_prev_month_user_val()
    prev_val = prev_month_tuples.distinct.count(:project_id)

    total_change = calculate_total_change(curr_val, prev_val)

    percent_diff = assign_sign(curr_val, prev_val, total_change)

    return percent_diff

  end

  # Calculates the total fees
  # for a user this month
  def calculate_user_total_fees
    user_fees_tuples = get_curr_month_user_val()
    user_fees = user_fees_tuples.sum(:fees)
    return user_fees
  end

  # Calculates the number of entries
  # for a user this month
  def calculate_user_num_entries
    num_entries = get_curr_month_user_val()
    total_entries = num_entries.count()
    return total_entries
  end

  # Calculates the number of projects
  # contributed to for a user this month
  def calculate_projects_contributed
    user_tuples = get_curr_month_user_val()
    numProjects = user_tuples.distinct.count(:project_id)
    return numProjects
  end

  # Returns the name of a category in CategoryView
  def get_cat_name(cat)
    cat_id = Project.find_by(id: cat.project_id)
    return cat_id.name
  end

  # Returns the number of entries for a category in Donations
  #Modified 4/21/23
  def get_cat_quant(cat)
    cat_quant = Donation.where(caseaddress: cat).count()
    return cat_quant
  end

  # Returns the total fees for a category in Donations
  #Modified 4/21/23
  def get_cat_fees(cat)
    cat_fees = Donation.where(caseaddress: cat).sum(:fees)
    return cat_fees
  end

  # Returns the percentage a category makes up of the total
  # in CategoryView

  def get_cat_percentage(cat)
    cat_fees = get_cat_fees(cat)
    total_fees = Donation.all.sum(:fees)
    return ((cat_fees.to_f / total_fees) * 100).round(2)
  end

  # Returns the total number of hours for Consultation, Training, or Representation
  #Modified 4/21/23
  def get_cat_hours(cat_name)
    cat_hours = 0.0

    cat_hours_id = Donation.find_by(name: cat_name)
    if !cat_hours_id.nil?
      cat_hours = Donation.where(project_id: cat_hours_id.id, user_id: current_user.id).sum(:hours)
    end

    return cat_hours
  end

  # Returns number of hours for categories in "Training" section
  #Modified 4/21/23
  def calculate_training
    return Donation.where(caseaddress: "Training").sum(:hours).to_i
  end

  # Returns number of hours for categories in "Representation" section
  #Modified 4/21/23
  def calculate_representation
    return Donation.where(caseaddress: "Direct Representation").sum(:hours).to_i
  end

  # Returns number of hours for categories in "Consultation" section
  def calculate_consultation
    # Since there are 3 categories, the remaining hours not in
    # training or representation hours must be hours for consultation
    # there is also not an easy way to identify which categories are
    # considered "consultation", so this approach helps
    # us to calculate this since it's unclear
    training_hours = calculate_training()
    representation_hours = calculate_representation()
    all_hours = Donation.where(user_id: current_user.id).sum(:hours)
    user_hours = all_hours - training_hours - representation_hours

    if user_hours == all_hours
      user_hours = 0
    end
  end

  # Returns number of hours for categories in "Court" section
  def calculate_court
    return Donation.where(caseaddress: "Court").sum(:hours).to_i
  end


  # Returns number of hours for categories in "Other" section
  def calculate_other
    return Donation.where(caseaddress: "Other").sum(:hours).to_i
  end

  # Returns number of hours for categories in "Consulting" section
  #Modified 4/21/23
  def calculate_consultation
    return Donation.where(caseaddress: "Consulting").sum(:hours).to_i
  end

end
