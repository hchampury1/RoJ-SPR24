# Project name: ACCR Mail Manager
# Description: Mail database and management system for ACCR community partner
# Filename: mail_entries_controller.rb
# Description: The main Ruby file for logic relevant to mail entries (search/filter, add, delete, etc.)
# Last modified on: 4/13/22
# Code written by Team 13 and Team 14

class MailEntriesController < ApplicationController

  before_action :set_mail_entry, only: %i[ show edit update destroy ]

  # GET /mail_entries or /mail_entries.json
  def index
    # first, apply filters
    filtered_mail_entries = MailEntry.search_label(params[:search_label]) & MailEntry.search_sender(params[:search_sender]) & MailEntry.search_case_status(params[:search_case_status]) & MailEntry.search_inmate_id(params[:search_inmate_id]) & MailEntry.search_current_age(params[:search_current_age]) & MailEntry.search_crime_age(params[:search_crime_age]) & MailEntry.search_home_institution(params[:search_home_institution]) & MailEntry.search_offender_race(params[:search_offender_race]) & MailEntry.search_victim_race(params[:search_victim_race]) & MailEntry.search_date(params[:search_date_upper], params[:search_date_lower]) & Tag.search_tags(params[:search_tags])
    # need to do sorting, first give ids
    filtered_ids = []
    filtered_mail_entries.each { |entry|
      filtered_ids.push(entry.id)
    }
    ids = []
    if params[:search] && params[:search] != "" # general searches should only be performed if the search term is non empty
      # do the search
      searched_mail_entries = MailEntry.search_label(params[:search], general_search=true) | MailEntry.search_sender(params[:search], general_search=true) | MailEntry.search_case_status(params[:search], general_search=true) | MailEntry.search_inmate_id(params[:search], general_search=true) | MailEntry.search_current_age(params[:search], general_search=true) | MailEntry.search_crime_age(params[:search], general_search=true) | MailEntry.search_home_institution(params[:search], general_search=true) | MailEntry.search_offender_race(params[:search], general_search=true) | MailEntry.search_victim_race(params[:search], general_search=true) | MailEntry.search_single_date(params[:search]) | Tag.search_tags(params[:search], general_search=true)
      # get ids
      searched_ids = []
      searched_mail_entries.each { |entry|
        searched_ids.push(entry.id)
      }
      # restrict ids to only those matching both the filters and the search term
      ids = filtered_ids & searched_ids
    else # no search performed, just fill ids array
      ids = filtered_ids
    end

    # sort ordering
    @sort_method = params[:sort]
    if @sort_method == nil
      # default of sender a-z
      @sort_method = "Sender (A-Z)"
    end

    # next, perform the sort specified
    # avoids needing to do sorting for each query, instead doing it at the end
    @categories = CategoryView.where(user_id: current_user.id)
    @mail_entries = MailEntry.sort(ids, @sort_method)
    @num_found = @mail_entries.length
    @num_total = MailEntry.all.length
    @tags = Tag.all
    @joins = Join.all
    @selected_tags = []
    @role = current_user.role
    @responses = Response.all
    if params[:search_tags] # tags were present
      selected_tags = params[:search_tags][0].values
      begin # need to convert these to ints
        selected_tags.each { |tag|
          @selected_tags.append(Integer(tag))
        }
      rescue # passed as a string
        @selected_tags = []
      end
    end

  end

  # GET /mail_entries/1 or /mail_entries/1.json
  def show

    # Need to get all of the tags for display.
    @tags = Tag.all
    
    # Need to determine which of these tags belong to this mail entry.
    @assoc_tags = []
    @joins = Join.where(mail_id: @mail_entry.id)
    @joins.each { |join|
      @assoc_tags.push(join.tag_id)
    }
  end

  # GET /mail_entries/new
  def new

    # Need to get all of the tags for display.
    @tags = Tag.all

    @mail_entry = MailEntry.new

    # Adds placeholder values for date and status
    @mail_entry.date = Date.today

    @mail_entry.case_status = 0
  end

  # GET /mail_entries/1/edit
  def edit

    # Need to get all of the tags for display.
    @tags = Tag.all

    # Need to determine which of these tags belong to this mail entry.
    @assoc_tags = []
    @joins = Join.where(mail_id: @mail_entry.id)
    @joins.each { |join|
      @assoc_tags.push(join.tag_id)
    }

  end

  # POST /mail_entries or /mail_entries.json
  def create

    # Need to get all of the tags for display.
    @tags = Tag.all

    @mail_entry = MailEntry.new(mail_entry_params)

    respond_to do |format|
      if @mail_entry.save
        format.html { redirect_to mail_entry_url(@mail_entry), notice: "Mail entry was successfully created, and an automated response has been generated."}
        format.json { render :show, status: :created, location: @mail_entry }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @mail_entry.errors, status: :unprocessable_entity }
      end
    end

    # Update the associations (must be done AFTER .save so that it can read
    # the id from the database).
    updateResponse(@mail_entry.id, params[:selected], @mail_entry.inquiryType, @mail_entry.label)
    updateAssociations(@mail_entry.id, params[:selected])
  end

  # PATCH/PUT /mail_entries/1 or /mail_entries/1.json
  def update

    # Update the associations.
    updateAssociations(@mail_entry.id, params[:selected])

    respond_to do |format|
      if @mail_entry.update(mail_entry_params)
        format.html { redirect_to mail_entry_url(@mail_entry), notice: "Mail entry was successfully updated." }
        format.json { render :show, status: :ok, location: @mail_entry }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @mail_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mail_entries/1 or /mail_entries/1.json
  def destroy

    # Clear all associations from 'join' first.
    Join.where(mail_id: @mail_entry.id).delete_all

    # Then destroy the entry as usual.
    @mail_entry.destroy

    respond_to do |format|
      format.html { redirect_to mail_entries_url, notice: "Mail entry was successfully deleted." }
      format.json { head :no_content }
    end
  end

  # Used to update 'join' entries based on tag selection.
  def updateAssociations(mail_id_val, selected)

    # Clear all associations from 'join' first.
    Join.where(mail_id: mail_id_val).delete_all

    # Then, add the selected tag associations to 'join'.
    if selected != nil
      selected.each { |tag_id|
        the_join = Join.new
        the_join.mail_id = mail_id_val
        the_join.tag_id = tag_id
        the_join.save
      }

    end
  end

  # Used to update response associations with mail entries.
  def updateResponse(mail_id_val, selected, inquiryType, label)
    blurb1 = "Hi [NAME], 

    I'm reaching out to you about your interest in an internship at the Atlantic Center. First off, we love to hear that you feel so passionately about ending the death penalty and are always thrilled to hear about young people like yourself who are getting involved in the movement.
      
    It just so happens that we have taken on another highschool student for this semester, so it might be a great time for you to join us. Let's get a Zoom call or a meeting scheduled to discuss this further. Get back to me with your availability and we'll schedule a meeting.
      
    I look forward to meeting you!"
    blurb2 = "Dear [Name],

    Thank you for applying for the open position at the Atlantic Center. We have reviewed your resume and would like you to submit a brief cover letter detailing your specific interests and passions as they relate to our work.
      
    Please reply to this email address with your cover letter no later than [DATE] and we will inform you promptly whether or not you have been selected for an interview.
      
    Thanks again for your interest in working with ACCR and we're looking forward to learning more about you.
      
    Sincerely,
      
    ACCR Team
    "
    blurb3 = "Dear [NAME], 

    Thank you for reaching out to ACCR about [NAME]'s case, and for supporting his family through your church. ACCR is dedicated to providing assistance to those affected by capital punishment in Pennsylvania.
      
    Upon receiving a request from any incarcerated individual our Executive Director/Legal Director, Marc Bookman, looks into the case to see where it currently is in the court system and to ensure that the client has access to quality representation. Earlier this week Marc looked into [NAME]'s case and found that, like all PA cases with an official death verdict, there are good federal lawyers on the case at this point in time. There is likely nothing that we can do legally for [NAME] in terms of direct representation, but I can assure you that we will continue to monitor his case as we do with all PA death cases and continue to work toward abolishing the death penalty and dismantling death row.
      
    We commend you on any attempts that you make to advocate on [NAME]'s behalf. From my very brief time in this movement so far it's become obvious to me that when people in these nightmare situations have people in their corner, it can make all the difference in the world. That said, we highly recommend working with the active legal team if possible on any communications efforts (sometimes very well meaning social media or other online campaigns can actually have an adverse effect on a client's case). 
      
    If you'd like to continue this conversation I'd be happy to do so and discuss other potential avenues for supporting [NAME], his mother, and yourself. I'd also be glad to connect you with our state advocacy organization if that's something that you'd be interested in - they are also located in York County. 
    "
    blurb4 = "Hi [NAME], 

    I'm following up with you on behalf of the Atlantic Center for Capital Representation as far as being included as one of the charities in your program. This looks like an excellent initiative and we would love to participate. 
      
    Just let me know what information you need from us, or if we should schedule a quick zoom or phone call to discuss further. 
      
    Thank you for reaching out to us.
    "

    # Then, add the selected tag associations to 'join'.
    the_responses = Response.new
    the_responses.mailid = mail_id_val
    the_responses.maillabel = label
    the_responses.response_sent = false
    the_responses.date_sent = nil
    if (inquiryType.eql?("Internship Application"))
      the_responses.response_message = blurb1
      the_responses.save
    elsif (inquiryType.eql?("Job Application/Hiring"))
      the_responses.response_message = blurb2
      the_responses.save
    elsif (inquiryType.eql?("General Legal Support/Case Referrals"))
      the_responses.response_message = blurb3
      the_responses.save
    elsif (inquiryType.eql?("NGO Marketing Solicitations"))
      the_responses.response_message = blurb4
      the_responses.save
    end
    the_responses.save

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mail_entry
      @mail_entry = MailEntry.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def mail_entry_params
      params.require(:mail_entry).permit(:label, :date, :sender_name, :inmate_id, :relevant_staff, :case_status, :current_age, :crime_age, :victim_race, :offender_race, :inquiryType, :home_institution, :pdf, :search_label, :search_sender, :search_case_status, :search_inmate_id, :search_current_age, :search_crime_age, :search_offender_race, :search_victim_race, :search_home_institution, :document, :search_date_upper, :search_date_lower, :sort)
    end
end
