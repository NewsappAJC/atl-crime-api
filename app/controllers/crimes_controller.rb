
class CrimesController < ApplicationController
  # GET /crimes
  # GET /crimes.json
  def index
    @crimes = Crime.current_year
    render json: @crimes, callback: params[:callback]
  end

  def most_recent
    @crimes = Crime.find(:all, :order => "id desc", :limit => 200).reverse
    render json: @crimes, callback: params[:callback]
  end

  def last_year
    @crimes = Crime.created_between(1.year.ago, Time.now)
    render json: @crimes, callback: params[:callback]
  end

  def last_month
    @crimes = Crime.created_between(3.month.ago, Time.now)
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

  def by_filter_twomonth
    @crimes = Crime.created_between(2.month.ago, Time.now).by_filter(params[:field],params[:value])
    render json: @crimes, callback: params[:callback]
  end

  def by_filter_sixmonth
    @crimes = Crime.created_between(6.month.ago, Time.now).by_filter(params[:field],params[:value])
    render json: @crimes, callback: params[:callback]
  end

  def by_filter_twomonth_filter
    @crimes = Crime.created_between(2.month.ago, Time.now).by_filter(params[:field],params[:value]).by_filter(params[:field2],params[:value2])
    render json: @crimes, callback: params[:callback]
  end

  def by_filter_sixmonth_filter
    @crimes = Crime.created_between(6.month.ago, Time.now).by_filter(params[:field],params[:value]).by_filter(params[:field2],params[:value2])
    render json: @crimes, callback: params[:callback]
  end

# this spits out ugly hash { date => # of crime incidents on that date }
  def by_filter_countviolent
    @crimes = Crime.by_filter(params[:field],params[:value]).violent_crimes
    render json: @crimes, callback: params[:callback]
  end



  # GET /crimes/1
  # GET /crimes/1.json
  def show
    @crime = Crime.find(params[:id])
    render json: @crime
  end

end
