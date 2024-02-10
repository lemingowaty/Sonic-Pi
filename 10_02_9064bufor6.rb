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
puts sample_duration riff1_64

define :drumpat1 do
  puts "Drummer Start"
  x = 0.0
  2.times do
    2.times do
      4.times do
        puts x
        sample dbh
        4.times do |i|
          2.times do
            sample dcc, rate: 1.1, pan: ring(0.75, 0.75, -0.75, -0.75).tick, amp: 0.5
            sleep 0.25
            x += 0.25
            if i==1
              sample dbh
            end
          end
        end
      end
    end
  end
end

define :instrument1 do |d|
  ##| with_fx :lpf, mix: 0, amp: 1, pre_amp: 0 do
  dns = (d%2) + 1
  mel = ring(:a2,:a3,:a2,:a2, :a2,:a3,:a2,:a2)
  mel2 = ring(:a3,:a2+5,:a3, :a2, :a3,:a2+5,:a3, :a2-2 )
  nt = mel.tick
  ##| density dns do
  snd = synth :mod_fm , note: nt,  amp:1, decay: 0.25, sustain: 0.25, note_slide: 0.25, phase: 2, pitch_slide: 0.25, pulse_width: 2, divisor: 2
  sleep 0.5
  density 1 do
    snd.control({note: mel2.look, pitch: 48})
    sleep 0.5
  end
  ##| end
end
define :instrument2 do
  use_synth_defaults amp: 0.75
  use_synth :gabberkick
  density 2 do
    2.times do
      4.times do
        with_fx :reverb do
          ##| with_fx :panslicer, phase_offset: 0, phase: 0.5, pulse_width: 0.155, pan_min: -1, pan_max: 1 do
          
          play [:a1, :a0+7]
          sleep 1
          ##| end
        end
        n = play ring(:a1,:a0).tick, release: 4, note_slide: 1, slide: 1, pitch_slide: 1, pitch:12
        sleep 1
        n.control note: ring( :a2+7 , :gb1, :g2 , :d1).look, pitch: -12
        sleep 1
        with_fx :panslicer, phase: 0.25, pulse_width: 0.7 do
          density ring(2,1).look do
            play note: ring(:a2 , :a1 + 7, :a2 , :d2).look , pitch: -12, release: 0.25
            sleep 1
          end
        end
      end
    end
  end
end
define :intro do
  sample riff1_64, finish: 0.25
  sleep 64/4
  sample riff1_64, start: 0.25, amp: 1
  sleep (64/4)*3
end

##| intro
live_loop :bdrum do
  ##| density 2 do
  2.times do |x|
    with_fx :reverb do
      sample :drum_bass_hard, amp: 1
    end
    density 2*(x+1) do
      sample :hat_metal, amp: 0.25
      sleep 1
    end
  end
  ##| end
end
density 4 do
  sample :hat_cab
  sleep 1
end
live_loop :metro do
  puts "Loop Start"
  in_thread do
    density 1 do
      1.times do
        drumpat1
      end
    end
  end
  sample riff1_64, amp: 3, finish: 0.5
  in_thread do
    with_fx :pitch_shift, pitch: 0 do
      instrument2
    end
  end
  sleep 32
  sample riff1_64, amp: 3, start: 0.5
  in_thread do
    2.times do
      32.times do |x|
        instrument1 x
      end
      in_thread do
        with_fx :pitch_shift, pitch: 0 do
          instrument2
        end
      end
    end
  end
  density 1 do
    1.times do
      drumpat1
    end
  end
  puts "*"*10
end

##| end




