clear
adb start-server
clear
echo ""
echo "Flashing rc-proposed channel"
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
    echo "Flashing rc-proposed channel"
    echo ""
    adb reboot-bootloader
    echo "Please wait"
    echo ""
    sleep 7
    wget -c --quiet --show-progress --tries=10 http://people.ubuntu.com/~misterq/magic-device-tool/recoverys/recovery-frieza.img
    sleep 1
    fastboot flash recovery recovery-frieza.img
    sleep 1
    fastboot boot recovery-frieza.img
    sleep 10
    adb reboot recovery
    sleep 17
    clear
    echo ""
    ubuntu-device-flash touch --device frieza --channel ubuntu-touch/rc-proposed/bq-aquaris-pd.en
    sleep 1
    echo ""
    echo "Move to your device to finish the setup."
    sleep 1
    echo ""
    echo "Cleaning up.."
    rm -f ~/.AttachedDevices
    #rm recovery-frieza.img
    echo ""
    sleep 1
    echo "Exiting script. Bye Bye"
    sleep 1
    exit
  else
    echo "Device not found"
    echo ""
    rm -f ~/.AttachedDevices
    sleep 1
    echo "Back to menu"
  sleep 1
  . ./launcher.sh
  fi
