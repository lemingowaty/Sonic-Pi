sampledir = "C:/Users/lemin/Music/G6_Looper/"

sample1 = sampledir+"01-24_L107_140_64.wav"
sample2 = sampledir+"01-24_L108_70_32.wav"
use_bpm 140
2.times do
  sample sample1, amp: 5
  with_fx :reverb, room: 0.75 do
    
    with_fx :ixi_techno, phase: 2, mix: 0.25 do
      
      with_fx :slicer, invert_wave: 1, pulse_width: 0.5, phase: 0.25, smooth: 0.5 do
        sample sample2, amp: 10, rate:1 , finish: 1, release: 0.25, pitch: 0
      end
    end
  end
  sample :drum_splash_hard
  4.times do
    4.times do
      density 1 do
        4.times do |x|
          with_fx :reverb, amp: 1, damp: 0, mix: 0.25 do
            sample :drum_heavy_kick, beat_stretch: 0.5
            
            density 2 do |y|
              sample :drum_cymbal_closed, amp: (x==0 ? 0.5 : 0.35), on: !(x==3 && y==0), rate: 2
              sleep 1
            end
          end
        end
      end
    end
  end
  2.times do
    sample sample1, amp: 5
    in_thread do
      2.times do
        with_fx :distortion, distort: 0.75 do
          sample sample2, amp: 2.5, rate:2 , finish: 1, release: 0.25
        end
        sleep sample_duration(sample2)/2
      end
    end
    sample :drum_splash_hard
    4.times do
      4.times do
        density 1 do
          4.times do |x|
            with_fx :reverb, amp: 1, damp: 0, mix: 0.25 do
              sample :drum_heavy_kick, beat_stretch: 0.5
              
              density 4 do |y|
                sample :drum_cymbal_closed, amp: (x==0 ? 0.5 : 0.35), on: !(x==3 && y==0), rate: 2
                sleep 1
              end
            end
          end
        end
      end
    end
  end
end
