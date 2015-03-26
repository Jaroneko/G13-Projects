-- Logitech G13 script for Star Citizen 1.1.0 profile
--
-- author: Markus "Jaroneko" Räty <jaroneko at gmail dot com>
-- Copyright (c) 2015, Markus "Jaroneko" Räty
-- This code is in the Public Domain, or the BSD (3 clause) license if Public Domain does not apply
-- in your country.
--
-- ver. 20150323

eject_try_counter = 0;
eject_try = 0;

function OnEvent(event, arg, family)
  OutputLogMessage("event = %s, arg = %s, family = %s\n", event, arg, family)
  mkey = GetMKeyState("lhc")
  if (event == "G_PRESSED" and mkey == 3) then
    if (arg == 20) then
      G20_down = 1;
    end
    if (arg == 7) and (G20_down == 1) then
      if (GetRunningTime() - eject_try <= 1000) then
        if (eject_try_counter == 2) then
          PressKey("ralt","l");
          Sleep(5);
          ReleaseKey("l");
          Sleep(5);
          ReleaseKey("ralt");
          ClearLCD ();
          OutputLCDMessage("   \n                 !!!EJECT!!!    \n", 2000);
          Sleep(2000);
          SetMKeyState(1, "lhc");
          eject_try_counter = 0;
        else
          eject_try_counter = eject_try_counter + 1;
          ClearLCD();
          OutputLCDMessage("   \n        Press again to confirm    \n", 1000);
        end
      else
        eject_try_counter = 1;
        ClearLCD();
        OutputLCDMessage("   \n                     Eject?    \n", 1000);
      end
      eject_try = GetRunningTime()
    end
  end
  if (event == "G_RELEASED" and mkey == 3) then
    if (arg == 20) then
      G20_down = 0;
      eject_try_counter = 0;
      ClearLCD();
      OutputLCDMessage("",1);
    end
  end
  if (event == "M_RELEASED" and mkey == 1) then
    ClearLCD ();
    OutputLCDMessage("   \n                    Infantry    \n", 2000);
  end
  if (event == "M_RELEASED" and mkey == 2) then
    ClearLCD ();
    OutputLCDMessage("   \n                  <unused>    \n", 2000);
  end
  if (event == "M_RELEASED" and mkey == 3) then
    ClearLCD ();
    OutputLCDMessage("   \n         Flight - HUD & Power      \n", 2000);
  end
end