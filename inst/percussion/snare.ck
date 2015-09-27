public class Snare {
	SinOsc snap => ADSR snp => JCRev r1;
	Noise  fizz => ADSR fzz => HPF fzq => JCRev r2;

	.05 => r1.mix;
	.05 => r2.mix;
	.5 => fzz.gain;
	.5 => snp.gain;
	20 => fzq.freq; // hipass filter freqSinOsc snap => ADSR snp => dac;

	snp.set( 1::ms, 20::ms, 0.1, 100::ms );
	fzz.set( 5::ms, 50::ms, 0.3, 100::ms );

	public void connect(UGen ugen){
		r1 => ugen;
		r2 => ugen;
	}

	public void trigger(float f){
		f => snap.freq;
		snp.keyOn();
		fzz.keyOn();
	}

	public void off(){
		snp.keyOff();
		fzz.keyOff();
	}
}
