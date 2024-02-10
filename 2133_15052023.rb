use_bpm 80
live_loop :kalimbaloop do
  cue :drumloop
  with_synth :kalimba do
    with_fx :level do
      with_bpm_mul 4 do
        8.times do
          tick
          with_fx :echo, phase: 2, max_phase: 4 do
            with_synth_defaults amp: ring(8,4).look, pitch: ring(0,12,0,24).look do
              2.times do |x|
                density (x+1) do
                  play :d3, release: 4*(x+1)
                  play :d2, release: 4*(x+1)
                  sleep 1
                  play :d2, release: 1
                  sleep 1
                end
                play (:d2+7), release: 2, sustain: 2
                sleep 2
                play :d2, release: 4
                sleep 2
                density 2 do
                  play :a3, on: x==1, release: 2
                  play :a2, release: 2
                  sleep 2
                end
              end
            end
          end
        end
      end
    end
  end
end

live_loop :drumloop do
  4.times do |i|
    with_bpm_mul 4 do
      4.times do |j|
        4.times do |x|
          sample :drum_bass_hard, on: i>0
          sample :drum_cymbal_closed, amp: 0.5, attack: 0.125
          sleep 1
          sample :drum_bass_soft, on: ((x%2)!=0) && (i>0)
          sleep 1
          
          sample :drum_snare_hard, amp: 0.5
          density 2 do |y|
            sample :drum_cymbal_closed, on: (x%2)==0, attack: ((y+1)*0.125)
            sleep 2
          end
        end
      end
    end
  end
end
