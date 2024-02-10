use_bpm 90

define :drumbeat01 do
  4.times do |j|
    4.times do |i|
      imod2 = i%2 == 1
      jmod2 = j%2 == 1
      if i!=3
        sample :drum_bass_hard
        sleep 0.25
        sample :drum_bass_soft, on: i==1
        sleep 0.5
        sample :drum_bass_hard, on: i==2
        sleep 0.25
      else
        sample :drum_bass_hard, on: jmod2
        sleep 0.25
        sample :drum_bass_soft
        sleep 0.5
        sample :drum_bass_hard
        sleep 0.25
      end
    end
  end
end

define :hhbeat01 do
  density 1 do
    4.times do |x4|
      mod42 = x4%2
      dns = mod42 == 1 ? 4 : 2
      if x4==2 then cue "werbel1" end
      density dns do |di|
        sample :drum_cymbal_closed, on: di!=3
        sleep 1
      end
    end
    4.times do |x4|
      mod42 = x4%2
      dns = mod42 == 1 ? 4 : 2
      if x4==2 then cue "werbel1" end
      density dns do |di|
        sample :drum_cymbal_closed, on: di!=0
        sleep 1
      end
    end
  end
end



live_loop :drumbassloop do
  sync "sygnal"
  4.times do
    density 1 do
      drumbeat01
    end
  end
end
live_loop :drumsnareloop do
  t = 2
  sync "werbel1"
  density 2 do
    sample :drum_snare_hard
    sleep (0.25*t)
    sample :drum_snare_soft
    sleep (0.25*t)
  end
  sleep (0.25*t)
  sample :drum_snare_hard
  sync "werbel1"
  sample :drum_snare_hard
  sleep (0.25*t)
  sample :drum_snare_soft
  sleep (0.375*t)
  sample :drum_snare_hard
  
  sync "werbel1"
  density 2 do
    sample :drum_snare_hard
    sleep (0.25*t)
    sample :drum_snare_soft
    sleep (0.25*t)
  end
  
  sync "werbel1"
  density 1 do
    sample :drum_snare_hard
    sleep (0.125*t)
  end
  sample :drum_snare_soft
  sleep (0.25*t)
  sample :drum_snare_hard
end
sleep 1
live_loop :hhloop0 do
  2.times do
    cue "sygnal"
    hhbeat01
  end
  
end