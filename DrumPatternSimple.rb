dbh = :drum_bass_hard
dsh = :drum_snare_hard
dcc = :drum_cymbal_closed
use_bpm 50
patring = ring(dbh,dbh,dsh,dsh,dbh,dbh,dsh,nil)
live_loop :drums do
  in_thread do
    2.times do
      4.times do
        density 2 do |x|
          smp = patring.tick
          if smp!=nil
            sample smp
          end
          sleep 0.5
        end
      end
    end
  end
  4.times do
    density 4 do |dx|
      sample dcc
      sleep 0.5
      sample dcc, on: (dx%2)==0
      sleep 0.5
    end
  end
end