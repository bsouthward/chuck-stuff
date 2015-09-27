1::second => dur T;
T - (now % T) => now;

Metronome m;
m.setbpm(240);
spork ~ m.loop();

Gain g => dac;
0.5 => g.gain;

spork ~ hihat();
spork ~ snare();
//spork ~ bass();

while(true){
	100::ms => now;
};

fun void pmsynth() {
	PMsynth pm;
	pm.connect(g);
	[ 64, 71, 79 ] @=> int scale[];
	while(true){
		m.e => now;
		pm.trigger(Std.mtof(scale[Math.random2(0, 2)]),220.0,440.0);
		.50::T => now;
		pm.off();
	};
};

fun void hihat(){
	HiHat hh;
	hh.connect(g);
	while(true){
		m.e => now;
		hh.trigger();
		.125::T => now;
		hh.off();
		.25::T => now;
	};
};

fun void snare(){
	Snare sn;
	sn.connect(g);
	while(true){
		.25::T => now;
		sn.trigger(200);
		.25::T => now;
		sn.off();
		m.e => now;
		//sn.trigger(200);
		//sn.off();
	}
}

fun void bass(){
	BassDrum bd;
	0 => int toggle;
	bd.connect(g);
	while(true){
		m.e => now;
		if(toggle++ > 1){
			0 => toggle;
			bd.trigger(20, 30);
			.15::T  => now;
			bd.off();
		}
	};
};

