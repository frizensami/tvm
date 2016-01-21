class StaticPagesController < ApplicationController
  def home
    @latest_wave_number = (Wave.last.wave_number + 1).to_s
  end

  def overview
  end

  def about
  end
end
