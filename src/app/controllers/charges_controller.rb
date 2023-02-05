class ChargesController < ApplicationController
  before_action :set_description, only: %i[  new  thanks  ]
  skip_before_action :authenticate_user!, only: [:create, :new, :thanks]
  def new
    @registrant = Registrant.find(params[:format])
    @email = @registrant.email
    @amount = cal_amount @registrant.job

  end

  def create

    @amount = 500
    @description = 2500

    customer = StripeTool.create_customer(params[:stripeEmail], 
                                          params[:stripeToken])

    charge = StripeTool.create_charge( customer.id, 
                                       @amount,
                                       @description)

  def thanks
  end

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
  private

  def amount_to_be_charged

    @registrant = Registrant.find(params[:format])
    @email = @registrant.email
    @amount = cal_amount @registrant.job

  end
  def set_description
    @registrant = Registrant.find(params[:format])
    @amount = 500
    @description = 'Pay here'
  end


  def cal_amount job
    if job == 'Conflict/Contract Counsel'
      return 500
    end

    if job == 'Private Attorney'
      return 2500
    end

    return 000
    

  end
end