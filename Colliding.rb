def bline1 (notes = [:e2])
  with_synth :chipbass do
    4.times do
      play notes, release: 0.5, decay: 0.125, sustain: 0.125
      sleep 0.25
    end
  end
end
live_loop :mtnm do
  density 2 do
    sample :drum_bass_hard
    1.times do
      density 2 do
        sample :drum_cymbal_closed, amp: 1.2
        sleep 1
      end
      3.times do
        sample :drum_bass_hard
        density 2 do
          sample :drum_cymbal_closed, amp: 0.8
          sleep 1
        end
      end
    end
  end
end

live_loop :bline, sync: :mtnm do
  with_bpm_mul 0.5 do
    bline1 ([:a0,:a1,:a2])
    with_fx :ixi_techno, phase: 0.5, mix: 0.25 do
      density 2 do
        bline1([:a2,:a1,:a1-5])
        bline1([:a1])
      end
      bline1 ([:a0,:a1,:a1+7])
    end
    bline1 ([:a0,:a1,:a2])
    with_fx :ixi_techno, phase: 0.5, mix: 0.25 do
      density 2 do
        bline1([:a2,:a1,:a1-5])
        bline1([:a1,:a2])
      end
      bline1 ([:a0,:a1,:a2,:a3])
    end
  end
end