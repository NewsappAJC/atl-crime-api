
class CrimesController < ApplicationController
  # GET /crimes
  # GET /crimes.json
  def index
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
    render json: @crimes, callback: params[:callback]
  end

  # GET /crimes/1
  # GET /crimes/1.json
  def show
    @crime = Crime.find(params[:id])
    render json: @crime, callback: params[:callback]
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
