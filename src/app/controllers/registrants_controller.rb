
# class RegistrantsController < ApplicationController
#   before_action :set_registrant, only: %i[ show edit update destroy ]
#   skip_before_action :authenticate_user!, only: [:show, :index, :new, :create, :destroy, :update ]

#   # GET /registrants or /registrants.json
#   def index
#     @registrants = Registrant.all
#   end

#   # GET /registrants/1 or /registrants/1.json
#   def show
#   end

#   # GET /registrants/new
#   def new
#     @registrant = Registrant.new
#     @webinar = Webinar.find(params[:format])
#     @webinar.registrants.append(@registrant)
#     # @registrant.webinars.append
#     @webinar_name = @webinar.webinar_name
#   end

#   # GET /registrants/1/edit
#   def edit
#   end

#   # POST /registrants or /registrants.json
  

#   def charge
    
#   end
  
#   # PATCH/PUT /registrants/1 or /registrants/1.json
#   def update
#     respond_to do |format|
#       if @registrant.update(registrant_params)
#         if @registrant.job == 'Private Attorney' or @registrant.job == 'Conflict/Contract Counsel'
#           redirect_to new_charge_path(@registrant.id)
#           return
#         end
#         format.html { redirect_to registrant_url(@registrant), notice: "Registrant was successfully updated." }
#         format.json { render :show, status: :ok, location: @registrant }
#       else
#         format.html { render :edit, status: :unprocessable_entity }
#         format.json { render json: @registrant.errors, status: :unprocessable_entity }
#       end
#     end
#   end

#   # DELETE /registrants/1 or /registrants/1.json
#   def destroy
#     @registrant.destroy

#     respond_to do |format|
#       format.html { redirect_to registrants_url, notice: "Registrant was successfully destroyed." }
#       format.json { head :no_content }
#     end
#   end

#   private
#     # Use callbacks to share common setup or constraints between actions.
#     def set_registrant
#       @registrant = Registrant.find(params[:id])
#     end

#     # Only allow a list of trusted parameters through.
#     def registrant_params
#       params.require(:registrant).permit(:first_name, :last_name, :email, :webinar, :county, :job, :listserv, :topics)
#     end
# end

class RegistrantsController < ApplicationController
  before_action :set_registrant, only: %i[ show edit update destroy ]
  skip_before_action :authenticate_user!, only: [:show, :index, :new, :create, :destroy, :update ]

  # GET /registrants or /registrants.json
  def index
    @registrants = Registrant.all
  end

  # GET /registrants/1 or /registrants/1.json
  def show
  end

  # GET /registrants/new
  def new
    @registrant = Registrant.new
    @registrant.paid = params[:paid]
    @registrant.amount = params[:amount]
    @webinar = Webinar.find(params[:format])
    @webinar.registrants.append(@registrant)
    # @registrant.webinars.append
    @webinar_name = @webinar.webinar_name
    puts "Does the routing go here?\n\n\n\n\n\n\n\n\n"
  end

  # GET /registrants/1/edit
  def edit
  end

  # POST /registrants or /registrants.json
  

  def charge
    @registrant = Registrant.find(params[:registrant_id])
    if params[:paid].present?
      @registrant.update(paid: true, amount: params[:amount])
    end
  end
  
  
  # PATCH/PUT /registrants/1 or /registrants/1.json
  def update
=begin The following code routes a user to the old payment system.
This code is left in just in case it is needed for some reason...
This code can be deleted if this old system is no longer in use.
if @registrant.job == 'Private Attorney' or @registrant.job == 'Conflict/Contract Counsel'
  redirect_to new_charge_path(@registrant.id)
  return
end
=end
    if registrant_params[:first_name].squish.empty?
      @registrant.errors.add(:first_name, "cannot be blank.")
    end
    if registrant_params[:last_name].squish.empty?
      @registrant.errors.add(:last_name, "cannot be blank.")
    end
    if registrant_params[:email].squish.empty?
      @registrant.errors.add(:email, "cannot be blank.")
    end
    if registrant_params[:county].squish.empty?
      @registrant.errors.add(:county, "cannot be blank.")
    end
    puts "\n\n\nRegistrant Params: #{registrant_params}\n\n\n"
    respond_to do |format|

      if @registrant.update(registrant_params)
        #if @registrant.job == 'Private Attorney' or @registrant.job == 'Conflict/Contract Counsel'
          #redirect_to new_charge_path(@registrant.id)
          #return
       # end
        format.html { redirect_to registrant_url(@registrant), notice: "Registrant was successfully updated." }
        format.json { render :show, status: :ok, location: @registrant }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @registrant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /registrants/1 or /registrants/1.json
  def destroy
    @registrant.destroy

    respond_to do |format|
      format.html { redirect_to webinars_url, notice: "Registrant was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_registrant
      @registrant = Registrant.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def registrant_params
      params.require(:registrant).permit(:first_name, :last_name, :email, :webinar, :state, :county, :job, :listserv, :topics, :amount, :paid)
    end
end