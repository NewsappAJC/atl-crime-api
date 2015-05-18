
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

  def by_filter_timerange
    @crimes = Crime.by_filter(params[:field],params[:value]).order('occur_date DESC').time_range(params[:timeval],params[:timeperiod])
    render json: @crimes, callback: params[:callback]
  end

  def by_timerange
    @crimes = Crime.order('occur_date DESC').time_range(params[:timeval],params[:timeperiod])
    render json: @crimes, callback: params[:callback]
  end

  def count_zone
    @crimes = Crime.order('occur_date DESC').time_range(params[:timeval],params[:timeperiod]).count(group: :zone)
    render json: @crimes, callback: params[:callback]
  end

  def count_beat
    @crimes = Crime.order('occur_date DESC').time_range(params[:timeval],params[:timeperiod]).count(group: :beat)
    render json: @crimes, callback: params[:callback]
  end

  # current rountes

  def count_city
    @crimes = Crime.count_crimes
    render json: @crimes, callback: params[:callback]
  end

  def filter_city
    @crimes = Crime.filter_crimes
    render json: @crimes, callback: params[:callback]
  end

  def map_city
    @crimes = Crime.time_range('1','month')
    render json: @crimes, callback: params[:callback]
  end

  def citywide_comp
    @crimes = Crime.created_between_count("1/1/2009".to_date).filter
    render json: @crimes, callback: params[:callback]
  end

  # end current routes

  
  def countall
    @crimes = Crime.order('occur_date DESC').created_between_count("1/1/2009".to_date).crime_count
    render json: @crimes, callback: params[:callback]
  end

  def countviolent
    @crimes = Crime.order('occur_date DESC').created_between_count("1/1/2009".to_date).violent_count
    render json: @crimes, callback: params[:callback]
  end

  def counttime
    @crimes = Crime.created_between_count("1/1/2009".to_date).time_of_day
    render json: @crimes, callback: params[:callback]
  end

  def lastdate
    @crimes = Crime.order('occur_date DESC').time_range('0','day').first
    render json: @crimes, callback: params[:callback]
  end


  def by_filter_countall
    @crimes = Crime.created_between_count("1/1/2009".to_date).by_filter(params[:field],params[:value]).crime_count
    render json: @crimes, callback: params[:callback]
  end
  
  def by_filter_countviolent
    @crimes = Crime.created_between_count("1/1/2009".to_date).by_filter(params[:field],params[:value]).violent_count
    render json: @crimes, callback: params[:callback]
  end

  def by_filter_countshift
    @crimes = Crime.created_between_count("1/1/2009".to_date).by_filter(params[:field],params[:value]).shift_count
    render json: @crimes, callback: params[:callback]
  end

  def by_filter_time
    @crimes = Crime.created_between_count("1/1/2009".to_date).by_filter(params[:field],params[:value]).time_of_day
    render json: @crimes, callback: params[:callback]
  end

  def by_zones
    @crimes = Crime.created_between_count("1/1/2009".to_date).count_zones
    render json: @crimes, callback: params[:callback]
  end


  def top_violent
    @crimes = Crime.created_between_count("1/1/2009".to_date).mostviolent(params[:group])
    render json: @crimes, callback: params[:callback]
  end

  def top_nonviolent
    @crimes = Crime.created_between_count("1/1/2009".to_date).mostnonviolent(params[:group])
    render json: @crimes, callback: params[:callback]
  end

  def top_list
    @crimes = Crime.created_between_count("1/1/2009".to_date).mostcrime(params[:group])
    render json: @crimes, callback: params[:callback]
  end


  # # GET /crimes/1
  # # GET /crimes/1.json
  # def show
  #   @crime = Crime.find(params[:id])
  #   render json: @crime
  # end

end
