class GadgetsController < ApplicationController
  before_action :authenticate_user!,except: [:index]

  def new
    
  end

  def index
  end

  def show
  end

  def edit
  end
end
