class CrimesController < ApplicationController

  def count_city
    @crimes = Crime.count_crimes
    render json: @crimes, callback: params[:callback]
  end

  def filter_city
    @crimes = Crime.filter_crimes
    render json: @crimes, callback: params[:callback]
  end

  def city_beats
    @crimes = Beat.beat_details
    render json: @crimes, callback: params[:callback]
  end

  def citywide_comp
    @crimes = Crime.created_between_count("1/1/2009".to_date).filter
    render json: @crimes, callback: params[:callback]
  end

  def lastday
    @crimes = Crime.lastday.first
    render json: @crimes, callback: params[:callback]
  end

end
