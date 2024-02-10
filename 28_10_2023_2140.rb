sample_free_all
use_bpm 142
set_recording_bit_depth! 24
hbd = :drum_bass_hard
dhh = :hat_gnu
hsn = :drum_snare_hard
load_sample hbd
load_sample dhh
load_sample hsn
grp = sample_names :hat
for x in grp
  puts x
end

sampledir = "C:/Users/lemin/Music/G6_Looper/G6_Looper/"
samplelist = [ "054_142_32.wav" ]
samp1 = sampledir+samplelist[0]
load_sample samp1
panr = stretch([0.25, -0.25, 0.5, -0.5], 2)

# /////////////////////////////////////////////////////
2.times do
  in_thread do
    with_fx :ping_pong do
      sample samp1
    end
    32.times do |m|
      m = (m+1)%4
      if m==0
        density 2 do |n|
          sample dhh, finish: (n==0 ? 0.9 : 0.5), amp: (n==0 ? 0.8 : 0.5 ), pan: (n==0 ? panr.tick : panr.look)
          sleep 1
        end
      else
        sample dhh, amp: 0.8, pan: panr.tick
        sleep 0.5
        sample dhh, amp: 0.4, pan: panr.tick
        sleep 0.25
        sample dhh, amp: 0.4, pan: panr.tick
        sleep 0.25
      end
    end
  end
  2.times do
    2.times do
      4.times do |i|
        i = (i+1)%2
        density i+1 do
          sample hbd
          sleep 1
        end
        sample hsn, pan: -0.1
        sleep 1
      end
    end
  end
end