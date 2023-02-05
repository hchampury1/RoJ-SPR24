class InkindsController < ApplicationController
  before_action :set_inkind, only: %i[ show edit update destroy ]

  # GET /inkind or /inkind.json
  def index
    @inkinds = Inkind.all

    respond_to do |format|
      format.html
      format.csv { send_data @inkinds.to_csv, filename:"IK_report.csv"}
    end
  end

  # GET /inkind/1 or /inkind/1.json
  def show
  end

  # GET /inkind/new
  def new
    @inkind = Inkind.new
    @inkind.donor_name = "";
    @inkind.donor_id = 0;
  end

  # GET /inkind/1/edit
  def edit
  end

  # POST /inkind or /inkind.json
  def create
    @inkind = Inkind.new(inkind_params)
    
    respond_to do |format|
      if @inkind.save
        d = Donor.find_by(donor_name: @inkind.donor_name)
        # @inkinds.update_attribute(:donor_id, d.id)
        format.html { redirect_to inkind_url(@inkind), notice: "Donation was successfully created." }
        format.json { render :show, status: :created, location: @inkind }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @inkind.errors, status: :unprocessable_entity }
      end
      
    end
  end

  # PATCH/PUT /inkind/1 or /inkind/1.json
  def update
    respond_to do |format|
      if @inkind.update(inkind_params)
        format.html { redirect_to inkind_url(@inkind), notice: "Donation was successfully updated." }
        format.json { render :show, status: :ok, location: @inkind }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @inkind.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inkind/1 or /inkind/1.json
  def destroy
    @inkind.destroy

    respond_to do |format|
      format.html { redirect_to inkinds_url, notice: "Donation was successfully removed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inkind
      @inkind = Inkind.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def inkind_params
      params.require(:inkind).permit(:name, :date, :value, :description, :user, :genre, :donor_name, :donor_id)
    end
end
