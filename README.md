# vm

## Ubuntu 20.04

### freshly installed system

```
yy@ryzen:~$ dmesg | grep -i -e DMAR -e IOMMU
[    0.718707] iommu: Default domain type: Translated 
[    0.810743] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters supported
[    0.811098] pci 0000:00:01.0: Adding to iommu group 0
[    0.811324] pci 0000:00:01.1: Adding to iommu group 1
[    0.811474] pci 0000:00:01.2: Adding to iommu group 2
[    0.811626] pci 0000:00:02.0: Adding to iommu group 3
[    0.811744] pci 0000:00:03.0: Adding to iommu group 4
[    0.811898] pci 0000:00:03.1: Adding to iommu group 5
[    0.812012] pci 0000:00:04.0: Adding to iommu group 6
[    0.812166] pci 0000:00:05.0: Adding to iommu group 7
[    0.812281] pci 0000:00:07.0: Adding to iommu group 8
[    0.812442] pci 0000:00:07.1: Adding to iommu group 9
[    0.812561] pci 0000:00:08.0: Adding to iommu group 10
[    0.812720] pci 0000:00:08.1: Adding to iommu group 11
[    0.812837] pci 0000:00:14.0: Adding to iommu group 12
[    0.812855] pci 0000:00:14.3: Adding to iommu group 12
[    0.813024] pci 0000:00:18.0: Adding to iommu group 13
[    0.813041] pci 0000:00:18.1: Adding to iommu group 13
[    0.813058] pci 0000:00:18.2: Adding to iommu group 13
[    0.813074] pci 0000:00:18.3: Adding to iommu group 13
[    0.813091] pci 0000:00:18.4: Adding to iommu group 13
[    0.813107] pci 0000:00:18.5: Adding to iommu group 13
[    0.813123] pci 0000:00:18.6: Adding to iommu group 13
[    0.813140] pci 0000:00:18.7: Adding to iommu group 13
[    0.813255] pci 0000:01:00.0: Adding to iommu group 14
[    0.813419] pci 0000:20:00.0: Adding to iommu group 15
[    0.813589] pci 0000:21:02.0: Adding to iommu group 16
[    0.813799] pci 0000:21:04.0: Adding to iommu group 17
[    0.813964] pci 0000:21:05.0: Adding to iommu group 18
[    0.814175] pci 0000:21:06.0: Adding to iommu group 19
[    0.814304] pci 0000:21:08.0: Adding to iommu group 20
[    0.814474] pci 0000:21:09.0: Adding to iommu group 21
[    0.814632] pci 0000:21:0a.0: Adding to iommu group 22
[    0.814797] pci 0000:24:00.0: Adding to iommu group 23
[    0.814863] pci 0000:24:00.1: Adding to iommu group 23
[    0.815059] pci 0000:26:00.0: Adding to iommu group 24
[    0.815272] pci 0000:27:00.0: Adding to iommu group 25
[    0.815471] pci 0000:28:00.0: Adding to iommu group 26
[    0.815497] pci 0000:2a:00.0: Adding to iommu group 20
[    0.815528] pci 0000:2a:00.1: Adding to iommu group 20
[    0.815553] pci 0000:2a:00.3: Adding to iommu group 20
[    0.815579] pci 0000:2b:00.0: Adding to iommu group 21
[    0.815605] pci 0000:2c:00.0: Adding to iommu group 22
[    0.815749] pci 0000:2d:00.0: Adding to iommu group 27
[    0.815778] pci 0000:2d:00.0: Using iommu direct mapping
[    0.815807] pci 0000:2d:00.1: Adding to iommu group 27
[    0.815865] pci 0000:2e:00.0: Adding to iommu group 28
[    0.816022] pci 0000:2f:00.0: Adding to iommu group 29
[    0.816137] pci 0000:2f:00.3: Adding to iommu group 30
[    0.816316] pci 0000:2f:00.4: Adding to iommu group 31
[    0.816512] pci 0000:00:00.2: AMD-Vi: Found IOMMU cap 0x40
[    0.817702] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/bank).
[    3.234267] AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
```

```
yy@ryzen:~$ for g in /sys/kernel/iommu_groups/*; do
     echo "IOMMU Group ${g##*/}:"
     for d in $g/devices/*; do
         echo -e "\t$(lspci -nns ${d##*/})"
     done;
 done;
IOMMU Group 0:
	00:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU Group 1:
	00:01.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse GPP Bridge [1022:1483]
IOMMU Group 10:
	00:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU Group 11:
	00:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B] [1022:1484]
IOMMU Group 12:
	00:14.0 SMBus [0c05]: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller [1022:790b] (rev 61)
	00:14.3 ISA bridge [0601]: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge [1022:790e] (rev 51)
IOMMU Group 13:
	00:18.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Matisse Device 24: Function 0 [1022:1440]
	00:18.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Matisse Device 24: Function 1 [1022:1441]
	00:18.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Matisse Device 24: Function 2 [1022:1442]
	00:18.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Matisse Device 24: Function 3 [1022:1443]
	00:18.4 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Matisse Device 24: Function 4 [1022:1444]
	00:18.5 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Matisse Device 24: Function 5 [1022:1445]
	00:18.6 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Matisse Device 24: Function 6 [1022:1446]
	00:18.7 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Matisse Device 24: Function 7 [1022:1447]
IOMMU Group 14:
	01:00.0 Non-Volatile memory controller [0108]: Samsung Electronics Co Ltd NVMe SSD Controller SM981/PM981/PM983 [144d:a808]
IOMMU Group 15:
	20:00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Matisse Switch Upstream [1022:57ad]
IOMMU Group 16:
	21:02.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Matisse PCIe GPP Bridge [1022:57a3]
IOMMU Group 17:
	21:04.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Matisse PCIe GPP Bridge [1022:57a3]
IOMMU Group 18:
	21:05.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Matisse PCIe GPP Bridge [1022:57a3]
IOMMU Group 19:
	21:06.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Matisse PCIe GPP Bridge [1022:57a3]
IOMMU Group 2:
	00:01.2 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse GPP Bridge [1022:1483]
IOMMU Group 20:
	21:08.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Matisse PCIe GPP Bridge [1022:57a4]
	2a:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Reserved SPP [1022:1485]
	2a:00.1 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Matisse USB 3.0 Host Controller [1022:149c]
	2a:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Matisse USB 3.0 Host Controller [1022:149c]
IOMMU Group 21:
	21:09.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Matisse PCIe GPP Bridge [1022:57a4]
	2b:00.0 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] FCH SATA Controller [AHCI mode] [1022:7901] (rev 51)
IOMMU Group 22:
	21:0a.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Matisse PCIe GPP Bridge [1022:57a4]
	2c:00.0 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] FCH SATA Controller [AHCI mode] [1022:7901] (rev 51)
IOMMU Group 23:
	24:00.0 VGA compatible controller [0300]: NVIDIA Corporation GK208B [GeForce GT 710] [10de:128b] (rev a1)
	24:00.1 Audio device [0403]: NVIDIA Corporation GK208 HDMI/DP Audio Controller [10de:0e0f] (rev a1)
IOMMU Group 24:
	26:00.0 Ethernet controller [0200]: Intel Corporation I211 Gigabit Network Connection [8086:1539] (rev 03)
IOMMU Group 25:
	27:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. RTL8125 2.5GbE Controller [10ec:8125]
IOMMU Group 26:
	28:00.0 Network controller [0280]: Intel Corporation Wi-Fi 6 AX200 [8086:2723] (rev 1a)
IOMMU Group 27:
	2d:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [AMD/ATI] Ellesmere [Radeon RX 470/480/570/570X/580/580X/590] [1002:67df] (rev e7)
	2d:00.1 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ATI] Ellesmere HDMI Audio [Radeon RX 470/480 / 570/580/590] [1002:aaf0]
IOMMU Group 28:
	2e:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Function [1022:148a]
IOMMU Group 29:
	2f:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Reserved SPP [1022:1485]
IOMMU Group 3:
	00:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU Group 30:
	2f:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Matisse USB 3.0 Host Controller [1022:149c]
IOMMU Group 31:
	2f:00.4 Audio device [0403]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse HD Audio Controller [1022:1487]
IOMMU Group 4:
	00:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU Group 5:
	00:03.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse GPP Bridge [1022:1483]
IOMMU Group 6:
	00:04.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU Group 7:
	00:05.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU Group 8:
	00:07.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU Group 9:
	00:07.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B] [1022:1484]
```

### use GT710@PCI_E5 instead of RX580@PCI_E1

[2020-09-10] failed -- it seems the primary GPU cannot be used as pass-through. MSI bios doesn't have an option to change initial GPU.

Refs:
[1](https://forums.developer.nvidia.com/t/multi-nvidia-gpus-and-xorg-conf-how-to-account-for-pci-bus-busid-change/34556),
[2](https://stackoverflow.com/questions/18382271/how-can-i-modify-xorg-conf-file-to-force-x-server-to-run-on-a-specific-gpu-i-a)

#### generate xorg config
```
[12:03:50]yy@ryzen:~$ sudo nvidia-xconfig 
...
```

#### get BusID and put it into the newly generated xorg config

(`nvidia-xconfig` doesn't put BusID in config so maybe this is optional?)

```
[12:03:25]yy@ryzen:~$ nvidia-xconfig --query-gpu-info
Number of GPUs: 1

GPU #0:
  Name      : GeForce GT 710
  UUID      : GPU-b172a826-6bda-fa17-a1ce-7aca38f90d5e
  PCI BusID : PCI:36:0:0

  Number of Display Devices: 1

  Display Device 0 (TV-1):
      EDID Name             : AOC 2757
      Minimum HorizSync     : 30.000 kHz
      Maximum HorizSync     : 83.000 kHz
      Minimum VertRefresh   : 50 Hz
      Maximum VertRefresh   : 76 Hz
      Maximum PixelClock    : 170.000 MHz
      Maximum Width         : 1920 pixels
      Maximum Height        : 1080 pixels
      Preferred Width       : 1920 pixels
      Preferred Height      : 1080 pixels
      Preferred VertRefresh : 60 Hz
      Physical Width        : 600 mm
      Physical Height       : 340 mm
```

Note: `PCI:36:0:0` is the same as `24:00.0` in the output of `lspci`. The former is decimal and the latter is hex.

```
[12:03:50]yy@ryzen:~$ vi /etc/X11/xorg.conf
# nvidia-xconfig: X configuration file generated by nvidia-xconfig
# nvidia-xconfig:  version 440.100

Section "ServerLayout"
    Identifier     "Layout0"
    Screen      0  "Screen0"
    InputDevice    "Keyboard0" "CoreKeyboard"
    InputDevice    "Mouse0" "CorePointer"
EndSection

Section "Files"
EndSection

Section "InputDevice"
    # generated from default
    Identifier     "Mouse0"
    Driver         "mouse"
    Option         "Protocol" "auto"
    Option         "Device" "/dev/psaux"
    Option         "Emulate3Buttons" "no"
    Option         "ZAxisMapping" "4 5"
EndSection

Section "InputDevice"
    # generated from default
    Identifier     "Keyboard0"
    Driver         "kbd"
EndSection

Section "Monitor"
    Identifier     "Monitor0"
    VendorName     "Unknown"
    ModelName      "Unknown"
    Option         "DPMS"
EndSection

Section "Device"
    Identifier     "Device0"
    Driver         "nvidia"
    VendorName     "NVIDIA Corporation"
    BusID          "PCI:36:0:0"
EndSection

Section "Screen"
    Identifier     "Screen0"
    Device         "Device0"
    Monitor        "Monitor0"
    DefaultDepth    24
    SubSection     "Display"
        Depth       24
    EndSubSection
EndSection
```

### modify grub

#### the elegant way - modify `/etc/default/grub`

```
$ sudo vi /etc/default/grub
...
GRUB_CMDLINE_LINUX="amd_iommu=on iommu=pt vfio-pci.ids=1002:67df,1002:aaf0,8086:1539"
...
```
```
$ sudo update-grub
```

#### the brutal way - modify `/boot/grub/grub.cfg`

```
menuentry 'Ubuntu' --class ubuntu --class gnu-linux --class gnu --class os $menuentry_id_option 'gnulinux-simple-feada7a3-0ea8-461e-a256-3a6d514aefd8' {
	recordfail
	load_video
	gfxmode $linux_gfx_mode
	insmod gzio
	if [ x$grub_platform = xxen ]; then insmod xzio; insmod lzopio; fi
	insmod part_gpt
	insmod ext2
	if [ x$feature_platform_search_hint = xy ]; then
	  search --no-floppy --fs-uuid --set=root  feada7a3-0ea8-461e-a256-3a6d514aefd8
	else
	  search --no-floppy --fs-uuid --set=root feada7a3-0ea8-461e-a256-3a6d514aefd8
	fi
	linux /boot/vmlinuz-5.4.0-47-generic root=UUID=feada7a3-0ea8-461e-a256-3a6d514aefd8 ro quiet splash $vt_handoff amd_iommu=on iommu=pt vfio-pci.ids=1002:67df,1002:aaf0,8086:1539
	initrd	/boot/initrd.img-5.4.0-47-generic
}
```

### reboot

```
[17:00:57]yy@ryzen:~$ cat /proc/cmdline 
BOOT_IMAGE=/boot/vmlinuz-5.4.0-47-generic root=UUID=feada7a3-0ea8-461e-a256-3a6d514aefd8 ro quiet splash amd_iommu=on iommu=pt vfio-pci.ids=10de:128b,10de:0e0f
```

```
[17:09:55]yy@ryzen:~$ dmesg | grep -i -e DMAR -e IOMMU
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.4.0-47-generic root=UUID=feada7a3-0ea8-461e-a256-3a6d514aefd8 ro quiet splash amd_iommu=on iommu=pt vfio-pci.ids=10de:128b,10de:0e0f
[    0.077143] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.4.0-47-generic root=UUID=feada7a3-0ea8-461e-a256-3a6d514aefd8 ro quiet splash amd_iommu=on iommu=pt vfio-pci.ids=10de:128b,10de:0e0f
[    0.718807] iommu: Default domain type: Passthrough (set via kernel command line)
[    0.817035] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters supported
[    0.817210] pci 0000:00:01.0: Adding to iommu group 0
[    0.817229] pci 0000:00:01.1: Adding to iommu group 1
[    0.817248] pci 0000:00:01.2: Adding to iommu group 2
[    0.817262] pci 0000:00:02.0: Adding to iommu group 3
[    0.817280] pci 0000:00:03.0: Adding to iommu group 4
[    0.817298] pci 0000:00:03.1: Adding to iommu group 5
[    0.817312] pci 0000:00:04.0: Adding to iommu group 6
[    0.817326] pci 0000:00:05.0: Adding to iommu group 7
[    0.817343] pci 0000:00:07.0: Adding to iommu group 8
[    0.817360] pci 0000:00:07.1: Adding to iommu group 9
[    0.817380] pci 0000:00:08.0: Adding to iommu group 10
[    0.817397] pci 0000:00:08.1: Adding to iommu group 11
[    0.817413] pci 0000:00:14.0: Adding to iommu group 12
[    0.817424] pci 0000:00:14.3: Adding to iommu group 12
[    0.817457] pci 0000:00:18.0: Adding to iommu group 13
[    0.817469] pci 0000:00:18.1: Adding to iommu group 13
[    0.817482] pci 0000:00:18.2: Adding to iommu group 13
[    0.817493] pci 0000:00:18.3: Adding to iommu group 13
[    0.817504] pci 0000:00:18.4: Adding to iommu group 13
[    0.817515] pci 0000:00:18.5: Adding to iommu group 13
[    0.817528] pci 0000:00:18.6: Adding to iommu group 13
[    0.817539] pci 0000:00:18.7: Adding to iommu group 13
[    0.817558] pci 0000:01:00.0: Adding to iommu group 14
[    0.817582] pci 0000:20:00.0: Adding to iommu group 15
[    0.817654] pci 0000:21:02.0: Adding to iommu group 16
[    0.817725] pci 0000:21:04.0: Adding to iommu group 17
[    0.817796] pci 0000:21:05.0: Adding to iommu group 18
[    0.817866] pci 0000:21:06.0: Adding to iommu group 19
[    0.817897] pci 0000:21:08.0: Adding to iommu group 20
[    0.817926] pci 0000:21:09.0: Adding to iommu group 21
[    0.817954] pci 0000:21:0a.0: Adding to iommu group 22
[    0.818027] pci 0000:24:00.0: Adding to iommu group 23
[    0.818086] pci 0000:24:00.1: Adding to iommu group 23
[    0.818144] pci 0000:26:00.0: Adding to iommu group 24
[    0.818211] pci 0000:27:00.0: Adding to iommu group 25
[    0.818268] pci 0000:28:00.0: Adding to iommu group 26
[    0.818290] pci 0000:2a:00.0: Adding to iommu group 20
[    0.818316] pci 0000:2a:00.1: Adding to iommu group 20
[    0.818331] pci 0000:2a:00.3: Adding to iommu group 20
[    0.818352] pci 0000:2b:00.0: Adding to iommu group 21
[    0.818373] pci 0000:2c:00.0: Adding to iommu group 22
[    0.818417] pci 0000:2d:00.0: Adding to iommu group 27
[    0.818445] pci 0000:2d:00.1: Adding to iommu group 27
[    0.818463] pci 0000:2e:00.0: Adding to iommu group 28
[    0.818486] pci 0000:2f:00.0: Adding to iommu group 29
[    0.818505] pci 0000:2f:00.3: Adding to iommu group 30
[    0.818525] pci 0000:2f:00.4: Adding to iommu group 31
[    0.818713] pci 0000:00:00.2: AMD-Vi: Found IOMMU cap 0x40
[    0.819310] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/bank).
[    3.120133] AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
```

```
[17:10:47]yy@ryzen:~$ dmesg | grep -i vfio
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.4.0-47-generic root=UUID=feada7a3-0ea8-461e-a256-3a6d514aefd8 ro quiet splash amd_iommu=on iommu=pt vfio-pci.ids=10de:128b,10de:0e0f
[    0.077143] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.4.0-47-generic root=UUID=feada7a3-0ea8-461e-a256-3a6d514aefd8 ro quiet splash amd_iommu=on iommu=pt vfio-pci.ids=10de:128b,10de:0e0f
[    0.860222] VFIO - User Level meta-driver version: 0.3
[    0.860272] vfio-pci 0000:24:00.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=none
[    0.880047] vfio_pci: add [10de:128b[ffffffff:ffffffff]] class 0x000000/00000000
[    0.900155] vfio_pci: add [10de:0e0f[ffffffff:ffffffff]] class 0x000000/00000000
```

```
[17:11:17]yy@ryzen:~$ lspci -nnk
00:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Root Complex [1022:1480]
	Subsystem: Micro-Star International Co., Ltd. [MSI] Starship/Matisse Root Complex [1462:7c35]
00:00.2 IOMMU [0806]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse IOMMU [1022:1481]
	Subsystem: Micro-Star International Co., Ltd. [MSI] Starship/Matisse IOMMU [1462:7c35]
00:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
00:01.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse GPP Bridge [1022:1483]
	Kernel driver in use: pcieport
00:01.2 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse GPP Bridge [1022:1483]
	Kernel driver in use: pcieport
00:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
00:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
00:03.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse GPP Bridge [1022:1483]
	Kernel driver in use: pcieport
00:04.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
00:05.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
00:07.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
00:07.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B] [1022:1484]
	Kernel driver in use: pcieport
00:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
00:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B] [1022:1484]
	Kernel driver in use: pcieport
00:14.0 SMBus [0c05]: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller [1022:790b] (rev 61)
	Subsystem: Micro-Star International Co., Ltd. [MSI] FCH SMBus Controller [1462:7c35]
	Kernel driver in use: piix4_smbus
	Kernel modules: i2c_piix4, sp5100_tco
00:14.3 ISA bridge [0601]: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge [1022:790e] (rev 51)
	Subsystem: Micro-Star International Co., Ltd. [MSI] FCH LPC Bridge [1462:7c35]
00:18.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Matisse Device 24: Function 0 [1022:1440]
00:18.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Matisse Device 24: Function 1 [1022:1441]
00:18.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Matisse Device 24: Function 2 [1022:1442]
00:18.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Matisse Device 24: Function 3 [1022:1443]
	Kernel driver in use: k10temp
	Kernel modules: k10temp
00:18.4 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Matisse Device 24: Function 4 [1022:1444]
00:18.5 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Matisse Device 24: Function 5 [1022:1445]
00:18.6 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Matisse Device 24: Function 6 [1022:1446]
00:18.7 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Matisse Device 24: Function 7 [1022:1447]
01:00.0 Non-Volatile memory controller [0108]: Samsung Electronics Co Ltd NVMe SSD Controller SM981/PM981/PM983 [144d:a808]
	Subsystem: Samsung Electronics Co Ltd NVMe SSD Controller SM981/PM981/PM983 [144d:a801]
	Kernel driver in use: nvme
	Kernel modules: nvme
20:00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Matisse Switch Upstream [1022:57ad]
	Kernel driver in use: pcieport
21:02.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Matisse PCIe GPP Bridge [1022:57a3]
	Kernel driver in use: pcieport
21:04.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Matisse PCIe GPP Bridge [1022:57a3]
	Kernel driver in use: pcieport
21:05.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Matisse PCIe GPP Bridge [1022:57a3]
	Kernel driver in use: pcieport
21:06.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Matisse PCIe GPP Bridge [1022:57a3]
	Kernel driver in use: pcieport
21:08.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Matisse PCIe GPP Bridge [1022:57a4]
	Kernel driver in use: pcieport
21:09.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Matisse PCIe GPP Bridge [1022:57a4]
	Kernel driver in use: pcieport
21:0a.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Matisse PCIe GPP Bridge [1022:57a4]
	Kernel driver in use: pcieport
24:00.0 VGA compatible controller [0300]: NVIDIA Corporation GK208B [GeForce GT 710] [10de:128b] (rev a1)
	Subsystem: eVga.com. Corp. GK208B [GeForce GT 710] [3842:2717]
	Kernel driver in use: vfio-pci
	Kernel modules: nvidiafb, nouveau, nvidia_drm, nvidia
24:00.1 Audio device [0403]: NVIDIA Corporation GK208 HDMI/DP Audio Controller [10de:0e0f] (rev a1)
	Subsystem: eVga.com. Corp. GK208 HDMI/DP Audio Controller [3842:2717]
	Kernel driver in use: vfio-pci
	Kernel modules: snd_hda_intel
26:00.0 Ethernet controller [0200]: Intel Corporation I211 Gigabit Network Connection [8086:1539] (rev 03)
	Subsystem: Micro-Star International Co., Ltd. [MSI] I211 Gigabit Network Connection [1462:7c35]
	Kernel driver in use: igb
	Kernel modules: igb
27:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. RTL8125 2.5GbE Controller [10ec:8125]
	Subsystem: Micro-Star International Co., Ltd. [MSI] RTL8125 2.5GbE Controller [1462:7c35]
	Kernel driver in use: r8169
	Kernel modules: r8169
28:00.0 Network controller [0280]: Intel Corporation Wi-Fi 6 AX200 [8086:2723] (rev 1a)
	DeviceName: RTL8111EPV
	Subsystem: Intel Corporation Wi-Fi 6 AX200 [8086:0084]
	Kernel driver in use: iwlwifi
	Kernel modules: iwlwifi
2a:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Reserved SPP [1022:1485]
	Subsystem: Micro-Star International Co., Ltd. [MSI] Starship/Matisse Reserved SPP [1462:7c35]
2a:00.1 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Matisse USB 3.0 Host Controller [1022:149c]
	Subsystem: Micro-Star International Co., Ltd. [MSI] Matisse USB 3.0 Host Controller [1462:7c35]
	Kernel driver in use: xhci_hcd
2a:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Matisse USB 3.0 Host Controller [1022:149c]
	Subsystem: Advanced Micro Devices, Inc. [AMD] Matisse USB 3.0 Host Controller [1022:148c]
	Kernel driver in use: xhci_hcd
2b:00.0 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] FCH SATA Controller [AHCI mode] [1022:7901] (rev 51)
	Subsystem: Advanced Micro Devices, Inc. [AMD] FCH SATA Controller [AHCI mode] [1022:7901]
	Kernel driver in use: ahci
	Kernel modules: ahci
2c:00.0 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] FCH SATA Controller [AHCI mode] [1022:7901] (rev 51)
	Subsystem: Advanced Micro Devices, Inc. [AMD] FCH SATA Controller [AHCI mode] [1022:7901]
	Kernel driver in use: ahci
	Kernel modules: ahci
2d:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [AMD/ATI] Ellesmere [Radeon RX 470/480/570/570X/580/580X/590] [1002:67df] (rev e7)
	Subsystem: Sapphire Technology Limited Radeon RX 570 Pulse 4GB [1da2:e353]
	Kernel driver in use: amdgpu
	Kernel modules: amdgpu
2d:00.1 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ATI] Ellesmere HDMI Audio [Radeon RX 470/480 / 570/580/590] [1002:aaf0]
	Subsystem: Sapphire Technology Limited Ellesmere HDMI Audio [Radeon RX 470/480 / 570/580/590] [1da2:aaf0]
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel
2e:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Function [1022:148a]
	Subsystem: Micro-Star International Co., Ltd. [MSI] Starship/Matisse PCIe Dummy Function [1462:7c35]
2f:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Reserved SPP [1022:1485]
	Subsystem: Micro-Star International Co., Ltd. [MSI] Starship/Matisse Reserved SPP [1462:7c35]
2f:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Matisse USB 3.0 Host Controller [1022:149c]
	Subsystem: Micro-Star International Co., Ltd. [MSI] Matisse USB 3.0 Host Controller [1462:7c35]
	Kernel driver in use: xhci_hcd
2f:00.4 Audio device [0403]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse HD Audio Controller [1022:1487]
	Subsystem: Micro-Star International Co., Ltd. [MSI] Starship/Matisse HD Audio Controller [1462:cc35]
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel
```

### vm preparation

```
[13:11:03]yy@ryzen:~$ sudo apt-get install qemu-kvm libvirt-daemon-system libvirt-clients virt-manager bridge-utils
```

```
[13:12:20]yy@ryzen:~$ sudo adduser `id -un` libvirt
The user `yy' is already a member of `libvirt'.
[13:12:50]yy@ryzen:~$ sudo adduser `id -un` kvm
Adding user `yy' to group `kvm' ...
Adding user yy to group kvm
Done.
```

```
[13:16:20]yy@ryzen:~$ sudo service libvirtd start
[13:18:02]yy@ryzen:~$ sudo service libvirtd status
● libvirtd.service - Virtualization daemon
     Loaded: loaded (/lib/systemd/system/libvirtd.service; enabled; vendor preset: enabled)
     Active: active (running) since Thu 2020-09-10 12:52:24 PDT; 25min ago
TriggeredBy: ● libvirtd.socket
             ● libvirtd-ro.socket
             ● libvirtd-admin.socket
       Docs: man:libvirtd(8)
             https://libvirt.org
   Main PID: 5294 (libvirtd)
      Tasks: 19 (limit: 32768)
     Memory: 24.7M
     CGroup: /system.slice/libvirtd.service
             ├─5294 /usr/sbin/libvirtd
             ├─5429 /usr/sbin/dnsmasq --conf-file=/var/lib/libvirt/dnsmasq/default.conf --leasefile-ro --dhcp-script=/usr/lib/libvirt/libvirt_leaseshelper
             └─5430 /usr/sbin/dnsmasq --conf-file=/var/lib/libvirt/dnsmasq/default.conf --leasefile-ro --dhcp-script=/usr/lib/libvirt/libvirt_leaseshelper

Sep 10 12:52:24 ryzen systemd[1]: Started Virtualization daemon.
Sep 10 12:52:24 ryzen dnsmasq[5429]: started, version 2.80 cachesize 150
Sep 10 12:52:24 ryzen dnsmasq[5429]: compile time options: IPv6 GNU-getopt DBus i18n IDN DHCP DHCPv6 no-Lua TFTP conntrack ipset auth DNSSEC loop-detect inotify dumpfile
Sep 10 12:52:24 ryzen dnsmasq-dhcp[5429]: DHCP, IP range 192.168.122.2 -- 192.168.122.254, lease time 1h
Sep 10 12:52:24 ryzen dnsmasq-dhcp[5429]: DHCP, sockets bound exclusively to interface virbr0
Sep 10 12:52:24 ryzen dnsmasq[5429]: reading /etc/resolv.conf
Sep 10 12:52:24 ryzen dnsmasq[5429]: using nameserver 127.0.0.53#53
Sep 10 12:52:24 ryzen dnsmasq[5429]: read /etc/hosts - 7 addresses
Sep 10 12:52:24 ryzen dnsmasq[5429]: read /var/lib/libvirt/dnsmasq/default.addnhosts - 0 addresses
Sep 10 12:52:24 ryzen dnsmasq-dhcp[5429]: read /var/lib/libvirt/dnsmasq/default.hostsfile
```

For some reason, I have to reboot at this point, otherwise there is an error: `libvirt.libvirtError: Failed to connect socket to '/var/run/libvirt/libvirt-sock': Permission denied`.

After reboot:

```
[13:24:42]yy@ryzen:~$ groups
yy adm cdrom sudo dip plugdev kvm lpadmin lxd sambashare libvirt
```

```
[13:24:44]yy@ryzen:~$ virt-manager 
```

### vm - win10

[Windows VirtIO drivers](https://docs.fedoraproject.org/en-US/quick-docs/creating-windows-virtual-machines-using-virtio-drivers/index.html)


```
[13:58:02]yy@ryzen:~/___/vm$ virsh list --all
 Id   Name    State
------------------------
 -    win10   shut off
```

```
[14:14:45]yy@ryzen:~/___/vm$ virsh edit win10
[14:15:24]yy@ryzen:~/___/vm$ sudo vi /etc/libvirt/qemu.conf 
```

```
[14:23:30]yy@ryzen:~/___/vm$ sudo adduser `id -un` input
Adding user `yy' to group `input' ...
Adding user yy to group input
Done.
```

Let kvm hide itself so that nvidia driver is happy.

```
<domain type='kvm' xmlns:qemu='http://libvirt.org/schemas/domain/qemu/1.0'>
  <name>win10-gamer</name>
...
  <qemu:commandline>
    <qemu:arg value='-cpu'/>
    <qemu:arg value='host,kvm=off,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time,hv_vendor_id=whatever'/>
  </qemu:commandline>
</domain>
```

See [win10onRX580](https://github.com/yyu/vm/tree/master/win10onRX580) for more.

### vm - macOS

Ref: https://github.com/kholia/OSX-KVM

#### dependencies

```
sudo apt-get install qemu uml-utilities virt-manager git wget libguestfs-tools
```

#### networking option 1

Manual execution of the following commands is only needed before installation.

After installation finishes, `macos.xml` starts to be used, we no longer need these. (If we run them, vm will fail to start)

```
sudo ip tuntap add dev tap0 mode tap
sudo ip link set tap0 up promisc on
sudo ip link set dev virbr0 up
sudo ip link set dev tap0 master virbr0
```
#### networking option 2 (easy, not as fast; didn't try)

per [this link](https://github.com/kholia/OSX-KVM/blob/master/networking-qemu-kvm-howto.txt), simply replace
`-netdev tap,id=net0,ifname=tap0,script=no,downscript=no -device vmxnet3,netdev=net0,id=net0,mac=52:54:00:c9:18:27`
from the installation script below with either
```
-netdev user,id=net0 -device e1000-82545em,netdev=net0,id=net0,mac=52:54:00:c9:18:27 \
```
or
```
-netdev user,id=net0 -device vmxnet3,netdev=net0,id=net0,mac=52:54:00:c9:18:27 \
```

#### hard drive

```
$ qemu-img create -f qcow2 mac.img 512G
Formatting 'mac.img', fmt=qcow2 size=549755813888 cluster_size=65536 lazy_refcounts=off refcount_bits=16
$ mv mac.img ~/___/vm/
```

#### tweak

```
[19:38:34]yy@ryzen:~/___/src/OSX-KVM(master)$ sudo cat /sys/module/kvm/parameters/ignore_msrs
N
[19:38:48]yy@ryzen:~/___/src/OSX-KVM(master)$ sudo bash -c 'echo 1 > /sys/module/kvm/parameters/ignore_msrs'
[19:39:11]yy@ryzen:~/___/src/OSX-KVM(master)$ sudo cat /sys/module/kvm/parameters/ignore_msrs
Y
```

#### fetch macOS installation media

```
[20:03:46]yy@ryzen:~/___/src/OSX-KVM(master)$ git diff ./fetch-macOS.py 
-#!/usr/bin/env python
+#!/usr/bin/env python3
[20:04:04]yy@ryzen:~/___/src/OSX-KVM(master)$ ./fetch-macOS.py
...
#    ProductID    Version    Build   Post Date  Title
...
11    001-36801    10.15.6  19G2021  2020-08-12  macOS Catalina

Choose a product to download (1-11): 11
...
```
```
[20:07:03]yy@ryzen:~/___/src/OSX-KVM(master)$ qemu-img convert BaseSystem.dmg -O raw BaseSystem.img
```

#### installation script

```bash
[19:59:03]yy@ryzen:~/___/src/OSX-KVM(master)$ vimcat OpenCore-Boot.sh
#!/usr/bin/env bash

# Special thanks to:
# https://github.com/Leoyzen/KVM-Opencore
# https://github.com/thenickdude/KVM-Opencore/
# https://github.com/qemu/qemu/blob/master/docs/usb2.txt
#
# qemu-img create -f qcow2 mac_hdd_ng.img 128G
#
# echo 1 > /sys/module/kvm/parameters/ignore_msrs (this is required)

############################################################################
# NOTE: Tweak the "MY_OPTIONS" line in case you are having booting problems!
############################################################################

MY_OPTIONS="+pcid,+ssse3,+sse4.2,+popcnt,+avx,+aes,+xsave,+xsaveopt,check"

# This script works for Big Sur, Catalina, Mojave, and High Sierra. Tested with
# macOS 10.15.6, macOS 10.14.6, and macOS 10.13.6

ALLOCATED_RAM="16384" # MiB
CPU_SOCKETS="1"
CPU_CORES="2"
CPU_THREADS="4"

REPO_PATH="./"
OVMF_DIR="."

# This causes high cpu usage on the *host* side
# qemu-system-x86_64 -enable-kvm -m 3072 -cpu Penryn,vendor=GenuineIntel,+invtsc,vmware-cpuid-freq=on,hypervisor=off,vmx=on,kvm=off,$MY_OPTIONS\

# shellcheck disable=SC2054
args=(
  -enable-kvm -m "$ALLOCATED_RAM" -cpu Penryn,kvm=on,vendor=GenuineIntel,+invtsc,vmware-cpuid-freq=on,"$MY_OPTIONS"
  -machine q35
  -usb -device usb-kbd -device usb-tablet
  -smp "$CPU_THREADS",cores="$CPU_CORES",sockets="$CPU_SOCKETS"
  -device usb-ehci,id=ehci
  -device usb-kbd,bus=ehci.0
  -device usb-mouse,bus=ehci.0
  -device nec-usb-xhci,id=xhci
  -device isa-applesmc,osk="ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc"
  -drive if=pflash,format=raw,readonly,file="$REPO_PATH/$OVMF_DIR/OVMF_CODE.fd"
  -drive if=pflash,format=raw,file="$REPO_PATH/$OVMF_DIR/OVMF_VARS-1024x768.fd"
  -smbios type=2
  -device ich9-intel-hda -device hda-duplex
  -device ich9-ahci,id=sata
  -drive id=OpenCoreBoot,if=none,snapshot=on,format=qcow2,file="$REPO_PATH/OpenCore-Catalina/OpenCore-nopicker.qcow2"
  -device ide-hd,bus=sata.2,drive=OpenCoreBoot
  -device ide-hd,bus=sata.3,drive=InstallMedia
  -drive id=InstallMedia,if=none,file="$REPO_PATH/BaseSystem.img",format=raw
  -drive id=MacHDD,if=none,file="/home/yy/___/vm/mac.img",format=qcow2
  -device ide-hd,bus=sata.4,drive=MacHDD
  -netdev tap,id=net0,ifname=tap0,script=no,downscript=no -device vmxnet3,netdev=net0,id=net0,mac=52:54:00:c9:18:27
  -monitor stdio
  -vga vmware
)

echo qemu-system-x86_64 "${args[@]}"
qemu-system-x86_64 "${args[@]}"
```

```
[19:42:00]yy@ryzen:~/___/src/OSX-KVM(master)$ ./OpenCore-Boot.sh 
qemu-system-x86_64 -enable-kvm -m 16384 -cpu Penryn,kvm=on,vendor=GenuineIntel,+invtsc,vmware-cpuid-freq=on,+pcid,+ssse3,+sse4.2,+popcnt,+avx,+aes,+xsave,+xsaveopt,check -machine q35 -usb -device usb-kbd -device usb-tablet -smp 4,cores=2,sockets=1 -device usb-ehci,id=ehci -device usb-kbd,bus=ehci.0 -device usb-mouse,bus=ehci.0 -device nec-usb-xhci,id=xhci -device isa-applesmc,osk=ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc -drive if=pflash,format=raw,readonly,file=.//./OVMF_CODE.fd -drive if=pflash,format=raw,file=.//./OVMF_VARS-1024x768.fd -smbios type=2 -device ich9-intel-hda -device hda-duplex -device ich9-ahci,id=sata -drive id=OpenCoreBoot,if=none,snapshot=on,format=qcow2,file=.//OpenCore-Catalina/OpenCore-nopicker.qcow2 -device ide-hd,bus=sata.2,drive=OpenCoreBoot -device ide-hd,bus=sata.3,drive=InstallMedia -drive id=InstallMedia,if=none,file=.//BaseSystem.img,format=raw -drive id=MacHDD,if=none,file=/home/yy/___/vm/mac.img,format=qcow2 -device ide-hd,bus=sata.4,drive=MacHDD -netdev tap,id=net0,ifname=tap0,script=no,downscript=no -device vmxnet3,netdev=net0,id=net0,mac=52:54:00:c9:18:27 -monitor stdio -vga vmware
QEMU 4.2.0 monitor - type 'help' for more information
(qemu) qemu-system-x86_64: warning: host doesn't support requested feature: CPUID.01H:ECX.pcid [bit 17]
qemu-system-x86_64: warning: host doesn't support requested feature: CPUID.01H:ECX.pcid [bit 17]
qemu-system-x86_64: warning: host doesn't support requested feature: CPUID.01H:ECX.pcid [bit 17]
qemu-system-x86_64: warning: host doesn't support requested feature: CPUID.01H:ECX.pcid [bit 17]
```

#### post-install

```
[20:38:17]yy@ryzen:~/___/src/vm/macosCatalina(master)$ virt-xml-validate macos.xml 
macos.xml validates
[20:38:44]yy@ryzen:~/___/src/vm/macosCatalina(master)$ virsh --connect qemu:///system define macos.xml
Domain macos defined from macos.xml
```

Then use it in `virt-manager`.

#### macos.xml

These seem to be important:

In the beginning:
`<domain`**`xmlns:qemu="http://libvirt.org/schemas/domain/qemu/1.0"`**`type="kvm">`

At the end:
```
  <qemu:commandline>
    <qemu:arg value="-device"/>
    <qemu:arg value="isa-applesmc,osk=ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc"/>
    <qemu:arg value="-smbios"/>
    <qemu:arg value="type=2"/>
    <qemu:arg value="-device"/>
    <qemu:arg value="vmware-svga"/>
    <qemu:arg value="-cpu"/>
    <qemu:arg value="Penryn,kvm=on,vendor=GenuineIntel,+invtsc,vmware-cpuid-freq=on,+pcid,+ssse3,+sse4.2,+popcnt,+avx,+aes,+xsave,+xsaveopt,check"/>
  </qemu:commandline>
</domain>
```
