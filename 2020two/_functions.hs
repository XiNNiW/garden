import Sound.Tidal.Context
   
--import System.IO (hSetEncoding, stdout, utf8)
   
--import qualified Control.Concurrent.MVar as MV
import qualified Sound.Tidal.Tempo as Tempo
--import qualified Sound.OSC.FD as O
import Sound.Tidal.Chords
   
import Data.List (sort, sortOn, findIndices, elemIndex, groupBy, transpose, intercalate, findIndex)
import Sound.Tidal.Utils ((!!!))

--module Custom ( 
--   fingerpick 
--) where
:{

setbpm a = setcps (a/60/4)
bpm a = cps (a/60/4)

divOctave :: (Num a, Integral b) => [a] -> b -> b
divOctave s x = x `div` (fromIntegral $ length s)

noteInScale :: (Num a, Integral b) => [a] -> b -> a
noteInScale sc x = (sc !!! (fromIntegral x)) + fromIntegral (12 * divOctave sc x)

createMappingEvents :: (Num a, Integral b)=> [Event a] -> [Event (b -> a)]
createMappingEvents [] = []
createMappingEvents ch = [
    Event { context = context$head ch,  
            whole = whole$head ch,
            part = part$head ch,
            value = noteInScale (fmap eventValue ch)
            }
    ]
--    where octave s x = x `div` length s
--          noteInScale s x = (s !!! x) + fromIntegral (12 * octave s x)
   
fingerpick :: (Num a, Integral b) => Pattern a -> Pattern b -> Pattern a 
fingerpick ch p = withEvents munge ch Sound.Tidal.Context.*> p
    where munge es = concatMap (createMappingEvents) (groupBy (\a b -> whole a == whole b) $ sortOn whole es)
:}
