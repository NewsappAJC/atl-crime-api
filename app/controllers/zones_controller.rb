
class ZonesController < ApplicationController
  # GET /crimes
  # GET /crimes.json

  # def zone_test
  #   @zones = Zone.all
  #   render json: @zones, serializer: ZoneSerializer, callback: params[:callback]
  # end

  def zone_test
    @zones = Zone.all.map{ |z| { zone: z.zone, population: z.population.to_f, crime_percap: z.population.to_f===0 ? 0 : z.crimes.length/z.population.to_f } }
    render json: @zones, callback: params[:callback]
  end

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