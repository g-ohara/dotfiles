import XMonad
import XMonad.Util.EZConfig (additionalKeysP)

main :: IO ()
main = xmonad $ def `additionalKeysP` myKeys
 where
  myKeys =
    [ ("<Print>", spawn "maim -s | xclip -selection clipboard -t image/png")
    ]
