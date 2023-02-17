:set -XOverloadedStrings
:set -FlexibleContexts
:set prompt ""
:set -package hosc

import Sound.Tidal.Context

import System.IO (hSetEncoding, stdout, utf8)

import qualified Control.Concurrent.MVar as MV
import qualified Sound.Tidal.Tempo as Tempo
import qualified Sound.OSC.FD as O
import Sound.Tidal.Chords

import Data.List (sort, sortOn, findIndices, elemIndex, groupBy, transpose, intercalate, findIndex)
import Sound.Tidal.Utils ((!!!))

hSetEncoding stdout utf8

-- total latency = oLatency + cFrameTimespan
tidal <- startTidal (superdirtTarget {oLatency = 0.1, oAddress = "127.0.0.1", oPort = 57120}) (defaultConfig {cFrameTimespan = 1/20})


:{
let only = (hush >>)
    p = streamReplace tidal
    hush = streamHush tidal
    panic = do hush
               once $ sound "superpanic"
    list = streamList tidal
    mute = streamMute tidal
    unmute = streamUnmute tidal
    unmuteAll = streamUnmuteAll tidal
    solo = streamSolo tidal
    unsolo = streamUnsolo tidal
    once = streamOnce tidal
    first = streamFirst tidal
    asap = once
    nudgeAll = streamNudgeAll tidal
    all = streamAll tidal
    resetCycles = streamResetCycles tidal
    setcps = asap . cps
    getcps = do tempo <- MV.readMVar $ sTempoMV tidal
                return $ Tempo.cps tempo
    getnow = do tempo <- MV.readMVar $ sTempoMV tidal
                now <- O.time
                return $ fromRational $ Tempo.timeToCycles tempo now
    xfade i = transition tidal True (Sound.Tidal.Transition.xfadeIn 4) i
    xfadeIn i t = transition tidal True (Sound.Tidal.Transition.xfadeIn t) i
    histpan i t = transition tidal True (Sound.Tidal.Transition.histpan t) i
    wait i t = transition tidal True (Sound.Tidal.Transition.wait t) i
    waitT i f t = transition tidal True (Sound.Tidal.Transition.waitT f t) i
    jump i = transition tidal True (Sound.Tidal.Transition.jump) i
    jumpIn i t = transition tidal True (Sound.Tidal.Transition.jumpIn t) i
    jumpIn' i t = transition tidal True (Sound.Tidal.Transition.jumpIn' t) i
    jumpMod i t = transition tidal True (Sound.Tidal.Transition.jumpMod t) i
    mortal i lifespan release = transition tidal True (Sound.Tidal.Transition.mortal lifespan release) i
    interpolate i = transition tidal True (Sound.Tidal.Transition.interpolate) i
    interpolateIn i t = transition tidal True (Sound.Tidal.Transition.interpolateIn t) i
    clutch i = transition tidal True (Sound.Tidal.Transition.clutch) i
    clutchIn i t = transition tidal True (Sound.Tidal.Transition.clutchIn t) i
    anticipate i = transition tidal True (Sound.Tidal.Transition.anticipate) i
    anticipateIn i t = transition tidal True (Sound.Tidal.Transition.anticipateIn t) i
    forId i t = transition tidal False (Sound.Tidal.Transition.mortalOverlay t) i
    d1 = p 1 . (|< orbit 0)
    d2 = p 2 . (|< orbit 1)
    d3 = p 3 . (|< orbit 2)
    d4 = p 4 . (|< orbit 3)
    d5 = p 5 . (|< orbit 4)
    d6 = p 6 . (|< orbit 5)
    d7 = p 7 . (|< orbit 6)
    d8 = p 8 . (|< orbit 7)
    d9 = p 9 . (|< orbit 8)
    d10 = p 10 . (|< orbit 9)
    d11 = p 11 . (|< orbit 10)
    d12 = p 12 . (|< orbit 11)
    d13 = p 13
    d14 = p 14
    d15 = p 15
    d16 = p 16
:}

:{
let setI = streamSetI tidal
    setF = streamSetF tidal
    setS = streamSetS tidal
    setR = streamSetR tidal
    setB = streamSetB tidal
:}

setbpm a = setcps (a/60/4)
bpm a = cps (a/60/4)
invert p = (|* (-1)) $ p
laceWith fx p = interlace p (fx p)
condFx bools fx p = sew bools (fx p) p
mute = (const silence)
m = (const silence)
ie a b = inside a (every (round <$> a) (b)) 
sendMidiClock = p "clock" $ fast 2 $ midicmd "midiClock*48" #s "midi";
sendMidiStop = once $ midicmd "stop" #s "midi"
sendMidiStart = once $ midicmd "stop" #s "midi"



:{
createMappingEvents :: Num a => [Event a] -> [Event (Int -> a)]
createMappingEvents [] = []
createMappingEvents ch = [
  Event { context = context$head ch,  
          whole = whole$head ch,
          part = part$head ch,
          value = noteInScale (fmap eventValue ch)
          }
  ]
  where octave s x = x `div` length s
        noteInScale s x = (s !!! x) + fromIntegral (12 * octave s x)

fingerpick :: Num a => Pattern a -> Pattern Int -> Pattern a 
fingerpick ch p = withEvents munge ch Sound.Tidal.Context.*> p
  where munge es = concatMap (createMappingEvents) (groupBy (\a b -> whole a == whole b) $ sortOn whole es)
:}

:{
eventInversion :: Num a => Int -> [Event a] -> [Event a]
eventInversion _ [] = []
eventInversion n xs = drop n xs ++ (fmap (fmap (+12)) $ take n xs )

withFriends :: ([Event a] -> [Event b]) -> Pattern a -> Pattern b
withFriends f pat = withEvents munge pat
  where munge es = concatMap (f) (groupBy (\a b -> whole a == whole b) $ sortOn whole es)

inv :: Num b => Int -> Pattern b -> Pattern b
inv = withFriends . eventInversion

one p = stut' 2 (0.125/2) (|* gain "1") $ p



:}



:set prompt "tidal> "
:set prompt-cont ""
