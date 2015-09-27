public class Seq {
	// our patch
	SqrOsc s => DelayA d => JCRev r;

	// initialize
	.25 => r.mix;

	0 => int octave;
	0 => int step;

	// scale (pentatonic; in semitones)
	[ 0, 2, 4, 7, 9 ] @=> int scale[];

	public void connect(UGen ugen){
		r => ugen;
	}

	public void setup(float oscwidth, float delay){
		oscwidth => s.width;
	}

	public void trigger(int stepcount, int midibase){
		0.05 => s.gain;
		// pick something from the scale
		scale[Std.rand2(0,4) ] => float freq;
		// get the final freq
		Std.mtof(midibase + octave*12 + freq) => s.freq;
		// reset phase for extra bandwidth
		0 => s.phase;

		step + 1 => step;
		if(step >= stepcount){
			0 => step;
			Std.rand2(0,1) => octave;
		}
	}

	public void loop(Event e, int stepcount, int midibase){
		while(true){
			e => now;
			trigger(stepcount, midibase);
		}
	}

	// within octave- (n+Math.random(-4,4))%12 + octave*12 + offset

	public void off(){
		0. => s.gain;
	}
}

