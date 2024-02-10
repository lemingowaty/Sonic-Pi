use_bpm 80

def beat1(i=0)
  cue :stopac1
  case i
  when 0
    sample :drum_bass_hard
    sleep 2
  when 1
    2.times do
      sample :drum_bass_hard
      sleep 1
    end
  end
  cue :werbelc1
  sample :drum_snare_hard
  sleep 2
end
def beat2(i=0)
  cue :stopac1
  case i
  when 0
    sample :drum_bass_hard
    sleep 2
  when 1
    2.times do
      sample :drum_bass_hard
      sleep 1
    end
  end
  cue :werbelc1
  sample :drum_snare_hard
  sleep 1
  case i
  when 0
    sample :drum_bass_hard
    sleep 0.5
    sample :drum_snare_hard
    sleep 0.25
    sample :drum_snare_soft
    sleep 0.25
  when 1
    sample :drum_snare_hard
    sleep 0.5
    sample :drum_snare_hard
    sleep 0.25
    sample :drum_bass_soft
    sleep 0.25
  end
end
m1 = [:a2, :a3, :g2, :a2]

live_loop :std_mel do
  use_synth :blade
  sync "/cue/stopac1"
  play m1[0], release: 4
  density 4 do
    4.times do |x|
      play m1[x]
      sleep 1
    end
  end
  sync "/cue/stopac1"
  play m1[0], release: 4
  density 4 do
    4.times do |x|
      play m1[x]
      with_fx :panslicer, phase: 0.25 do
        synth :dsaw, note: m1[x]+7, release: 0.125, decay: 0.125, attack: 0.125, amp: 0.25
      end
      sleep 1
    end
  end
  sync "/cue/stopac1"
  play m1[0], release: 4, sustain: 4
  density 4 do
    4.times do |x|
      play m1[x]
      sleep 1
    end
  end
  sync "/cue/stopac1"
  density 4 do
    4.times do |x|
      play m1[x]-2
      with_fx :panslicer, phase: 0.125 do
        play m1[x]+[0,2,0,2][x]
      end
      play m1[x]+7
      sleep 1
    end
  end
end

live_loop :std_drm do
  density 2 do
    density 2 do |i|
      2.times do |j|
        sample :drum_cymbal_soft, on: ((i==0)&&j==0)
        beat1 j
        beat2 j
      end
    end
  end
end

live_loop :mel2 do
  
  tick_reset
  use_synth :fm
  cue "mel2"
  with_fx :reverb, room: 1  do
    2.times do
      ntring = ring( :a2 , :a2+5, :a2 , :a2-2 )
      4.times do |x|
        nt = ntring.tick
        density 8 do |d|
          dns = d%2 == 0 ? 1 : 2
          density dns do
            play nt, release: 2, amp: 2, sustain: 0.5, attack: 0.25
            sleep 4
          end
        end
      end
    end
    4.times do |x|
      density 8 do |d|
        nt = ring( :a2, :a2 ).tick
        dns = d%2 == 0 ? 2 : 1
        density dns do
          play nt, release: 2, sustain: 0.25, amp: 2
          sleep 4
        end
      end
    end
  end
end
