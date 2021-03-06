clear
echo ""
echo "Flashing rc-proposed channel"
echo ""
sleep 1
echo "Please boot your E5 HD into bootloader/fastboot mode by pressing Power & Volume Up (+)"
echo "and select fastboot mode"
echo ""
sleep 1
echo -n "Is your E5 HD in bootloader/fastboot mode now? [Y] "; read bootloadermode
if [ "$bootloadermode"==Y -o "$bootloadermode"==y -o "$bootloadermode"=="" ]; then
  clear
  echo ""
  echo "Detecting device"
  echo ""
  sleep 1
  fastboot devices >~/.AttachedDevices
fi
  if grep 'device$\|fastboot$' ~/.AttachedDevices
  then
    echo "Device detected !"
    sleep 1
    clear
    echo ""
    echo "Flashing rc-proposed channel"
    echo ""
    wget -c --quiet --show-progress --tries=10 http://people.ubuntu.com/~misterq/magic-device-tool/recoverys/recovery-vegetahd.img
    echo ""
sleep 1
    fastboot flash recovery recovery-vegetahd.img
    sleep 1    
    fastboot boot recovery-vegetahd.img
    echo ""
    echo "Please wait, your device will reboot a few times"
    echo ""
    sleep 15
    adb reboot recovery
    sleep 30
    ubuntu-device-flash touch --channel ubuntu-touch/rc-proposed/bq-aquaris.en --device vegetahd
    sleep 1    
    echo ""
    echo "Move to your device to finish the setup."
    sleep 1
    echo ""
    echo "Cleaning up.."
    rm -f ~/.AttachedDevices
    #rm recovery-vegetahd.img
    echo ""
    sleep 1
    echo "Exiting script. Bye Bye"
    sleep 1
    exit
  else
    echo "Device not found"
    sleep 1
    rm -f ~/.AttachedDevices
    echo ""
    echo "Back to menu"
    sleep 1
    . ./launcher.sh
  fi
