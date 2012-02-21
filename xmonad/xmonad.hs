import XMonad
import qualified XMonad.StackSet as W
import XMonad.ManageHook
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Scratchpad
import XMonad.Layout
import XMonad.Layout.NoBorders
import XMonad.Layout.Accordion
import XMonad.Layout.Tabbed
import XMonad.Layout.Decoration
import XMonad.Actions.CycleRecentWS
import XMonad.Actions.CycleWS
import XMonad.Util.Themes
import XMonad.Layout.DecorationMadness
import System.IO
import XMonad.Layout.SimpleDecoration

main = do din <- spawnPipe statusBarCmd
          xmonad $ defaultConfig
	               { manageHook         = myManageHook <+> manageHook defaultConfig
                   , layoutHook         = myLayout
                   , workspaces         = myWorkspaces
                   , logHook            = dynamicLogWithPP $ myPP din
                   , modMask            = mod4Mask
	               , normalBorderColor  = "#000000"
	               , focusedBorderColor = paleGreen
	               , borderWidth 	    = 0
	               , terminal           = "urxvt"
                   } `additionalKeys`   myKeys


-- statusBarCmd= "dzen2 -bg '#1a1a1a' -fg '#ffffff' -h 12 -w 480 -sa c -e '' -ta l -fn -*-*-*-*-*-*-12-*-*-*-*-*-iso10646-1"
statusBarCmd= ""
-- dmenuCmd= "dmenu_run -nb '#1a1a1a' -nf '#ffffff' -sb '#aecf96' -sf black -p '>' -fn -*-*-*-*-*-*-10-*-*-*-*-*-iso10646-1"
dmenuCmd= "dmenu_run -fn -*-*-*-*-*-*-10-*-*-*-*-*-iso10646-1"

-- Colours
darkGray= "#1a1a1a"
lightGray= "#ffffff"
paleGreen= "#AECF96"


myManageHook = composeAll
    [ className =? "Gimp"       --> doFloat
    , className =? "feh"        --> doCenterFloat
    , scratchpadManageHook (W.RationalRect 0.325 0.6 0.641 0.35)
    --, isFullscreen              --> doFloat
--  , manageDocks
    ]

myWorkspaces =  map show [1..9]

myKeys =
    [ ((mod4Mask,        xK_F2),            spawn "xlock -mode life -size 10")
    , ((mod4Mask,	     xK_F4),	        spawn "sudo s2ram")
    , ((controlMask,     xK_Print),         spawn "sleep 0.2; scrot -s")
    , ((0,               xK_Print),         spawn "scrot")
    , ((0,               0x1008ff13),       spawn "amixer -c0 set Master 2dB+")
    , ((0,               0x1008ff11),       spawn "amixer -c0 set Master 2dB-")
    , ((0,      	     0x1008ff12),       spawn "amixer -c0 set Master toggle")
    , ((mod4Mask,	     xK_p),             spawn dmenuCmd)
    , ((mod4Mask,        xK_grave),         scratchpadSpawnActionTerminal "urxvt +sb")
    , ((mod4Mask,	     xK_Down),	        spawn "mocp -G")
    , ((mod4Mask,	     xK_Up),	        spawn "mocp -s")
    , ((mod4Mask,	     xK_Right),	        spawn "mocp -f")
    , ((mod4Mask,	     xK_Left),	        spawn "mocp -r")
    , ((mod4Mask,	     xK_n),		        nextWS)
    , ((mod4Mask,	     xK_b),		        prevWS)
    , ((mod1Mask,	     xK_Tab),	        cycleRecentWS [xK_Alt_L] xK_Tab xK_grave)
    ]

-- Theme for the tabbed layout.
newTheme :: ThemeInfo
newTheme = TI "" "" "" defaultTheme

efsTheme :: ThemeInfo
efsTheme =
    newTheme { themeName        = "efsTheme"
             , themeAuthor      = "Emil Svansø"
             , themeDescription = "Small decorations, black and pale green"
             , theme            = defaultTheme { activeColor         = paleGreen
                                               , inactiveColor       = darkGray
                                               , activeBorderColor   = paleGreen
                                               , inactiveBorderColor = darkGray
                                               , activeTextColor     = darkGray
                                               , inactiveTextColor   = lightGray
                                               , decoHeight          = 12
                                               }
			  }
smallTheme :: ThemeInfo
smallTheme =
    newTheme { themeName        = "smallTheme"
             , themeAuthor      = "Emil Svansø"
             , themeDescription = "Very minimal theme"
             , theme            = defaultTheme { activeColor         = paleGreen
                                               , inactiveColor       = darkGray
                                               , activeBorderColor   = paleGreen
                                               , inactiveBorderColor = darkGray
                                               , activeTextColor     = paleGreen
                                               , inactiveTextColor   = darkGray
                                               , decoHeight          = 2
                                               }
			  }
 
-- Layouts
--myLayout = smartBorders (avoidStruts (tallDefault shrinkText (theme smallTheme)
--                                  ||| tabbed shrinkText (theme efsTheme)
--                                  ||| Full))

myLayout = smartBorders (Full ||| (tallDefault shrinkText (theme smallTheme)))

--     where
--        tiled = Tall 1 (3/100) (1/2)

-- Pretty print for dzen
myPP h = defaultPP
                 { ppCurrent = dzenColor "black" "#aecf96" -- . dropNumbers
				 , ppHidden  = dzenColor "" "" -- . dropNumbers
				 , ppSep     = " ^r(3x3) "
				 -- Replace layout name with an icon:
				 , ppLayout  = dzenColor "white" "" .
				               (\x -> case x of
									  "DefaultDecoration Tall" 	-> "^i(.xmonad/icons/tall.xbm)"
									  "Tabbed Simplest"         -> "^i(.xmonad/icons/tabbed.xbm)"
									  "Mirror Tall"  	        -> "^i(.xmonad/icons/mirror_tall.xbm)"
									  "Full"	     	        -> "^i(.xmonad/icons/full.xbm)"
									  "Accordion"    	        -> "^i(.xmonad/icons/accordion.xbm)"
				 			   )
			 	 , ppTitle   = dzenColor "aecf96" ""
				 , ppOutput  = hPutStrLn h
				 }
