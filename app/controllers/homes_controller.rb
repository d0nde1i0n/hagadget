class HomesController < ApplicationController
  def top
    flash.now[:success] = 'Hellow,World!!'
  end
end
