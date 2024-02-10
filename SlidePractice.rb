# Welcome to Sonic Pi
use_bpm 80
live_loop :mel1a do
  use_synth :bass_foundation
  n1 = play :a1, attack: 1, release: 4, note_slide: 1
  sleep 2
  n1.control("note", :a7)
  sleep 1
  n1. control("note", :a1)
  sleep 1
  
  density 2 do
    sl = play :g0, release: 4, sustain: 1 , attack: 1, note_slide: 2, rate: 2
    sl.control({note_slide: 2})
    sleep 2
    sl.control("note", :a0)
    
    sleep 1
    sl.control({note_slide: 1 , note: :a3})
    
    sleep 1
    sl.control({note: :a1 , release: 0})
  end
  ##| sync "/live_loop/hihat"
end

live_loop :hh6, sync: "/live_loop/mel1a" do
  in_thread do
    sample :drum_bass_hard
    sleep 2
    
    sample :drum_snare_hard
    sleep 0.125
    sample :drum_snare_soft
    sleep 0.125
    sample :drum_snare_soft
    sleep 1-0.25
    
    sample :drum_bass_hard
    sleep 1.5
    sample :drum_bass_hard
    sleep 0.5
    
    sample :drum_snare_hard
    sleep 0.5
    sample :drum_bass_hard
    sleep 1
    sample :drum_bass_hard
    sleep 0.5
    sample :drum_bass_hard
    sample :drum_snare_hard
  end
  density 2 do
    8.times do |x|
      sample :drum_cymbal_closed, amp: ( (x%4)==0 ? 1 : 0.75 ), attack: 0.25
      sleep 1
    end
  end
  
end