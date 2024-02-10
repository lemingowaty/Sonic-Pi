use_bpm 70
define :xmx do
  sample :bd_haus
end
define :xmm do
  sample :drum_heavy_kick
end
define :xmc do
  sample :bd_klub
end
define :xxx do
  sample :bd_808
end
define :xxq do
  sample :bd_tek
end
define :xxw do
  sample :bd_boom
end
define :xxe do
  sample :bd_fat
end
with_fx :distortion, amp: 1.4, distort: 0.2 do
  8.times do
    sample :bd_haus, lpf: 90, attack: 0.02, pan: -0.2
    sleep 1
    sample :bd_808, lpf: 90, attack: 0.02, pan: -0.2
  end
  sleep 0.75
  sample :bd_klub, lpf: 90, attack: 0.02, pan: -0.2
  sleep 0.25
  8.times do
    sample :bd_haus, lpf: 90, attack: 0.02, pan: -0.2
    sleep 0.5
  end
end
timeacc = 0
define :obd1 do |x=0|
  if (x+1)%1 != 0
    xmx
  else
    xmm
  end
  sleep 0.5
  timeacc += 0.5
  xmx
  sleep 0.5
  timeacc += 0.5
  xmm
  ##| /*---*1/
  sleep 0.5
  timeacc += 0.5
  xmc
  sleep 1
  timeacc += 1
  ##| /*---*2/
  sleep 0.5
  timeacc += 0.5
  xxx
  sleep 0.5
  timeacc += 0.5
  ##| /*---*3/
  xxq
  xxw
  sleep 0.5
  timeacc += 0.5
  ##| ====1
  xxe
  density 1 do
    sleep 0.5
    xmx
    sleep 0.5
    ##| ---4
    sleep 0.5
  end
  timeacc += 1.5
  xmm
  sleep 0.5
  timeacc += 0.5
  ##| /*===*2/
  ##| xmx
  ##| sleep 1 //To się już nie mieści w rytmie ani 3/4 ani 4/4
  puts timeacc
end
define :obd2 do |x|
  if (x+1)%1 != 0
    xmx
  else
    xmm
  end
  sleep 0.5
  xmc
  sleep 1
  xmc
  sleep 0.5
  xmm
  sleep 0.5
  xxx
  sleep 0.5
  xmx
  sleep 0.5
  xmc
  sleep 0.5
  ##| /*====*1/
  xxq
  xxw
  sleep 0.5
  xxe
  sleep 1
  density 1 do
    2.times do
      xmx
      sleep 1 ##|Zmiana z 0.5 na 1
    end
  end
  ##| /*====*/
end
density 1 do
  in_thread do
    4.times do
      density 1 do
        4.times do
          sample :bd_tek
          sleep 2
        end
      end
    end
    puts "HH Koniec"
  end
  live_loop :riff do
    use_synth :bass_foundation
    riff = (ring :b0, :b1, :d2, :g2,
            :b1, :b3, :g0, :b0, :b0,
            :r, :e1, :g2,
            :b1, :e0, :e1, :g2
            )
    play riff.tick, amp: 0.25, release: 0.5
    sleep 0.25
  end
  sleep 8
end
4.times do
  
  density 2 do |x|
    obd2 x
  end
  density 2 do |x|
    obd1 x
  end
end









