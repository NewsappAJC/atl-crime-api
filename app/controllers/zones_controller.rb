
class ZonesController < ApplicationController
  # GET /crimes
  # GET /crimes.json

  def all_zones
  	@zones = Zone.all_zones
  	render json: @zones, callback: params[:callback]
  end

  def show_all_crimes
  	@zones = Zone.count_crimes
  	render json: @zones, callback: params[:callback]
  end

  def zone_crimes
  	@zones = Zone.count_crimes_byzone(params[:zone])
  	render json: @zones, callback: params[:callback]
  end

end