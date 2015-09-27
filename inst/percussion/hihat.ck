public class HiHat {
	Noise fizz => ADSR fzz => HPF fzq => JCRev r1;

	.01 => r1.mix;
	.3 => fzz.gain;
	1000 => fzq.freq; // hipass filter freq

	1::second => dur T;
	T - (now % T) => now;

	fzz.set( 10::ms, 10::ms, 0.01, 250::ms );

	public void connect(UGen ugen){
		r1 => ugen;
	}

	public void trigger(){
		fzz.keyOn();
	}

	public void off(){
		fzz.keyOff();
	}
}

