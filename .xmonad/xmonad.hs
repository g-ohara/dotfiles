import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Util.EZConfig (additionalKeysP)

main :: IO ()
main = xmonad =<< xmobar (def `additionalKeysP` myKeys)
 where
  myKeys =
    [ ("<Print>", spawn "maim -s | xclip -selection clipboard -t image/png")
    ]
