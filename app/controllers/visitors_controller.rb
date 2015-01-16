class VisitorsController < ApplicationController

  def index
    @channels = Channel.where("display_id > 0")
    @ballot = find_ballot
  end

end
