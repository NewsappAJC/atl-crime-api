
class ZonesController < ApplicationController
  # GET /crimes
  # GET /crimes.json

  def all_zones
  	@zones = Zone.all_zones.order('zone asc')
  	render json: @zones, callback: params[:callback]
  end

end