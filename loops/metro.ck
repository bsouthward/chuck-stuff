.5::second => dur T;
// synchronize to period (for on-the-fly synchronization)
T - (now % T) => now;

Metronome m;

m.setbpm(240);

spork ~ m.loop();

Gain g1 => dac;
0.5 => g1.gain;

Seq seq;
seq.off();
seq.setup(0.5, 0.5);
//seq.connect(g1);

spork ~ seq.loop(m.e, 8, 57);

Seq seq2;
seq2.off();
seq2.setup(0.5, 0.75);
seq2.connect(dac);

spork ~ seq2.loop(m.e, 4, 33);

while(true){
	m.e => now;
}

