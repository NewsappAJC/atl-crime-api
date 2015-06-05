
class ZonesController < ApplicationController
  # GET /crimes
  # GET /crimes.json

  # def zone_test
  #   @zones = Zone.all
  #   render json: @zones, serializer: ZoneSerializer, callback: params[:callback]
  # end

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

  def zone_violent
    @zones = Zone.violent_filter(params[:zone])
    render json: @zones, callback: params[:callback]
  end

  def zone_hours
    @zones = Zone.hours_filter(params[:zone])
    render json: @zones, callback: params[:callback]
  end

  def zone_map
    @zones = Zone.map_crimes(params[:zone])
    render json: @zones, callback: params[:callback]
  end

  def beats
    @zones = Zone.zone_beats(params[:zone])
    render json: @zones, callback: params[:callback]
  end

end