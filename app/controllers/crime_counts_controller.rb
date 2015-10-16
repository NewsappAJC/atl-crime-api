class CrimeCountsController < ApplicationController

	def zone_totals
	    @counts = CrimeCount.zone_time_totals
	    render json: @counts, callback: params[:callback]
	end

end