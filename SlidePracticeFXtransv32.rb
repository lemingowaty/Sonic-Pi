# Welcome to Sonic Pi
bd = :drum_bass_hard
sn = :sn_generic


def hihatpat1(d1=4,d2=2)
  dcc = :drum_cymbal_closed
  dco = :drum_cymbal_open
  density d1 do |dj|
    4.times do |j|
      sample dco, on: (dj==0 or dj==2)
      density d2 do |di|
        4.times do |i|
          cond = (i==0||i==2)
          sample dcc, on: cond, rate: 1, attack: 0.01
          sample dcc, attack: (i==0 ? 0.125 : 0.075), amp: (i==0 ? 1 : 0.75), on: !cond
          sleep 1
        end
      end
    end
  end
end

live_loop :drum do
  in_thread do
    hihatpat1 2,4
  end
  density 4 do
    4.times do |j|
      4.times do |i|
        sample bd, on: (((j==0 or j==2) and (i==0||i==1))||(j%2==1 and i==1)||(j%2==1 and i==3)||((j==3 or j==2) and (i==1 or i==3)))
        sample sn, on: i==2
        sleep 1
      end
    end
  end
end

live_loop :mel17 do
  ##| sync :drum
  4.times do
    4.times do
      nt = synth :hoover, note: :a4, decay: 4, release: 4, attack: 0.25, amp: 0.25, note_slide: 0.5
      density 2 do
        nt2 = synth :hoover, note: :a2, release: 0.25 , sustain: 4 , decay: 1, attack: 0.25, amp: 0.5, note_slide: 0.5
        sleep 1
        nt2.control({ note: (:a2-2) })
        sleep 1
        nt2.control({ note: (:a3) })
        nt = synth :hoover, note: :a3, note_slide: 0.5
        sleep 1
        nt2.control({ note: (:a2-5) })
        sleep 1
      end
      nt.control({ note: :a4 })
      density 2 do |x|
        nt2 = synth :hoover, note: :a3, release: 4, sustain: 3.75, amp: 0.75, note_slide: 0.25/2, amp: 0.5
        
        sleep 1
        nt2.control({ note: ((:a3-2) + (12*x)) })
        sleep 1
        nt2.control({ note: ((:a3+7) - (x*12))})
        sleep 1
        nt2.control({ note: (:a2-2 - (x*12)) })
        sleep 0.5
        nt2.control({ note: (:a2 - (x*12)) })
        sleep 0.5
      end
    end
  end
end