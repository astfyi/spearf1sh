
Requirements
============
---

Running J-Link/ Flasher software using J-Link or Flasher via USB with standard user rights
=========================================================================
In order to run J-Link/ Flasher software with standard user rights you have to do the following:

- Copy the file "99-jlink.rules" provided with this software package 
  in the /etc/udev/rules.d/ directory using this command:
  
  sudo cp 99-jlink.rules /etc/udev/rules.d/
  
  Note: For older systems it might be necessary to replace the "ATTRS" calls in the 99-jlink.rules by "SYSFS" calls

- Either restart your system or manually trigger the new rules with the following commands:

  sudo udevadm control -R
  sudo udevadm trigger --action=remove --attr-match=idVendor=1366 --subsystem-match=usb
  sudo udevadm trigger --action=add    --attr-match=idVendor=1366 --subsystem-match=usb
