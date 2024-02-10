##############################################
## Example 1 - play a note
play 60


##############################################
## Example 2 - play 4 random notes
4.times do
  play rrand_i(60, 90)
  sleep 0.5
end


##############################################
## Example 3 - play a major chord
play chord(60, :M)


##############################################
## Example 4 - play an arpeggio
loop do
  play chord(60, :M7).tick
  sleep 0.5
end


##############################################
## Example 5 - play a chord with an arpeggio
loop do
  play chord(60, :M7), release: 3
  16.times do
    play chord(60, :M7).choose
    sleep 0.25
  end
end


##############################################
## Example 6 - play a shifting chord with an arpeggio
start_notes = ring(60, 62, 63, 62)
loop do
  my_chord = chord(start_notes.tick, :M7)
  play my_chord, release: 2
  16.times do
    play my_chord.choose
    sleep 0.125
  end
end


##############################################
## Example 7 - play a sample
sample :drum_bass_hard


##############################################
## Example 8 - play a simple drum beat
loop do
  sample :bd_haus
  sleep 0.5
end


##############################################
## Example 9 - alternate kick and snare
loop do
  if tick.even?
    sample :bd_haus
  else
    sample :sn_dolf
  end
  sleep 0.5
end


##############################################
## Example 10 - combine kick, snare and hi-hat
loop do
  sample :drum_cymbal_closed
  if tick.even?
    sample :bd_haus
  else
    sample :sn_dolf
  end
  sleep 0.25
  sample :drum_cymbal_closed
  sleep 0.25
end


##############################################
## Example 11 - play a drum loop once
sample :loop_amen


##############################################
## Example 12 - play a drum loop as a loop
loop do
  sample :loop_amen
  sleep sample_duration(:loop_amen)
end


##############################################
## Example 13 - try to combine melody, harmony, rhythm (doesn't work)
loop do
  start_note = ring(60, 62, 63, 62).tick
  my_chord = chord(start_note, :M7)
  play my_chord, release: 2
  16.times do
    play my_chord.choose, release: 0.25, amp: [0.75, 0.5, 0.25].choose
    sleep 0.125
  end
end

loop do
  sample :loop_amen
  sleep sample_duration(:loop_amen)
end


##############################################
## Example 14 - a fix for Example 13, using threads (drums out of sync)
in_thread do
  loop do
    start_note = ring(60, 62, 63, 62).tick
    my_chord = chord(start_note, :M7)
    play my_chord, release: 2
    16.times do
      play my_chord.choose, release: 0.25, amp: [0.75, 0.5, 0.25].choose
      sleep 0.125
    end
  end
end

loop do
  sample :loop_amen
  sleep sample_duration(:loop_amen)
end


##############################################
## Example 15 - a fix for Example 14, drums now in sync
in_thread do
  loop do
    start_note = ring(60, 62, 63, 62).tick
    my_chord = chord(start_note, :M7)
    play my_chord, release: 2
    16.times do
      play my_chord.choose, release: 0.25, amp: [0.75, 0.5, 0.25].choose
      sleep 0.125
    end
  end
end

loop do
  sample :loop_amen, beat_stretch: 2
  sleep 2
end


##############################################
## Example 16 - a better way to thread
live_loop :beeps do
  start_note = ring(60, 62, 63, 62).tick
  my_chord = chord(start_note, :M7)
  play my_chord, release: 2
  16.times do
    play my_chord.choose, release: 0.25, amp: [0.75, 0.5, 0.25].choose
    sleep 0.125
  end
end

live_loop :drums do
  sample :loop_amen, beat_stretch: 2
  sleep 2
end


##############################################
## Example 17 - use a different synth
use_synth :saw
loop do
  play scale(60, :major).choose
  sleep 0.25
end


##############################################
## Example 18 - a simple pattern to demo effects
play 50
sleep 0.5
sample :elec_plip
sleep 0.5
play 62


##############################################
## Example 19 - adding reverb
with_fx :reverb do
  play 50
  sleep 0.5
  sample :elec_plip
  sleep 0.5
  play 62
end


##############################################
## Example 20 - adding echo
with_fx :echo do
  play 50
  sleep 0.5
  sample :elec_plip
  sleep 0.5
  play 62
end


##############################################
## Example 21 - adding reverb and echo together
with_fx :echo do
  with_fx :reverb do
    play 50
    sleep 0.5
    sample :elec_plip
    sleep 0.5
    play 62
  end
end
