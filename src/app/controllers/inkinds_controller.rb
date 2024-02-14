

class InkindsController < ApplicationController
  before_action :set_inkind, only: %i[ show edit update destroy ]
  

  # GET /inkind or /inkind.json
  def index
    params.permit(:search)

    _searchParam = params[:search]
    if (_searchParam != nil)
      @inkinds = Inkind.search(_searchParam)
    else
      @inkinds = Inkind.all()
    end
    # @inkinds = Inkind.all

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
    @inkind.inkindentries.build
    @inkind.donor_name = "";
    @inkind.donor_id = 0;
    @donor_names = Donor.pluck(:donor_name)
  end

  # GET /inkind/1/edit
  def edit
    @donor_names = Donor.pluck(:donor_name)
  end

  # POST /inkind or /inkind.json
  def create
    
    donor = Donor.find_by(donor_name: inkind_params[:donor_name])
    inkind_params_with_donor_id = inkind_params.merge(donor_id: donor.id) if donor.present?
    @inkind = Inkind.new(inkind_params_with_donor_id)

    respond_to do |format|
      if @inkind.save

        format.html { redirect_to inkind_url(@inkind), notice: "Donation was successfully created." }
        format.json { render :show, status: :created, location: @inkind }
      else
        @donor_names = Donor.pluck(:donor_name)
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


  #Searches for a certain string based on all pro-bono hour donations
  def inkinds


  
  #Downloads a pdf of a particular in kind donation
  def download_pdf

    pdf = Prawn::Document.new
    pdf.font "Times-Roman"

    inkind = Inkind.find(params[:id])

    #rendering the template image
    pdf.image "#{Rails.root}/app/assets/images/inkind_template.png", at: [0, 730],  width: 530


    #local variables
    project_name = inkind.name
    donor_organization = inkind.donor_name
    address = inkind.donor.location
    phone_number = inkind.donor.phoneNumber
    date_of_service = inkind.date.strftime("%B %d, %Y")
    approvee_name = "Gregory  Johnson"
    approvee_title = "Director of Operations"
    date_approved = Date.today
    services_type = inkind.genre
    inkind_entries = inkind.inkindentries
    total_services = 0
    total_goods = 0
    total_facilities = 0
    total_value = 0

    pdf.font 'Times-Roman'
  
    #drawing the PDF entries onto the PDF
    pdf.draw_text "Atlantic Center for Capital Representation", at: [198, 635]
    pdf.draw_text project_name, at: [50, 608]
    pdf.draw_text donor_organization, at: [110, 595]
    pdf.draw_text address, at: [57, 582]
    pdf.draw_text phone_number, at: [340, 556]
    pdf.draw_text date_of_service, at: [150, 503]
    
    pdf.draw_text approvee_name, at: [150, 130]
    pdf.draw_text approvee_title, at: [150, 117]
    pdf.draw_text date_approved, at: [150, 104]  
    
      
    if services_type == "service"
      pdf.text_box "N.A.", at: [85, 362], align: :left
      pdf.text_box "N.A.", at: [100, 270], align: :left
      y_position = 467
      inkind_entries.each do |inkind_entry|
        name = inkind_entry.description
        hours = inkind_entry.hours
        cost = inkind_entry.value
        [["#{name}", 70], ["#{hours}", 305], ["#{cost}", 400]].each do |text, x_position|
          pdf.text_box text, at: [x_position, y_position], align: :left
        end
        total_services += cost.to_i
        y_position -= 13
      end
      total_value = total_services
      pdf.draw_text total_services, at: [396, 381] 
      pdf.draw_text "N.A.", at: [396, 287]
      pdf.draw_text "N.A.", at: [396, 183]  
 
    elsif services_type == "good(s)"
      pdf.text_box "N.A.", at: [96, 481], align: :left
      pdf.text_box "N.A.", at: [100, 270], align: :left
      y_position = 350
      inkind_entries.each do |inkind_entry|
        name = inkind_entry.description
        cost = inkind_entry.value
        [["#{name}", 70], ["#{cost}", 400]].each do |text, x_position|
          pdf.text_box text, at: [x_position, y_position], align: :left
        end
        total_goods += cost.to_i
        y_position -= 13
      end
      total_value = total_goods
      pdf.draw_text "N.A.", at: [396, 381] 
      pdf.draw_text total_goods, at: [396, 287]
      pdf.draw_text "N.A.", at: [396, 183]  

    elsif services_type == "facility"
      pdf.text_box "N.A.", at: [96, 481], align: :left
      pdf.text_box "N.A.", at: [85, 362], align: :left
      y_position = 257
      inkind_entries.each do |inkind_entry|
        place = inkind_entry.description
        cost = inkind_entry.value
        [["#{place}", 70], ["#{cost}", 400]].each do |text, x_position|
          pdf.text_box text, at: [x_position, y_position], align: :left
        end
        total_facilities += cost.to_i
        y_position -= 13
      end
      total_value = total_facilities
      pdf.draw_text "N.A.", at: [396, 381] 
      pdf.draw_text "N.A.", at: [396, 287]
      pdf.draw_text total_facilities, at: [396, 183]  
    end

    pdf.draw_text total_value, at: [396, 170]  
    send_data pdf.render, filename: "hello.pdf", type: "application/pdf", disposition: "inline"

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inkind
      @inkind = Inkind.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def inkind_params
      params.require(:inkind).permit(:name, :date, :value, :hours, :description, :user, :genre, :donor_name, :donor_id, inkindentries_attributes: [:id, :description, :hours, :value])
    end

  end
end