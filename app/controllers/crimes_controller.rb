
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

  # def by_filter_filter
  #   @crimes = Crime.by_filter(params[:field],params[:value]).by_filter(params[:field2],params[:value2])
  #   render json: @crimes, callback: params[:callback]
  # end

  def by_filter_timerange
    @crimes = Crime.by_filter(params[:field],params[:value]).time_range(params[:timeval],params[:timeperiod])
    render json: @crimes, callback: params[:callback]
  end

  def by_timerange
    @crimes = Crime.time_range(params[:timeval],params[:timeperiod])
    render json: @crimes, callback: params[:callback]
  end

  def count_zone
    @crimes = Crime.time_range(params[:timeval],params[:timeperiod]).count(group: :zone)
    render json: @crimes, callback: params[:callback]
  end

  def count_beat
    @crimes = Crime.time_range(params[:timeval],params[:timeperiod]).count(group: :beat)
    render json: @crimes, callback: params[:callback]
  end

  # def by_filter_year
  #   @crimes = Crime.by_filter(params[:field],params[:value]).time_year(params[:timeval])
  #   render json: @crimes, callback: params[:callback]
  # end

  # def by_filter_sixmonth
  #   @crimes = Crime.created_between(6.month.ago, Time.now).by_filter(params[:field],params[:value])
  #   render json: @crimes, callback: params[:callback]
  # end

  # def by_filter_twomonth_filter
  #   @crimes = Crime.created_between(2.month.ago, Time.now).by_filter(params[:field],params[:value]).by_filter(params[:field2],params[:value2])
  #   render json: @crimes, callback: params[:callback]
  # end

  # def by_filter_sixmonth_filter
  #   @crimes = Crime.created_between(6.month.ago, Time.now).by_filter(params[:field],params[:value]).by_filter(params[:field2],params[:value2])
  #   render json: @crimes, callback: params[:callback]
  # end

# this spits out ugly hash { date => # of crime incidents on that date }
  
  def countall
    @crimes = Crime.created_between("1/1/2009".to_date,Time.now).crime_count
    render json: @crimes, callback: params[:callback]
  end

  def countviolent
    @crimes = Crime.created_between("1/1/2009".to_date,Time.now).violent_count
    render json: @crimes, callback: params[:callback]
  end

  def counttime
    @crimes = Crime.created_between("1/1/2009".to_date,Time.now).time_of_day
    render json: @crimes, callback: params[:callback]
  end


  def by_filter_countall
    @crimes = Crime.created_between("1/1/2009".to_date,Time.now).by_filter(params[:field],params[:value]).crime_count
    render json: @crimes, callback: params[:callback]
  end
  
  def by_filter_countviolent
    @crimes = Crime.created_between("1/1/2009".to_date,Time.now).by_filter(params[:field],params[:value]).violent_count
    render json: @crimes, callback: params[:callback]
  end

  def by_filter_countshift
    @crimes = Crime.created_between("1/1/2009".to_date,Time.now).by_filter(params[:field],params[:value]).shift_count
    render json: @crimes, callback: params[:callback]
  end

  def by_filter_time
    @crimes = Crime.created_between("1/1/2009".to_date,Time.now).by_filter(params[:field],params[:value]).time_of_day
    render json: @crimes, callback: params[:callback]
  end

  def by_zones
    @crimes = Crime.created_between("1/1/2009".to_date,Time.now).count_zones
    render json: @crimes, callback: params[:callback]
  end


  # GET /crimes/1
  # GET /crimes/1.json
  def show
    @crime = Crime.find(params[:id])
    render json: @crime
  end

end
