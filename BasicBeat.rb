# Welcome to Sonic Pi
$bd = :drum_bass_hard
$sn = :sn_generic
use_bpm 60

def hihatpat1
  4.times do |j|
    density 2 do
      4.times do |i|
        sample :drum_cymbal_closed, on: i==0||i==2
        sample :drum_cymbal_closed, attack: (i==0 ? 0.125 : 0.075), amp: (i==0 ? 1 : 0.75)
        sleep 1
      end
    end
  end
end

def beat1
  4.times do |j|
    4.times do |i|
      sample $bd, on: (  ( j==0 and (i==0||i==1) )||( j==1 and (i==0||i==1||i==3) )||( j==2 and (i==0||i==3) )||( (j==3) and (i==1 || i==3) )  )
      sample $sn, on: i==2
      sleep 1
    end
  end
end
def beat2
  4.times do |j|
    4.times do |i|
      sample $bd, on: (((j==0 or j==2) and (i==0||i==1))||(j%2==1 and i==1)||(j%2==1 and i==3)||((j==3 or j==2) and (i==1 or i==0 or i==3)))
      sample $sn, on: i==2
      sleep 1
    end
  end
end


live_loop :drum do
  ##| puts look
  tick
  puts look
  density 4 do |k|
    in_thread do
      hihatpat1
    end
    if (k%2)==0
      puts "beat1"
      beat1
    else
      puts "beat2"
      beat2
    end
    
  end
end
