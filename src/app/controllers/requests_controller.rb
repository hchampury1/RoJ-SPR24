=begin
Project name: ACCR Webinar
Description: This project will keep track of the webinars and their respective speakers.
Filename: requests_controller.rb
Description: Handles creation and updating of a new request and validates appropriately.
Last modified on: April 22, 2023
=end

class RequestsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_request, only: %i[ show edit update destroy ]

  # GET /requests or /requests.json
  def index
    @requests = Request.all
  end

  # GET /requests/1 or /requests/1.json
  def show
  end

  def viewrequests
    @requests = Request.all
  end

  # GET /requests/new
  def new
    @request = Request.new
  end

  # GET /requests/1/edit
  def edit
  end

  # POST /requests or /requests.json
  def create
    @request = Request.new(request_params)
    if request_params[:first_name].squish.empty?
      @request.errors.add(:first_name, "cannot be blank.")
    end
    if request_params[:last_name].squish.empty?
      @request.errors.add(:last_name, "cannot be blank.")
    end
    if request_params[:email].squish.empty?
      @request.errors.add(:email, "cannot be blank.")
    end
    if request_params[:request].squish.empty?
      @request.errors.add(:request, "cannot be blank.")
    end

    respond_to do |format|
      if @request.errors.none? && @request.save
        format.html { redirect_to request_url(@request), notice: "Request was successfully created." }
        format.json { render :show, status: :created, location: @request }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requests/1 or /requests/1.json
  def update
    respond_to do |format|
      if @request.update(request_params)
        format.html { redirect_to request_url(@request), notice: "Request was successfully updated." }
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1 or /requests/1.json
  def destroy
    @request.destroy

    respond_to do |format|
      format.html { redirect_to requests_viewrequests_url, notice: "Request was successfully destroyed." }

      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def request_params
      params.require(:request).permit(:first_name, :last_name, :email, :request)
    end
end
