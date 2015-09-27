public class BassDrum {
	SqrOsc snap => ADSR snp => JCRev r1;
	SinOsc snap2 => ADSR snp2 => JCRev r2;
	Noise  fizz => ADSR fzz => LPF fzq => JCRev r3;

	.05 => r1.mix;
	.05 => r2.mix;
	.05 => r3.mix;
	.3 => fzz.gain;
	.7 => snp.gain;
	.9 => snp2.gain;
	300 => fzq.freq; // lopass filter freq

	snp.set( 1::ms, 10::ms, 0.5, 250::ms );
	snp2.set( 1::ms, 50::ms, 0.7, 250::ms );
	fzz.set( 10::ms, 50::ms, 0.01, 250::ms );

	public void connect(UGen ugen){
		r1 => ugen;
		r2 => ugen;
		r3 => ugen;
	}

	public void trigger(float sn, float sn2){
		sn => snap.freq;
		sn2 => snap2.freq;

		snp.keyOn();
		snp2.keyOn();
		fzz.keyOn();
	}

	public void off(){
		snp.keyOff();
		snp2.keyOff();
		fzz.keyOff();
	}
}

