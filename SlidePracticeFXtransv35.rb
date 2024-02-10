use_bpm 60
# Welcome to Sonic Pi
live_loop :melodyja do
  panring = ring( -1, 1, 1, -1)
  nt2 = nil
  with_fx :panslicer, phase: 0.5, smooth: 0, pulse_width: 0.5, invert_wave:0 do
    with_fx :slicer, phase: 0.125, smooth: 0.25, pulse_width: 0.5, mix: 1 do
      synth :hoover, note: :a1, release: 8, attack: 1, sustain: 8, pan: 0, amp: 0.75
    end
  end
  density 2 do
    
    
    4.times do |x|
      in_thread do
        ##| 1.times do
        4.times do |y|
          sample :drum_cymbal_open, on: ((x==0 or y==0) and y!=3), amp: 0.5
          in_thread do
            sleep 0.5
            sample :drum_bass_hard
          end
          density 2 do
            sample :drum_cymbal_open, on: !(x==0 and y==0), beat_stretch: 0.45
            sleep 0.5
          end
          
          sleep 0.5
          density 2 do
            sample :drum_cymbal_open, on: !(x==0 and y==0), beat_stretch: 0.45
            sleep 0.5
          end
        end
        ##| end
      end
      density 2 do |y|
        sample :drum_bass_hard
        nt2 = ( y==0 ? ( synth :hoover, note: :a1, release: 16, amp: 0.75, note_slide: 0.25/2, amp: 0.5, pan: panring.tick, pan_slide: 0 ) : nt2)
        sleep 1
        
        
        nt2.control({ note: ((:a3-2) + (12*x)) })
        sleep 1
        
        
        nt2.control({ note: ((:a3+7) - (x*12)), pan_slide: 0.25 })
        sleep 1
        //
        
        sleep 0.25
        nt2.control({ note: (:a2-2 - (x*12)) })
        
        sleep 0.25
        
        nt2.control({ note: :a1 })
        sleep 0.25
        
        nt2.control({ note: (:a4 - (x*12)) })
        sleep 0.25
      end
    end
  end
end