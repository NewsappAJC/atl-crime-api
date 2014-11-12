
class CrimesController < ApplicationController
  # GET /crimes
  # GET /crimes.json
  def index
    @crimes = Crime.current_year
    render json: @crimes, callback: params[:callback]
  end

  def most_recent
    @crimes = Crime.find(:all, :order => "id desc", :limit => 25).reverse
    render json: @crimes, callback: params[:callback]
  end

  def current_year
    @crimes = Crime.current_year
    render json: @crimes, callback: params[:callback]
  end

  def current_month
    @crimes = Crime.current_month
    render json: @crimes, callback: params[:callback]
  end

  def by_month
    @crimes = Crime.by_month(params[:year],params[:month])
    render json: @crimes, callback: params[:callback]
  end

  def by_day
    @crimes = Crime.by_day(params[:year], params[:month], params[:day])
    render :json => @crimes.map { |crime| crime.as_json(:only => :id, :methods => :occur_date) }, callback: params[:callback]
  end

  def by_filter
    @crimes = Crime.by_filter(params[:field],params[:value])
    render json: @crimes, callback: params[:callback]
  end

  def by_filter_filter
    @crimes = Crime.by_filter(params[:field],params[:value]).by_filter(params[:field2],params[:value2])
    render json: @crimes, callback: params[:callback]
  end

  def by_filter_thismonth
    @crimes = Crime.by_filter(params[:field],params[:value]).current_month
    render json: @crimes, callback: params[:callback]
  end

  def by_filter_thisyear
    @crimes = Crime.by_filter(params[:field],params[:value]).current_year
    render json: @crimes, callback: params[:callback]
  end

  def by_filter_thismonth_filter
    @crimes = Crime.by_filter(params[:field],params[:value]).current_month.by_filter(params[:field2],params[:value2])
    render json: @crimes, callback: params[:callback]
  end

  def by_filter_thisyear_filter
    @crimes = Crime.by_filter(params[:field],params[:value]).current_year.by_filter(params[:field2],params[:value2])
    render json: @crimes, callback: params[:callback]
  end



  # GET /crimes/1
  # GET /crimes/1.json
  def show
    @crime = Crime.find(params[:id])
    render json: @crime
  end

end
