=begin
Project name: ACCR Webinar
Description: This project will keep track of the webinars and their respective speakers.
Filename: webinars_controller.rb
Description: Handles creation and updating of webinars
Last modified on: April 22, 2023
=end

# class WebinarsController < ApplicationController
#   before_action :set_webinar, only: %i[ show edit update destroy ]
#   skip_before_action :authenticate_user!, only: [:show, :index]

#   # GET /webinars or /webinars.json
#   def index
#     @webinars = Webinar.all
#   end

#   # GET /webinars/1 or /webinars/1.json
#   def show
#   end

#   def registrants
#     @webinars = Webinar.find(params[:id])
#   end


#   # GET /webinars/new
#   def new
#     @webinar = Webinar.new
#   end

#   # GET /webinars/1/edit
#   def edit
#   end

#   # POST /webinars or /webinars.json
#   def create
#     @webinar = Webinar.new(webinar_params)

#     respond_to do |format|
#       if @webinar.save
#         format.html { redirect_to webinar_url(@webinar), notice: "Webinar was successfully created." }
#         format.json { render :show, status: :created, location: @webinar }
#       else
#         format.html { render :new, status: :unprocessable_entity }
#         format.json { render json: @webinar.errors, status: :unprocessable_entity }
#       end
#     end
#   end

#   # PATCH/PUT /webinars/1 or /webinars/1.json
#   def update
#     respond_to do |format|
#       if @webinar.update(webinar_params)
#         format.html { redirect_to webinar_url(@webinar), notice: "Webinar was successfully updated." }
#         format.json { render :show, status: :ok, location: @webinar }
#       else
#         format.html { render :edit, status: :unprocessable_entity }
#         format.json { render json: @webinar.errors, status: :unprocessable_entity }
#       end
#     end
#   end

#   # DELETE /webinars/1 or /webinars/1.json
#   def destroy
#     @webinar.destroy

#     respond_to do |format|
#       format.html { redirect_to webinars_url, notice: "Webinar was successfully deleted." }
#       format.json { head :no_content }
#     end
#   end

#   private
#     # Use callbacks to share common setup or constraints between actions.
#     def set_webinar
#       @webinar = Webinar.find(params[:id])
#     end

#     # Only allow a list of trusted parameters through.
#     def webinar_params
#       params.require(:webinar).permit(:webinar_name, :description, :date_and_time, :speaker)
#     end
# end

class WebinarsController < ApplicationController
include WebinarsHelper
  before_action :set_webinar, only: %i[ show edit update destroy ]
  skip_before_action :authenticate_user!, only: [:show, :index, :deregister, :deregisterSubmitted]
    # GET /webinars or /webinars.json
  def index
    # date_and_time_range goes from January 1, 1900 until the current system time.
    date_and_time_range = Time.new(1900,1,1,0,0,0) .. Time.now

    @completed_webinars = Webinar.where(date_and_time: date_and_time_range).order(date_and_time: :DESC)
    @upcoming_webinars = Webinar.where.not(date_and_time: date_and_time_range).order(date_and_time: :ASC)

    @webinars = Webinar.all

    if user_signed_in? === false
      @webinar_id_array = Array.new()
      respond_to do |format|
        format.html 
        format.csv { send_data @webinars.to_csv, filename: "webinarALL#{DateTime.now.strftime("%m-%d-%Y-%H:%M")}.csv" }
      end
      return
    end

    registrant_relation = Registrant.where(email: current_user.email)
    registrant_id_array = registrant_relation.pluck(:id)
    puts "Registrant ID Array: #{registrant_id_array} \n\n\n"
    if registrant_id_array.empty?
      @webinar_id_array = Array.new()
      respond_to do |format|
        format.html 
        format.csv { send_data @webinars.to_csv, filename: "webinarALL#{DateTime.now.strftime("%m-%d-%Y-%H:%M")}.csv" }
      end
      return
    end

    @webinar_id_array = RegistrantsWebinar.where(registrant_id: registrant_id_array).pluck(:webinar_id)
    respond_to do |format|
      format.html 
      format.csv { send_data @webinars.to_csv, filename: "webinarALL#{DateTime.now.strftime("%m-%d-%Y-%H:%M")}.csv" }
    end
    return
  end

  def exportCSV
    items = Webinar.where(id: params[:webs])
      csv_data = Webinar.to_csv(items)
      send_data csv_data
  end

  # GET /webinars/1 or /webinars/1.json
  def show
    speakers_id_array = WebinarsSpeaker.where(webinar_id: params[:id]).pluck(:speaker_id)
    @speakers_name_array = Array.new()
    speakers_id_array.each do |speaker_id|
      @speakers_name_array.push(Speaker.find_by(id: speaker_id).name)
    end
  end

  def registrants

    @webinars = Webinar.find(params[:id])

  end

  # GET /webinars/new
  # Create 2D-array for HTML dropdown menu
  def new
    @webinar = Webinar.new
    speakers_array = Array.new()
  end

  # GET /webinars/1/edit
  def edit
  end

  # POST /webinars or /webinars.json
  # Use transactions to ensure the database maintains integerity
  # and rolls back to the previous stable state if any errors are 
  # raised unexpectedly.
  def create
    speakers_id_array = params[:webinar][:speakers]
    puts "Webinar Params: #{webinar_params.inspect} \n\n\n"
    is_successful = Webinar.transaction do
      @webinar = Webinar.create!(webinar_params.except(:speakers))
      if webinar_params[:webinar_name].squish.empty?
        @webinar.errors.add(:webinar_name, "cannot be blank.")
      end
      if speakers_id_array.length === 1
        @webinar.errors.add(:speakers, "cannot be blank.")
      end
      if @webinar.errors.any?
        raise ActiveRecord::Rollback
      end
      speakers_id_array.each() do |speaker_id|
        speaker_id = speaker_id.to_i
        if speaker_id != 0 # For some reason, sends in ID: 0 on first input
          WebinarsSpeaker.create!(webinar_id: @webinar.id, speaker_id: speaker_id.to_i)
        end
      end
    end
    respond_to do |format|
      if is_successful
        format.html { redirect_to webinar_url(@webinar), notice: "Webinar was successfully created." }
        format.json { render :show, status: :created, location: @webinar }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @webinar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /webinars/1 or /webinars/1.json
  def update
    respond_to do |format|
      if @webinar.update(webinar_params)
        format.html { redirect_to webinar_url(@webinar), notice: "Webinar was successfully updated." }
        format.json { render :show, status: :ok, location: @webinar }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @webinar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /webinars/1 or /webinars/1.json
  def destroy
    webinars_speakers = WebinarsSpeaker.where(webinar_id: @webinar.id)
    webinars_speakers.each() do |webinar_speaker|
      webinar_speaker.destroy
    end
    @webinar.destroy

    respond_to do |format|
      format.html { redirect_to webinars_url, notice: "Webinar was successfully deleted." }
      format.json { head :no_content }
    end
  end

  def deregister
    @webID = params[:format]
    @name = Webinar.where(id: @webID).pluck(:webinar_name)[0]
    
  end

  def deregisterSubmitted
    @email = params[:email]
    @success = "no"
    registrant =  Registrant.where(email: @email)
    regID = registrant.pluck(:id)[0]
    if RegistrantsWebinar.where(registrant_id: regID, webinar_id: params[:webID]).exists?
      registrant.update(deregistered:"Yes" )
      @success = "yes"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_webinar
      @webinar = Webinar.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def webinar_params
      params.require(:webinar).permit(:webinar_name, :description, :date_and_time, :speakers)
    end
end