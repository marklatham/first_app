namespace :votes do

  desc "Tally votes for the next day."
  task tally: :environment do
    
    Time.zone = "Pacific Time (US & Canada)"
    time_now = Time.now
    puts "Time now = " + time_now.inspect
    standing_tallied_at = Standing.all.order("tallied_at").last.tallied_at if Standing.any?
    past_standing_tallied_at = PastStanding.all.order("tallied_at").last.tallied_at if PastStanding.any?
    
    if standing_tallied_at
      latest_tallied_at = standing_tallied_at
      if past_standing_tallied_at
        unless standing_tallied_at == past_standing_tallied_at # Normal case is ==
          puts "Warning: standing_tallied_at = " + standing_tallied_at.to_s
          puts "not same as past_standing_tallied_at = " + past_standing_tallied_at.to_s
          if standing_tallied_at > past_standing_tallied_at
            puts "Current standings seem not archived => archiving..."
            for standing in Standing.all
              standing.archive
            end
          else # i.e. standing_tallied_at < past_standing_tallied_at
            latest_tallied_at = past_standing_tallied_at
            puts "Warning: archived standings later than current standings."
          end
        end
      else # i.e. past_standing_tallied_at does not exist
        puts "Warning: no past standings found."
      end
    else # i.e. standing_tallied_at does not exist
      puts "Warning: no current standings found."
      if past_standing_tallied_at
        latest_tallied_at = past_standing_tallied_at
      else
        puts "Warning: no past standings found."
      end
    end
    
    # So now latest_tallied_at has been set,
    # unless neither standing_tallied_at nor past_standing_tallied_at exists.
    if latest_tallied_at
      # Usually 24 hours to next cutoff, but this allows +- 12 hours for unusual situations:
      next_day = 36.hours.since(latest_tallied_at)
    else
      # If no prior tally output exists, default to next_day = now:
      next_day = time_now
    end
    # Set tally_cutoff = the midnight before next_day:
    tally_cutoff = Time.new(next_day.year, next_day.month, next_day.day, 0, 0, 0)
    puts "Tally cutoff = " + tally_cutoff.inspect
    
    if tally_cutoff > time_now
      puts "It's too soon to tally!"
    else
      calc_standings(tally_cutoff)  # Method defined below.
      standings = Standing.all
      if standings.any?
        puts standings.size.to_s " standings calc'd & saved. Archiving..."
        for standing in standings
          standing.archive
        end
      else
        puts "No standings found.  :-("
      end
    end
  end
  
  
  def calc_standings(tally_cutoff)
    
  end
  
end
