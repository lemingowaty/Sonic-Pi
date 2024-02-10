use_bpm 60

def play_snr
  sample :sn_generic
  sleep 1
end

def play_bdr
  sample :drum_bass_hard
  sleep 1
end


def hhpata1
  density 2 do
    4.times do |x|
      sample :drum_cymbal_closed, beat_stretch: 0.5
      2.times do |y|
        sample :drum_cymbal_soft, beat_stretch: 2, finish: 0.25, on: y==1
        sleep 0.25
        sample :drum_cymbal_closed, beat_stretch: 0.5, on: y==1&&(x>1)
        sleep 0.25
        sample :drum_cymbal_closed, beat_stretch: 0.55, on: y==1
        density 2 do |z|
          sample :drum_cymbal_closed, on: y==1&&z==1, beat_stretch: 0.5
          sample :drum_cymbal_soft, beat_stretch: 2, finish: 0.25
          sleep 0.5
        end
      end
    end
  end
end

def bdpata1
  
  4.times do |x|
    xmod = (x%2) == 0 ? true : false
    4.times do |y|
      sample :drum_bass_hard
      sleep 0.25
      sample :drum_bass_soft, on: (xmod)&&y==1
      sleep 0.25
    end
  end
  
end

def drumpata
  4.times do |x|
    xmod = (x%2)==0
    xbig = ( x < 2 ? xmod : !xmod)
    in_thread do
      bdpata1
    end
    in_thread do
      hhpata1
    end
    density 2 do |y|
      2.times do  |z|
        sleep 2.5
        sample :sn_generic
        sleep 0.25
        sample :sn_generic, on: z==0
        sleep 0.25
        sample :sn_generic, on: z==1&&y==1&&x==3
        density (z+1) do
          sleep 1
          sample :sn_generic, on: ( xbig && y==1 )
        end
      end
    end
  end
end

def drumpatb
  
  4.times do |x|
    xmod = (x%2)==0
    xbig = ( x < 2 ? xmod : !xmod)
    in_thread do
      bdpata1
    end
    in_thread do
      hhpata1
    end
    
    density 2 do |y|
      2.times do  |z|
        sleep 2
        sample :sn_generic, on: y==1&&z==0&&xbig
        sleep 0.5
        sample :sn_generic
        sleep 0.25
        density (z+1) do
          sample :sn_generic, on: z==0
          sleep 0.25
        end
        #// 3 6
        density (z+1) do
          sleep 1
          sample :sn_generic, on: ( xbig && y==1 )
        end
        #// 4 8
      end
    end
  end
  
end

def snarepass
  4.times do
    play_snr
  end
  2.times do
    density 2 do
      play_snr
    end
  end
  2.times do
    density 4 do
      play_snr
    end
  end
end

def bdrpass
  4.times do
    play_bdr
  end
  2.times do
    density 2 do
      play_bdr
    end
  end
  2.times do
    density 4 do
      play_bdr
    end
  end
end


live_loop :mel1, sync: :start do
  use_synth :blade
  4.times do
    4.times do |j|
      sample :ambi_lunar_land, beat_stretch: (j%2==0 ? 4 : 2)
      x = ring( :e3, :d3, :a2, :a2 ).tick
      x = chord(x, :M)
      with_fx :tanh, krunch: 10 do
        density ring(4,8,8,16,16,16,8,16).look do |i|
          if x == :a2
            play x, release: 16
          else
            play x, release: 8
          end
          sleep 4
        end
      end
    end
  end
end

live_loop :drbeat1, sync: :start do
  
  drumpata
  snarepass
  drumpatb
  bdrpass
end
hhpata1
cue :start