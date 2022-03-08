class HomesController < ApplicationController
  def top
    flash.now[:failure] = 'Hellow,World!!'
  end
end
