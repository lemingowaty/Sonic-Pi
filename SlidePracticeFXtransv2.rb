# Welcome to Sonic Pi
use_bpm 120
transring = ring(0,12)
live_loop :mel1a do
  density 2 do
    with_transpose transring.tick do
      puts transring.look
      use_synth :bass_foundation
      n1 = play :a1, attack: 1, release: 4, note_slide: 1, amp: 0.7
      density 2 do |n2x|
        n2 = synth :pluck , note: [:a0+7, :a0], release: 4*(n2x+1)
        sleep 2
      end
      n1.control("note", :a7)
      sleep 1
      n1 = play :a1, note_slide: 0.5, release: 1.5
      sleep 0.5
      n1.control("note", :a3)
      sleep 0.5
      n1.control("release", 0)
    end
    density 2 do |x|
      with_transpose x*12 do
        with_synth :pluck do
          with_fx :slicer, phase: 0.25, amp: 0.25 do
            with_fx :reverb, amp: 0.75, room: 1 do
              sl = play :g0, release: 4, sustain: 2 , attack: 0.5, note_slide: 2, amp: 0.5
              sl.control("note", :a1)
              sleep 2
              density 2 do
                sleep 1
                sl.control({note_slide: 1 , note: :g3})
                
                sleep 1
                sl.control({note: :g4 , release: 0})
              end
            end
          end
        end
      end
    end
  end
end
##| sync "/live_loop/hihat"
##| end

live_loop :hh6, sync: "/live_loop/mel1a" do
  with_sample_defaults amp: 0.5 do
    density 1 do
      in_thread do
        
        2.times do |bigi|
          puts "sync?"
          sample :drum_bass_hard
          sleep 1
          sample :drum_bass_hard, on: bigi==1
          sleep 1
          sample :drum_snare_hard
          sleep 0.125
          sample :drum_snare_soft
          sleep 0.125
          sample :drum_snare_soft
          sleep 0.75
          sample :drum_bass_hard
          sleep 1
          
          sleep 0.5
          sample :drum_bass_hard
          sleep 0.5
          sample :drum_snare_hard
          sleep 0.5
          sample :drum_bass_hard
          sleep 0.5
          
          sample :drum_bass_hard
          sleep 0.5
          sample :drum_snare_hard
          sleep 1.5
        end
      end
      
      2.times do
        puts "sync?"
        density 2 do
          8.times do |x|
            sample :drum_cymbal_closed, amp: ( (x%4)==0 ? 1 : 0.75 ), attack: 0.125
            sleep 1
          end
        end
      end
    end
  end
end

##| sleep 32
live_loop :hardbass, sync: "/live_loop/mel1a" do
  with_fx :krush do
    density 2 do |x|
      with_fx :panslicer, phase: 2, smooth: 0.21, mix: 1 do
        s = sample :bass_hard_c, amp: 0.125, rate: 1-(x*0.5), finish: 0.25, attack: 0.125/2, release: 0.125
        10.times do |i|
          sleep 0.1
          if i>9
            s.control({finish: 0.5})
          end
        end
        sleep 1
      end
    end
  end
end