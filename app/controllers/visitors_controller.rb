class VisitorsController < ApplicationController

  def index
    @channels = Channel.where("display_id > 0")
  end

end
