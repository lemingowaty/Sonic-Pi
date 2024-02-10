use_bpm 80
live_loop :kalimbaloop do
  with_synth :kalimba do
    with_fx :level do
      with_bpm_mul 4 do
        8.times do
          tick
          in_thread do
            4.times do |x|
              sample :drum_cymbal_closed, amp: 0.5, attack: 0.125
              sleep 2
              density 2 do |y|
                sample :drum_cymbal_closed, on: (x%2)==0, attack: ((y+1)*0.125)
                sleep 2
              end
            end
          end
          with_fx :echo, phase: 2, max_phase: 4 do
            with_synth_defaults amp: ring(8,4).look, pitch: ring(0,12,0,24).look do
              2.times do |x|
                density (x+1) do
                  play :d3, release: 4*(x+1)
                  play :d2, release: 4*(x+1)
                  sleep 2
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