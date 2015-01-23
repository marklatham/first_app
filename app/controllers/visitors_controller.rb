class VisitorsController < ApplicationController

  def index
    @standings = Standing.all.order("rank ASC")
    @ballot = find_ballot
  end

end
