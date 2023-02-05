class AboutController < ApplicationController
    skip_before_action :authenticate_user!
    def index
    end
  
    def graph
    end
    
  end