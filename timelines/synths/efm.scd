(
SynthDef(\efm_bd, {
    |
    freq=55, amp=1, gate=1, pan=0,out=0,
	sustain, dec=0.5, ramp=4.5, rampDec=0.125,
    mod=1, modFreq=0.75, modDec=0.125, modFeedback=10
    |

	var pitch=freq;

	var carrier, modulator, click, rampEnv, ampEnv, modEnv;
	var output;

	ampEnv = EnvGen.ar(Env.perc(0,dec), timeScale:sustain, doneAction: 2);
	modEnv = 1000*mod*EnvGen.ar(Env.perc(0.0,modDec));
	rampEnv = ramp*EnvGen.ar(Env.perc(0,rampDec)) + 1;

	click = Impulse.ar(0, mul:0.7);
	modulator = SinOscFB.ar(pitch*rampEnv*modFreq, modFeedback, mul:modEnv);
	carrier = SinOsc.ar(pitch*rampEnv +  modulator, mul:ampEnv, add: click);

	output = carrier*0.5;

	// Out.ar(0,
	// 	Pan2.ar(output , 0)
	// )
    OffsetOut.ar(out, DirtPan.ar(output, ~dirt.numChannels, pan, ampEnv));

}).add;



SynthDef(\efm_sd, {
	|
	freq=295, amp=1, gate=1, pan=0,out=0,
	sustain, dec=0.25, noiseLevel=0.5, noiseDec=0.15,
	mod=1, modFreq=0.5, modDec=0.3, hpf=300
	|

	var pitch=freq;
	var carrier, modulator, noise, click, rampEnv, ampEnv, modEnv, noiseEnv;
	var output;

	ampEnv = EnvGen.ar(Env.perc(0,dec), timeScale:sustain, doneAction: 2);
	modEnv = 1000*mod*EnvGen.ar(Env.perc(0.0,modDec));
	rampEnv = {EnvGen.ar(Env.perc(0,0.1), levelScale:-0.25, levelBias:1)};
	noiseEnv = noiseLevel*EnvGen.ar(Env.perc(0,noiseDec));

	noise = WhiteNoise.ar(mul: noiseEnv);
	click = Impulse.ar(0, mul:0.8);
	modulator = SinOscFB.ar(pitch*rampEnv*modFreq, 10, mul:modEnv);
	carrier = SinOsc.ar(pitch*rampEnv + modulator, mul:ampEnv, add: click);

	output = HPF.ar(carrier+noise, hpf, mul: 0.5);

	// Out.ar(0,
	// 	Pan2.ar(output , 0)
	// )
	OffsetOut.ar(out, DirtPan.ar(output, ~dirt.numChannels, pan, ampEnv));

}).add;

SynthDef(\efm_xt, {
	|
	freq=87, amp=1, gate=1, pan=0,out=0,
	sustain, dec=0.25, ramp=1.75, rampDec=0.3,
	mod=0.7, modFreq=2.75, modDec=0.25, clickLevel=1
	|

	var pitch=freq;

	var carrier, modulator, click, rampEnv, ampEnv, modEnv;
	var output;

	ampEnv = EnvGen.ar(Env.perc(0,dec), timeScale:sustain, doneAction: 2);
	modEnv = 1000*mod*EnvGen.ar(Env.perc(0.0,modDec));
	rampEnv = ramp*EnvGen.ar(Env.perc(0,rampDec)) + 1;

	click = Impulse.ar(0, mul:clickLevel);
	modulator = SinOscFB.ar(pitch*rampEnv*modFreq, 10, mul:modEnv);
	carrier = SinOsc.ar(pitch*rampEnv +  modulator, mul:ampEnv, add: click);

	output = carrier*0.5;

	// Out.ar(0,
	// 	Pan2.ar(output , 0)
	// )
	OffsetOut.ar(out, DirtPan.ar(output, ~dirt.numChannels, pan, ampEnv));

}).add;

SynthDef(\efm_cp, {
	|
	freq=1470, amp=1, gate=1, pan=0,out=0,
	sustain, dec = 0.2, clps=3, cdec=0.09,
	mod=0.25, modFreq=4.5, modDec=4, highpassFreq=150
	|
	var ptch =freq;

	var carrier, modulator, noise, claps, click, rampEnv, ampEnv, modEnv, clpEnv;
	var output;


	ampEnv = EnvGen.ar(Env.perc(0,dec), timeScale:sustain, doneAction: 2);
	modEnv = EnvGen.ar(Env.perc(0.0,modDec), levelScale: 100*mod);

	clpEnv = EnvGen.ar(Env.new([0 ,1,0,1,1],[0,cdec/clps,0,0], curve:-4), gate: Impulse.ar(clps/cdec));
	clpEnv = Gate.ar(clpEnv, Line.ar(1,0,cdec+0.001) );
	ampEnv = ampEnv*clpEnv;
	modEnv = modEnv*clpEnv;

	modulator = SinOscFB.ar(ptch*modFreq, 0, mul:modEnv);
	carrier = SinOscFB.ar(ptch, modulator, mul:ampEnv);

	output = HPF.ar(carrier, highpassFreq, mul: 0.5);

	// Out.ar(0,
	// 	Pan2.ar(output , 0)
	// )
	OffsetOut.ar(out, DirtPan.ar(output, ~dirt.numChannels, pan, ampEnv));

}).add;

SynthDef(\efm_rs, {
	|
	freq=436, amp=1, gate=1, pan=0,out=0,
	sustain, dec=0.125, mod=0.5, hpf=250,
	snar=0.25, sptc=875, sdec=0.2, smod=0.5
	|
	var ptch=freq;

	var carrier1, carrier2, modulator1, modulator2, noise, click, rampEnv, ampEnv, snarEnv, gateEnv;
	var output;

	ampEnv = EnvGen.ar(Env.perc(0,dec), timeScale:sustain);
	snarEnv = EnvGen.ar(Env.perc(0,sdec));
	gateEnv = EnvGen.ar(Env.perc(0,dec+sdec), timeScale:sustain, doneAction:2);

	modulator1 = SinOscFB.ar(ptch, 100, mul:10*mod);
	modulator2 = SinOscFB.ar(sptc, 100, mul:10*smod);
	carrier1 = SinOscFB.ar(ptch + modulator1, modulator1, mul:ampEnv);
	carrier2 = snar*SinOscFB.ar(sptc + modulator2, modulator2, mul:snarEnv);

	output = HPF.ar(carrier1+carrier2, hpf, mul: 0.4);

	// Out.ar(0,
	// 	Pan2.ar(output , 0)
	// )
	OffsetOut.ar(out, DirtPan.ar(output, ~dirt.numChannels, pan, gateEnv));

}).add;

SynthDef(\efm_cb, {
	|
	freq=392, amp=1, gate=1, pan=0,out=0,
	sustain, dec=0.23, snap=0.25, fb=0.25,
	mod=0.5, mfrq=1, mdec=0.25
	|
	var ptch=freq;
	var carrier1, carrier2, modulator1, ampEnv, modEnv, snapDecay, snapEnv;
	var output;

	//origin + amt*(dest-origin)
	snapDecay = dec + (snap*(0.0125-dec));
	ampEnv = EnvGen.ar(Env.perc(0,dec), timeScale: sustain, doneAction:2);
	snapEnv = {EnvGen.ar(Env.perc(0, snapDecay ))};
	modEnv = EnvGen.ar(Env.perc(0,dec),levelBias:10*mod);

	modulator1 = SinOscFB.ar(ptch*mfrq , fb*modEnv, mul:modEnv);
	carrier1 = SinOscFB.ar(ptch + modulator1 , fb*modEnv, mul:ampEnv);
	carrier2 = SinOscFB.ar(1.5*ptch + modulator1 , fb*modEnv, mul:snapEnv);

	output = (carrier1+carrier2)*0.15;

	// Out.ar(0,
	// 	Pan2.ar(output , 0)
	// )
	OffsetOut.ar(out, DirtPan.ar(output, ~dirt.numChannels, pan, ampEnv));

}).add;

SynthDef(\efm_hh, {
	|
	freq=554, amp=1, gate=1, pan=0,out=0,
	sustain, dec=0.05, trem=0.25, tfrq=8,
	mod=0.25, mfrq=4.5, mdec=0.5, fb=1
	|
	var ptch=freq;
	var carrier, modulator, ampEnv, modEnv, tremEnv;
	var output;

	ampEnv = EnvGen.ar(Env.perc(0,dec), timeScale:sustain, doneAction: 2);
	modEnv = EnvGen.ar(Env.perc(0,mdec), levelScale: 100*mod);

	tremEnv = EnvGen.ar(Env.new([0,0,1],[0,1/tfrq], curve:-4), gate: Impulse.ar(tfrq));
	tremEnv = (1 + (trem*(tremEnv - 1)));
	ampEnv = ampEnv*tremEnv;
	modEnv = modEnv*tremEnv;

	modulator = SinOscFB.ar(ptch*mfrq, fb, mul:modEnv);
	carrier = SinOscFB.ar(ptch + modulator, fb*modEnv, mul:ampEnv);

	output = HPF.ar(carrier, 500)* 0.35;
	output = LPF.ar(output, 17000);

	// Out.ar(0,
	// 	Pan2.ar(output , 0)
	// )
	OffsetOut.ar(out, DirtPan.ar(output, ~dirt.numChannels, pan, ampEnv));

}).add;


SynthDef(\efm_cy, {
	|
	freq=554, amp=1, gate=1, pan=0,out=0,
	sustain, dec=0.6, fb=0.4, hpf=800,
	mod=0.8, mfrq=4, mdec=0.7
	|
	var ptch=freq;
	var carrier1, carrier2, carrier3, carrier4, modulator1, modulator2, click, ampEnv, modEnv1, modEnv2, mods;
	var output;

	fb = (10*fb);

	ampEnv = EnvGen.ar(Env.perc(0,dec), timeScale:sustain, doneAction: 2);
	modEnv1 = EnvGen.ar(Env.perc(0,mdec), levelScale: (100*mod));
	modEnv2 = EnvGen.ar(Env.perc(0,0.25), levelScale: 100);

	modulator1 = SinOscFB.ar(ptch*mfrq,fb, mul:modEnv1);
	modulator2 = Pulse.ar(ptch*3, mul:modEnv2);
	mods = (modulator1 + modulator2);
	carrier1 = 0.05*SinOscFB.ar(ptch + mods, fb, mul:ampEnv);
	carrier2 = 0.25*SinOscFB.ar((ptch*1.500 + mods), fb, mul:ampEnv);
	carrier3 = 0.2*SinOscFB.ar((ptch*mfrq + mods), fb, mul:ampEnv);
	carrier4 = 0.125*SinOscFB.ar((ptch*3.00 + mods), fb, mul:ampEnv);

	click = Impulse.ar(0, mul:0.7);

	output = HPF.ar(carrier1 + carrier2 + carrier3 + carrier4 + click, hpf) * 0.3;
	output = LPF.ar(output, 17000);

	// Out.ar(0,
	// 	Pan2.ar(output , 0)
	// )
	OffsetOut.ar(out, DirtPan.ar(output, ~dirt.numChannels, pan, ampEnv));

}).add;
)
