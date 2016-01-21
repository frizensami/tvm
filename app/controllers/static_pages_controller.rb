class StaticPagesController < ApplicationController
  def home
    @latest_wave_number = ((Wave.last.try(:wave_number) || 0) + 1).to_s
  end

  def overview
  end

  def about
  end
end
