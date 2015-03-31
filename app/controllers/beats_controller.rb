
class BeatsController < ApplicationController
  # GET /crimes
  # GET /crimes.json

  def list_beats
    @beats = Beat.list_beats(params[:zone])
    render json: @beats, callback: params[:callback]
  end

  def all_beats
  	@beats = Beat.all_beats
  	render json: @beats, callback: params[:callback]
  end


end
