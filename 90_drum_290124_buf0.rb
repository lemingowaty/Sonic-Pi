use_bpm 90

define :drumbeat01 do
  2.times do |j|
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
        if j!= 1
          sleep 0.25
        end
      end
    end
  end
end
define :drumbeat02 do
  2.times do |j|
    4.times do |i|
      imod = i%2 == 1
      trig1 = (j==0)&&(i==3)
      trig2 = (j==1)&&(i==2)
      sample :drum_bass_hard, on: !trig1
      sleep 0.25
      sample :drum_bass_hard, on: imod
      sleep 0.25
      sample :drum_bass_hard, on: trig2
      sleep 0.25
      sample :drum_bass_hard, on: trig1
      if (j!=1 and i!=3)
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

define :snarepats01 do |x , t=2|
  case x
  when 0
    density 2 do
      sample :drum_snare_hard
      sleep (0.25*t)
      sample :drum_snare_soft
      sleep (0.25*t)
    end
    sleep (0.25*t)
  when 1
    sample :drum_snare_hard
    sleep (0.25*t)
    sample :drum_snare_soft
    sleep (0.375*t)
    sample :drum_snare_hard
  when 2
    density 2 do
      sample :drum_snare_hard
      sleep (0.25*t)
      sample :drum_snare_soft
      sleep (0.25*t)
    end
    sleep (0.25*t)
    sample :drum_snare_hard
  when 3
    
    sample :drum_snare_hard
    sleep (0.125*t)
    
    sample :drum_snare_soft
    sleep (0.25*t)
    sample :drum_snare_hard
    sleep (0.5*t)
    sample :drum_snare_hard
  end
end

define :snarepats02 do |x|
  sample :drum_snare_hard
  sleep 0.5
  sample :drum_snare_hard, on: (x%2)==1
  case x
  when 1
    sleep 0.75
    sample :drum_snare_hard
  when 3
    sleep 0.25
    sample :drum_snare_soft
    sleep 0.5
    sample :drum_snare_hard
  end
end


live_loop :drumbassloop do
  sync "sygnal"
  2.times do
    
    density 1 do
      puts "-----------" + String(tick+1)
      drumbeat01
    end
  end
  sync "sygnal2"
  2.times do
    
    density 1 do
      puts "-----------" + String(tick+1)
      drumbeat02
    end
  end
end


live_loop :drumsnareloop do
  4.times do |x|
    sync "werbel1"
    snarepats01(x)
  end
  4.times do |x|
    sync "werbel1"
    snarepats02 x
  end
end
sleep 1
live_loop :hhloop0 do
  2.times do
    cue "sygnal"
    hhbeat01
  end
  2.times do
    cue "sygnal2"
    hhbeat01
  end
end
