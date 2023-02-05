# Project name: Pro Bono Tracker %>
# Description: Tracker system to manage pro bono works conducted in ACCR
# Filename: worklogs_controller.rb
# Description: Controller to handle all actions involving the worklogs %>
# Last modified on: 11/17/2022

class WorklogsController < ApplicationController
  before_action :set_worklog, only: %i[ show edit update destroy ]

  # GET /worklogs or /worklogs.json
  def index
    
    #Worklog access control for csv download
    #Only admins can see/download all total worklogs
    #***********NEED UPDATING*************
    #ACCR admins don't care who gets to download total worklogs
    @worklogs = Worklog.accessible_by(current_ability).order(:id).page params[:page]

    #export worklogs to csv for download report
    respond_to do |format|
      format.html
      format.csv { send_data @worklogs.to_csv, filename:"report.csv"}
    end
   
  end


  # GET /worklogs/1 or /worklogs/1.json
  def show
  end

  # GET /worklogs/new
  def new
    @worklog = Worklog.new
  end

  # GET /worklogs/1/edit
  def edit
  end

  # POST /worklogs or /worklogs.json
  def create
    @worklog = Worklog.new(worklog_params)

    respond_to do |format|
      if @worklog.save
        format.html { redirect_to worklog_url(@worklog), notice: "Worklog was successfully created." }
        format.json { render :show, status: :created, location: @worklog }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @worklog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /worklogs/1 or /worklogs/1.json
  def update
    respond_to do |format|
      if @worklog.update(worklog_params)
        format.html { redirect_to worklog_url(@worklog), notice: "Worklog was successfully updated." }
        format.json { render :show, status: :ok, location: @worklog }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @worklog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /worklogs/1 or /worklogs/1.json
  def destroy
    @worklog.destroy

    respond_to do |format|
      format.html { redirect_to worklogs_url, notice: "Worklog was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_worklog
      @worklog = Worklog.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def worklog_params
      params.require(:worklog).permit(:user_id, :project_id, :desc_summary, :desc_body, :hours, :fee, :date, :entered_by_id)
    end
end
