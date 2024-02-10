##| sample_free_all

dbh = :drum_bass_hard
dsh = :drum_snare_hard
dcc = :drum_cymbal_closed
use_bpm 90

sampledir = "C:/Users/lemin/Music/G6_Looper/"
samplenames = ["90_64_071123_1920.wav"]

riff1_64 = sampledir+samplenames[0]
puts riff1_64
load_sample sampledir+samplenames[0]



live_loop :main6 do
  
  cue :sn1
  sleep 4
end

live_loop :metro do
  sync :sn1
  puts "Loop Start"
  sample riff1_64
  sleep 64
  puts "*"*10
end

live_loop :drummer do
  sync :sn1
  4.times do
    2.times do
      4.times do
        sample dbh
        4.times do |i|
          2.times do
            sample dcc, rate: 1.1, pan: ring(0.75, 0.75, -0.75, -0.75).tick, amp: 0.5
            sleep 0.25
            if i==1
              sample dbh
            end
          end
        end
      end
    end
  end
end


