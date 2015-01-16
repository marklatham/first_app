class Ballot
  attr_reader :clicks

  def initialize
    @clicks = []
  end

  def add_vote(vote)
    @clicks << vote
  end
end
