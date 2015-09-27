public class PMsynth {
	// basic FM synthesis using sinosc

	// modulator to carrier	 
	SinOsc m => SinOsc c => ADSR env;

	0.25 => env.gain;

	// phase modulation is FM synthesis (sync is 2)
	2 => c.sync;

	env.set( 300::ms, 300::ms, 0.2, 1000::ms );

	public void connect(UGen ugen){
		env => ugen;
	};

	fun void trigger (float cfreq, float mfreq, float mgain) {
		// carrier frequency
		cfreq => c.freq;

		// modulator frequency
		mfreq => m.freq;

		// index of modulation
		mgain => m.gain;

		env.keyOn(1);
	};

	fun void off () {
	    env.keyOff(1);
	};

};
