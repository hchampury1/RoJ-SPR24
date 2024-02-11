class OrdersController < ApplicationController
    before_action :authenticate_user!
    def index
      products = Product.all
      @products_purchase = products.where(stripe_plan_name:nil, paypal_plan_name:nil)
    
    end
  
    def submit
    end
  end
  