
class CrimesController < ApplicationController
  # GET /crimes
  # GET /crimes.json
  def index
    @crimes = Crime.current_year
    render json: @crimes
  end

  def current_year
    @crimes = Crime.current_year
    render json: @crimes
  end

  def current_month
    @crimes = Crime.current_month
    render json: @crimes
  end

  def by_month
    @crimes = Crime.by_month(params[:year],params[:month])
    render json: @crimes
  end

  def by_day
    @crimes = Crime.by_day(params[:year], params[:month], params[:day])
    render :json => @crimes.map { |crime| crime.as_json(:only => :id, :methods => :occur_date) }
  end

  def by_hood
    @crimes = Crime.by_hood(params[:neighborhood])
    render json: @crimes
  end

  def by_beat
    @crimes = Crime.by_beat(params[:beat])
    render json: @crimes
  end

  def by_shift
    @crimes = Crime.by_shift(params[:shift])
    render json: @crimes
  end

  def by_crime
    @crimes = Crime.by_crime(params[:crime])
    render json: @crimes
  end

  def by_zone
    @crimes = Crime.by_zone(params[:zone])
    render json: @crimes
  end

  def by_weekday
    @crimes = Crime.by_weekday(params[:weekday])
    render :json => @crimes.map { |crime| crime.as_json(:only => :id, :methods => :occur_date) }
  end

  # GET /crimes/1
  # GET /crimes/1.json
  def show
    @crime = Crime.find(params[:id])
    render json: @crime
  end

  # POST /crimes
  # POST /crimes.json
  # def create
  #   @crime = Crime.new(params[:crime])

  #   if @crime.save
  #     render json: @crime, status: :created, location: @crime
  #   else
  #     render json: @crime.errors, status: :unprocessable_entity
  #   end
  # end

  # PATCH/PUT /crimes/1
  # PATCH/PUT /crimes/1.json
  # def update
  #   @crime = Crime.find(params[:id])

  #   if @crime.update(params[:crime])
  #     head :no_content
  #   else
  #     render json: @crime.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /crimes/1
  # DELETE /crimes/1.json
  # def destroy
  #   @crime = Crime.find(params[:id])
  #   @crime.destroy

  #   head :no_content
  # end
end
