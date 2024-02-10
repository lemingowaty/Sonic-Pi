# Welcome to Sonic Pi
use_bpm 60
bdSynced = false


live_loop :hihat do
  sleepacc = 0
  4.times do |i|
    4.times do |j|
      density 4 do |dns|
        stretch1 = 1.024-((-1.0/12)*(dns+1))
        stretch2 = 1.024+((1.0/12)*-(dns+1))
        btStretch = (j+1)%2 == 0 ? stretch1 : stretch2
        ampli = ((j==0 or j==2) and dns == 0)  ? 1 : 0.45
        sample :drum_cymbal_closed, amp: ampli , beat_stretch: btStretch, on: true
        
        if i==2 and bdSynced == false
          cue :mysync
        end
        
        sleep 1
      end
      sleepacc += 1
    end
  end
  puts "snare" + sleepacc.to_s
end


live_loop :bassdrum do
  puts tick
  if bdSynced == false
    puts "Syncing BD"
    sync :mysync
    bdSynced = true
  end
  sleepacc = 0
  4.times do |i|
    
    4.times do |j|
      
      density 2 do
        sample :bd_ada, amp: (i==0 ? 1 : 0.7), sample_stretch: -0.5
        sleep 1
      end
      sleepacc += 1
    end
  end
  puts "bdrum" + sleepacc.to_s
end
sleep 4
live_loop :snare, sync: :mysync do
  density 4 do
    sleep 2
    sample :sn_dolf
    sleep 2
  end
end