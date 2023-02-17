// (
//   SynthDef(\plaits, {|out=0,freq=440,sustain=1,pan=0,begin=0,end=1,speed=1,accelerate=0,
//       timbre=0.5,engine=0,harm=0.5,morph=0.5,level=1,lpgdecay=0,lpgcolour=0|
//     var envLength = sustain*(end-begin)/speed;
//     var line = Line.ar(begin, end, envLength, doneAction: Done.freeSelf);
//     var env = Env.asr;
//     var volume = IEnvGen.ar(env, line);
//     var sig;

//     freq = freq * DirtFreqScale.kr(speed, accelerate, sustain);
//     sig = MiPlaits.ar(
//       pitch: freq.cpsmidi,
//       timbre: timbre,
//       harm: harm,
//       engine: engine,
//       morph: morph,
//       level: level,
//       decay: lpgdecay,
//       lpg_colour: lpgcolour,
//     );

//     Out.ar(out, DirtPan.ar(sig * volume, ~dirt.numChannels, pan));
//   }).add;
// );