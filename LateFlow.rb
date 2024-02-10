# Welcome to Sonic Pi
use_bpm 60
bdSynced = false


live_loop :hihat do
  sleepacc = 0
  dens = 16
  bs = dens/2
  4.times do |i|
    4.times do |j|
      if i==2 and bdSynced == false
        cue :mysync
      end
      density dens do |dns|
        stretch1 = 1.024-((-1.0/12)*(dns+1))
        stretch2 = 1.024+((1.0/12)*-(dns+1))
        btStretch = (j+1)%2 == 0 ? stretch1 : stretch2
        ampli = ((j==0 or j==2) and dns == 0)  ? 1 : 0.45
        with_fx :reverb, room: 1, mix: 0.7 do
          sample :drum_cymbal_closed, amp: ampli , beat_stretch: 1.1024*bs, on: ((dns+1)%8)==1, attack: 0.125, pan: ( ((i+1)%2)==0 ? -1 : 1 )
          
          
          
          sleep 1
        end
      end
      sleepacc += 1
    end
  end
  puts "snare" + sleepacc.to_s
end

def bdpat1(i)
  2.times do
    density ((i+1)%2)+1 do
      4.times do |j|
        sample :drum_bass_soft, amp: (i==0 ? 1 : 0.7), sample_stretch: -0.5
        sleep 1
        
        sample :drum_bass_soft, sample_stretch: 0
        sleep 0.25
        sample :drum_bass_hard, amp: (i==0 ? 1 : 0.7)
        sleep 0.75
      end
    end
  end
end

def bdpat2(i)
  density ((i+1)%2)+1 do
    2.times do |j|
      
      density 2 do
        sample :drum_bass_hard, amp: (i==0 ? 1 : 0.7), sample_stretch: -0.5
        sleep 1
      end
      sleep 0.25
      sample :bd_ada
      sleep 0.75
    end
  end
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
    bdpat1 i
    sleepacc += 1
  end
  puts "bdrum" + sleepacc.to_s
  
  4.times do |i|
    bdpat2 i
    sleepacc += 1
  end
  puts "bdrum" + sleepacc.to_s
end




live_loop :snare, sync: :mysync do
  density 4 do
    sleep 2
    sample :sn_dolf
    sleep 2
  end
end
mel1ring = ring( :a1, :e1, :d1, :e2, :a2, :a2 -2, :d1, :d2)
live_loop :mel1, sync: :mysync do
  with_synth :tri do
    4.times do |x|
      density 4 do |z|
        4.times do |y|
          play mel1ring.look - 12, release: 2
          play mel1ring.look - 5, release: 2
          play mel1ring.look, release: 1.5
          play mel1ring.tick + 12, release: 0.25
          sleep 1
          play mel1ring.tick - ( x!=3 && y==3 ?  2 : -16 ), release: 0.51
          play mel1ring.tick
          play mel1ring.look - ( x!=3 && y>=2 && z==3 ?  2-12 : -16+12 ), release: 0.5
          sleep 0.5
          play mel1ring.tick
          play mel1ring.look - ( x==3 && y>=2 && z==3 ?  -2 : -16+12 ), on: (x==3 && y>=2 && z>=2), release:0.5
          sleep 0.25
          density 2 do
            play mel1ring.look - ( x==3 && y>=2 ?  -2 : -16-12 ) , on: (x==3 && y>=2 && z>=2), release: 0.25
            sleep 0.25
          end
        end
      end
    end
  end
end