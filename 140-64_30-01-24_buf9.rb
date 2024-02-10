sampledir = "C:/Users/lemin/Music/G6_Looper/"

sample1 = sampledir+"01-24_L107_140_64.wav"
sample2 = sampledir+"01-24_L108_70_32.wav"
use_bpm 140

sample sample1, amp: 2
4.times do
  4.times do
    density 1 do
      4.times do |x|
        sample :drum_bass_hard
        density 4 do |y|
          sample :drum_cymbal_closed, amp: (x==0 ? 0.5 : 0.35), on: !(x==3 && y==0), rate: 2
          sleep 1
        end
      end
    end
  end
end