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


live_loop :metro do
  puts "Loop Start"
  ##| sample riff1_64
  ##| with_fx :band_eq do
  ##| with_fx :distortion do
  
  
  ##| end
  in_thread do
    32.times do |x|
      dns = (x%2) + 1
      density dns*2 do
        with_fx :lpf, mix: 1, amp: 1, pre_amp: 2 do
          synth :bass_foundation, note: ring(:a0,:a1).tick, amp:1, release: 0, sustain: 1
          sleep 1
        end
      end
    end
  end
  in_thread do
    with_synth :hoover do
      ##| sleep 32
      density 2 do
        2.times do
          4.times do
            with_fx :reverb do
              with_fx :panslicer, phase_offset: 0, phase: 0.5, pulse_width: 0.155, pan_min: -1, pan_max: 1 do
                
                play [:a2, :a1+7]
                sleep 1
              end
            end
            n = play ring(:a2,:a1).tick, release: 4, note_slide: 1, slide: 1, pitch_slide: 1
            sleep 1
            n.control note: ring( :a2+7 , :gb1, :g2 , :d1).look
            sleep 1
            with_fx :panslicer, phase: 0.25, pulse_width: 0.7 do
              density ring(2,1).look do
                play note: ring(:a2 , :a1 + 7, :a2 , :d2).look+12, synth: :mod_saw
                sleep 1
              end
            end
          end
        end
      end
    end
  end
  ##| end
  density 1 do
    drumpat1
  end
  puts "*"*10
end


