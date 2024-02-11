use_bpm 95
sampledir = "C:/Users/lemin/Music/Sonic Pi/G6_Looper/"
gitsamp = sampledir + "1102_95_32_112.wav"
st = sample gitsamp, amp: 0, rate: 2, amp_slide: 8
st.control ({amp: 0.75, start: 0.75})
sleep 16
live_loop :drum do
  in_thread do
    dns = 2
    density dns do
      with_fx :reverb do
        sample gitsamp, rate: dns, amp: 0.75
        sleep 32
      end
    end
  end
  density 1 do
    2.times do
      4.times do |y|
        4.times do |x|
          sample ( x==0 && (y%2)==0 ? :drum_cymbal_open : :drum_cymbal_closed)
          sample :drum_bass_hard
          sleep 0.25
          sample :drum_bass_hard, on: (x%2)==0
          sample :drum_cymbal_closed
          sleep 0.25
          sample :drum_bass_soft, on: x==2
          sample :drum_cymbal_closed, on: !(x%2)==0
          sleep 0.25
          sample :drum_cymbal_closed, on: (y%2)==0
          sleep 0.25
        end
      end
    end
  end
end