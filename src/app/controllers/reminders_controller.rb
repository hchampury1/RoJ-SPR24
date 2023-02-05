# Project name: ACCR Mail Manager
# Description: Reminder system that reminds ACCR about mail recieved by sending an email to them.
# Filename: reminders_controller.rb
# Description: Main logic as it pertains to the creation of a reminder as well as sending a reminder to a speciifc email address
# Last modified: 4/10/22
# Code written by Team 24

class RemindersController < ApplicationController
  before_action :set_reminder, only: %i[ show edit update destroy ]
  
  # GET /reminders or /reminders.json
  

  def index
    @reminders = Reminder.all
  end

  # GET /reminders/1 or /reminders/1.json
  def show
  end

  # GET /reminders/new
  def new
    @reminder = Reminder.new
  end

  # GET /reminders/1/edit
  def edit
  end

  # POST /reminders or /reminders.json
  def create
    @reminder = Reminder.new(reminder_params)

    respond_to do |format|
      if @reminder.save
        # Start a job to deliver an email at its specified time
        ReminderMailer.with(reminder: @reminder).new_reminder_email.deliver_later(wait_until: (@reminder.reminder_time.to_time - Time.now).seconds.from_now)

        format.html { redirect_to reminder_url(@reminder), notice: "Reminder was successfully created." }
        format.json { render :show, status: :created, location: @reminder }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @reminder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reminders/1 or /reminders/1.json
  def update
    respond_to do |format|
      if @reminder.update(reminder_params)
        format.html { redirect_to reminder_url(@reminder), notice: "Reminder was successfully updated." }
        format.json { render :show, status: :ok, location: @reminder }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reminder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reminders/1 or /reminders/1.json
  def destroy
    @reminder.destroy

    respond_to do |format|
      format.html { redirect_to reminders_url, notice: "Reminder was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reminder
      @reminder = Reminder.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reminder_params
      params.require(:reminder).permit(:mail_entry_id, :user_email, :username, :notes, :reminder_time, :priority)
    end
end
