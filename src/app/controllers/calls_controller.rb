# Project name: Call Organizer
# Description: ACCR Management System Tracker 
# Filename: calls_controller.rb
# Description: functions for calls in call log
# Last modified on: 4/20/23

class CallsController < ApplicationController
  before_action :set_call, only: %i[ show edit update destroy ]

  # GET /calls or /calls.json
  def index
    params.permit(:search)

    _searchParam = params[:search]
    _dateParam = params[:date]
    if (_searchParam != nil)
      @calls = Call.search(_searchParam, _dateParam)
    else
      @calls = Call.all()
    end
  end

  # GET /calls/1 or /calls/1.json
  def show
  end

  # GET /calls/new
  def new
    @call = Call.new
  end

  # GET /calls/1/edit
  def edit
  end

  # POST /calls or /calls.json
  def create
    @call = Call.new(call_params)

    respond_to do |format|
      if @call.save
        format.html { redirect_to call_url(@call), notice: "Call was successfully created." }
        format.json { render :show, status: :created, location: @call }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @call.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /calls/1 or /calls/1.json
  def update
    respond_to do |format|
      if @call.update(call_params)
        format.html { redirect_to call_url(@call), notice: "Call was successfully updated." }
        format.json { render :show, status: :ok, location: @call }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @call.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calls/1 or /calls/1.json
  def destroy
    @call.destroy

    respond_to do |format|
      format.html { redirect_to calls_url, notice: "Call was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_call
      @call = Call.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def call_params
      params.require(:call).permit(:caller_type, :name, :phone_number, :inmate_num, :institution, :location, :point_of_contact, :date, :notes, :call_status)
    end
end