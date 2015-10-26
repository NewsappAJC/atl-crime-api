class NeighborhoodsController < ApplicationController
  # GET /neighborhoods
  # GET /neighborhoods.json
  def index
    @neighborhoods = Neighborhood.all
    render json: @neighborhoods
  end

  # GET /neighborhoods/1
  # GET /neighborhoods/1.json
  def show
    @neighborhood = Neighborhood.find(params[:id])

    render json: @neighborhood
  end

  def zone_group
    @neighborhoods = Neighborhood.all.group_by(&:zone_id)
    render json: @neighborhoods
  end

  def beat_group
    @neighborhoods = Neighborhood.all.group_by(&:beat_id)
    render json: @neighborhoods
  end




end
