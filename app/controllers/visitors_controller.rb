class VisitorsController < ApplicationController

  def index
    @standings = Standing.all.order("rank ASC")
    @ballot = find_ballot
  end

  def history
    @past_standings = PastStanding.all.order("tallied_at DESC, rank ASC")
    @channel_ids = @past_standings.map(&:channel_id).uniq
  end

end
