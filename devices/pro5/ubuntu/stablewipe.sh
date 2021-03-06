clear
  echo ""
  echo "Flashing stable channel"
  echo ""
  sleep 1
  echo "Please enable developer mode on the device"
  echo "this is located in system-settings → About → Developer Mode"
  echo ""
  echo "Please confirm the pairing dialog on the device"
  echo ""
  sleep 1
  echo -n "Did you enable developer mode ? [Y] "; read developermode
  if [ "$developermode"==Y -o "$developermode"==y -o "$developermode"=="" ]; then
    clear
    echo ""
    echo "Detecting device"
    echo ""
    sleep 1
    adb devices >~/.AttachedDevices
  fi
    echo ""
    sleep 1
    if grep 'device$\|device$' ~/.AttachedDevices
    then
      echo ""
      echo "Device detected !"
      sleep 1
      clear
      echo ""
      echo "Flashing stable channel"
      echo ""
      adb reboot-bootloader
      echo "Please wait"
      sleep 6
      wget -c --quiet --show-progress --tries=10 http://people.ubuntu.com/~misterq/magic-device-tool/recoverys/recovery-turbo.img
      sleep 1
      clear
      echo ""
      ubuntu-device-flash touch --bootstrap --device turbo --channel ubuntu-touch/stable/meizu-pd.en --recovery-image recovery-turbo.img
      sleep 1
      echo ""
      echo "Move to your device to finish the setup."
      sleep 1
      echo ""
      echo "Cleaning up.."
      rm -f ~/.AttachedDevices
      #rm recovery-turbo.img
      echo ""
      sleep 1
      echo "Exiting script. Bye Bye"
      sleep 1
      exit
    else
      echo "Device not found"
      rm -f ~/.AttachedDevices
      sleep 1
      echo ""
      echo "Back to menu"
      sleep 1
      . ./launcher.sh
    fi
