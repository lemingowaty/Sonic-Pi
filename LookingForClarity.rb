use_bpm 60
def bdhard
  with_sample_defaults amp: 0.7 do
    4.times do |md|
      2.times do |x|
        density 2 do
          4.times do |i|
            sample ((i%2)==0 ? :drum_bass_hard : :drum_bass_soft )
            sleep 0.25
            sample :drum_bass_soft, on: (i==0&&x==0)
            sleep 0.25
          end
        end
      end
    end
  end
end
def hhtact1 mx
  2.times do
    4.times do |x|
      density 2 do |y|
        if (x==2 && y==0)
          sample :drum_cymbal_hard, amp: 0.5, pan: 0.5
        else
          sample :drum_cymbal_closed, amp: 0.5, pan: -0.5
        end
        sleep 0.5
        sample :drum_cymbal_closed, amp: 0.5, on: (x%2)!=0&&mx==1
        sleep 0.5
      end
    end
  end
end
live_loop :hh do
  in_thread do
    bdhard
  end
  2.times do
    density 2 do |i|
      puts i
      hhtact1 i
    end
  end
end
live_loop :snar, sync: :hh do
  ratestep = 1.0 / 12
  ratemod = 12
  with_bpm_mul 4 do
    2.times do |j|
      4.times do |i|
        sleep 2
        sample :sn_generic, rate: ratestep * ratemod
        sleep 1
        density (j+1) do |minusrate|
          sample :sn_generic, on: i==2, onset: 1, rate: ratestep*(ratemod + minusrate)
          sleep 1
        end
      end
    end
  end
end
live_loop :mel1, sync: "/live_loop/hh" do
  with_synth_defaults amp: 1.8 do
    2.times do
      with_synth :organ_tonewheel do
        play chord(:a2, :M), release: 4
        sleep 2
        play :a3, release: 4, amp: 1
        sleep 2
        play chord(:a2, :M), release: 4
        sleep 2
        play :d3, release: 2
        sleep 2
      end
    end
  end
end
live_loop :mel2, sync: "/live_loop/mel1" do
  with_synth_defaults amp: 1.4, release: 2 do
    with_fx :ping_pong, amp: 2 do
      with_synth :pluck do
        2.times do |x|
          puts x
          density 2 do
            play :a4
            play :a4+7
            sleep 2
          end
          play :a5
          sleep 2
          density 2 do
            play :a4+3
            play :a4+10
            sleep 1
            play :a4+10
            sleep 1
          end
          play :a4-2
          sleep 1
          density x+1 do
            play :a4, release: 1
            sleep 0.5
            play :a4-2, release: 1
            sleep 0.5
          end
        end
      end
    end
  end
end