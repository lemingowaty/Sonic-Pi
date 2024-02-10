# Welcome to Sonic Pi

use_bpm 60
##| 4.times do
##|   sample :drum_cymbal_closed
##|   sleep 0.5
##| end
$panring = ring(1,-1)
live_loop :db do
  in_thread do
    
    with_sample_defaults amp: 0.5 do
      2.times do |dens|
        dens = dens+1
        density dens do
          4.times do |x|
            with_fx :panslicer, phase: 0.125  do
              sample :drum_cymbal_closed, start: 0, finish: (1-(x*0.25))
              sleep 0.25
              sample :drum_cymbal_closed, on: x==0, finish: 0.75
              sleep 0.25
              sample :drum_cymbal_closed, on: x==2, finish: 1, start:0.25
              sleep 0.25
            end
            with_fx :ping_pong, feedback: 0.1, phase: 0.125/2, pan_start: $panring.tick do
              sample :drum_cymbal_closed, finish: 0, on: (((x+1)%2)==0), start: 1, rate: 0.25, amp: 0.2
              sleep 0.25
            end
          end
        end
      end
    end
  end
  
  2.times do |y1|
    2.times do |y|
      2.times do |x|
        density 1 do |z|
          with_fx :reverb, amp: 0.5, room: 0.5 do
            density x+1 do
              sample :drum_bass_hard, finish: 0.5*(z+1)
              sleep 0.5
            end
            
            ##| with_fx :echo, decay: 1, amp:0.25, phase: 0.5-(y1*0.25), mix: 1 do
            sample :drum_snare_hard, start: (x)*0.1, finish: 0.5*(x+1), room: 0.5
            sleep 0.125
            ##| end
            sample :drum_snare_soft, on:(y==1&&x==1&&z==0), finish: 0.5, start: 0.1
            sleep 0.125
            sample :drum_bass_soft, on: !(x==1&&z==0), finish: 0.25
            sample :drum_snare_soft, finish: 0.35, start: 0.25, on: (x==0&&z==1&&y==0), rate: -1
            sleep 0.125
            sample :drum_bass_soft, on: !(y==1&&x==1), start: 0.1, finish: 0.25
            sample :drum_snare_soft, on: (y==1), start: 0.125, finish: 0.25, rate: 0.5
            sleep 0.125
          end
        end
      end
    end
  end
end