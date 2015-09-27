public class Metronome {
	500 => float delay;
	Event e;

	fun static float bpm2ms(float bpm){
		(60/bpm)*1000 => float res;
		<<<"new delay", bpm, res>>>;
		return res;
	}

	fun void setbpm(int bpm){
		bpm2ms(bpm) => delay;
	}

	fun void setms(int millis){
		millis => delay;
	}

	fun void loop(){
		while(true){
			<<<"metronome tick", delay, "ms", now>>>;
			delay::ms => now;
			e.broadcast();
		}
	}
}

