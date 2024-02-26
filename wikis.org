* Arch linux wikis

** ip camera as webcam
sudo modprobe v4l2loopbak-dkms 

** autoenable bluetooth

# edit /etc/bluetooth/main.conf in section Policy
[Policy]
AutoEnable=true

** Ryzen 5 Problem
Freeze on shutdown, reboot and suspend
Note: With the latest AGESA firmware version 1.2.0.2 this problem might no longer occur.
This seems to be related to the C6 c-state, that does not seem to be well supported (if at all) in Linux.

To fix this issue, go into your BIOS settings for your motherboard and search for an option labeled something like this: "Power idle control". Change its value to "Typical current idle". Note that these names are dependent on what the motherboard manufacturer calls them, so they may be a little different in your particular case.

Other less ideal solutions include disabling c-states in the BIOS or adding processor.max_cstate=1 to your kernel command line arguments.

** impresora Brother HL-1212W en Arch

For network printers, use ipp://printer_ip/ipp/port1 as printer address.
cambiar la direccion de la impresora en el gui del DE por la indicada arriba usando la IP de la impresora, (192.168.0.7)


You can edit /etc/cups/printers.conf

In a terminal:
sudo systemctl stop cups

sudo vi /etc/cups/printers.conf - (or the text editor of your choice, I chose vi.)

locate the printer's URI (in bold below), it will be among all of your printers' profiles, they are arranged within tags like:

    <Printer My Poop Laser Printer>
    PrinterId 1
    UUID urn:uuid:c41ca0c7-52f3-3448-5dfe-11281fc3ac2e
    AuthInfoRequired none
    Info
    Location
    MakeModel Generic IPP Everywhere Printer
    DeviceURI ipp://192.168.200.2/printers/laser
    State Idle
    .
    .
    </Printer>

You can edit the IP there, save it.
And then restart cups...

sudo systemctl restart cups

* creating 7z encypted file

7z a \
  -t7z -m0=lzma2 -mx=9 -mfb=64 \
  -md=32m -ms=on -mhe=on -p'eat_my_shorts' \
   archive.7z dir1
