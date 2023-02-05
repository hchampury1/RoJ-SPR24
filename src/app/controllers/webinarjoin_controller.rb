class WebinarjoinController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :index, :new]
  def index
  end
end
