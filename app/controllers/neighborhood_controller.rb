class NeighborhoodController < ApplicationController


  def zone_hoods
  	@neighborhoods = Neighborhood.order(:zone).all_hoods.group_by { |t| t.zone }
  	render json: @neighborhoods, callback: params[:callback]
  end

  def beat_hoods
  	@neighborhoods = Neighborhood.order(:beat).all_hoods.group_by { |t| t.beat }
  	render json: @neighborhoods, callback: params[:callback]
  end

end
