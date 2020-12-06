## RX 580 problem

It worked on Catalina but Big Sur only sees HDMI ports, DP cannot be used.

Possible solutions:
* [tonymacx86 - [Solved] Sapphire RX 580 Nitro+ SE | black screen on HDMI and DVI](https://www.tonymacx86.com/threads/solved-sapphire-rx-580-nitro-se-black-screen-on-hdmi-and-dvi.267078/)
* [tonymacx86 - AMD Radeon Performance Enhanced SSDT](https://www.tonymacx86.com/threads/amd-radeon-performance-enhanced-ssdt.296555/)

Links:
* [google search - big sur rx580](https://www.google.com/search?q=big+sur+rx580&oq=big+sur+rx580&aqs=chrome..69i57j0i13.3767j1j7&sourceid=chrome&ie=UTF-8)
* [google search - opencore videoports](https://www.google.com/search?q=opencore+videoports&oq=opencore+videoports&aqs=chrome..69i57j33i10i160.3603j0j7&sourceid=chrome&ie=UTF-8)
* [InsanelyMac - Radeon RX 580 on macOS Catalina](https://www.insanelymac.com/forum/topic/344021-guide-radeon-rx-580-on-macos-catalina/)
* [hackintosher - [Solved] Black Screen when booting into freshly installed Catalina 10.15.1](https://hackintosher.com/forums/thread/solved-black-screen-when-booting-into-freshly-installed-catalina-10-15-1.5605/)

## Notes

```

ACPI
* SSDT-DTGP.aml -- will boot without this
* SSDT-EC.aml
* SSDT-EHCI.aml
* SSDT-PLUG.aml




                                            __________________________
[xx:xx:xx]yy@vubuntu:~/___/gibMacOS-master$ python gibMacOS.command -r
                                            _________________________________________________________________________
[01:57:26]yy@vubuntu:~/___/gibMacOS-master$ cd macOS\ Downloads/publicrelease/001-51042\ -\ 10.15.7\ macOS\ Catalina/
                                                                                                             __
[01:57:30]yy@vubuntu:~/___/gibMacOS-master/macOS Downloads/publicrelease/001-51042 - 10.15.7 macOS Catalina$ lh
total 478M
-rw-rw-r-- 1 yy 478M Oct  4 01:57 RecoveryHDMetaDmg.pkg
                                                                                                             ______________________
[01:57:30]yy@vubuntu:~/___/gibMacOS-master/macOS Downloads/publicrelease/001-51042 - 10.15.7 macOS Catalina$ 7z e -txar *.pkg *.dmg

7-Zip [64] 16.02 : Copyright (c) 1999-2016 Igor Pavlov : 2016-05-21
p7zip Version 16.02 (locale=en_US.UTF-8,Utf16=on,HugeFiles=on,64 bits,16 CPUs Intel Core 2 Duo P9xxx (Penryn Class Core 2) (10673),ASM,AES-NI)

Scanning the drive for archives:
1 file, 500589851 bytes (478 MiB)

Extracting archive: RecoveryHDMetaDmg.pkg

WARNINGS:
There are data after the end of archive

--
Path = RecoveryHDMetaDmg.pkg
Type = Xar
WARNINGS:
There are data after the end of archive
Physical Size = 500587710
Tail Size = 2141
SubType = pkg
Headers Size = 4103

Everything is Ok

Archives with Warnings: 1

Warnings: 1
Size:       500582295
Compressed: 500589851
                                                                                                             __
[01:57:43]yy@vubuntu:~/___/gibMacOS-master/macOS Downloads/publicrelease/001-51042 - 10.15.7 macOS Catalina$ lh
total 955M
-rw-rw-r-- 1 yy 478M Sep 21 16:17 RecoveryHDMeta.dmg
-rw-rw-r-- 1 yy 478M Oct  4 01:57 RecoveryHDMetaDmg.pkg
                                                                                                             __________________
[01:57:45]yy@vubuntu:~/___/gibMacOS-master/macOS Downloads/publicrelease/001-51042 - 10.15.7 macOS Catalina$ 7z e *.dmg */Base*

7-Zip [64] 16.02 : Copyright (c) 1999-2016 Igor Pavlov : 2016-05-21
p7zip Version 16.02 (locale=en_US.UTF-8,Utf16=on,HugeFiles=on,64 bits,16 CPUs Intel Core 2 Duo P9xxx (Penryn Class Core 2) (10673),ASM,AES-NI)

Scanning the drive for archives:
1 file, 500582295 bytes (478 MiB)

Extracting archive: RecoveryHDMeta.dmg
--
Path = RecoveryHDMeta.dmg
Type = Dmg
Physical Size = 500582295
Method = Copy Zero2 ZLIB CRC
Blocks = 508
----
Path = 4.hfs
Size = 623345664
Packed Size = 500543634
Comment = disk image (Apple_HFS : 4)
Method = Copy Zero2 ZLIB CRC
--
Path = 4.hfs
Type = HFS
Physical Size = 623345664
Method = HFS+
Cluster Size = 4096
Free Space = 105676800
Created = 2020-09-21 14:02:13
Modified = 2020-09-21 16:15:33

Everything is Ok                      

Files: 2
Size:       498628226
Compressed: 500582295
                                                                                                             __
[01:57:52]yy@vubuntu:~/___/gibMacOS-master/macOS Downloads/publicrelease/001-51042 - 10.15.7 macOS Catalina$ lh
total 1.4G
-rw-rw-r-- 1 yy 2.0K Sep 21 16:15 BaseSystem.chunklist
-rw-rw-r-- 1 yy 476M Sep 21 13:56 BaseSystem.dmg
-rw-rw-r-- 1 yy 478M Sep 21 16:17 RecoveryHDMeta.dmg
-rw-rw-r-- 1 yy 478M Oct  4 01:57 RecoveryHDMetaDmg.pkg
[01:57:54]yy@vubuntu:~/___/gibMacOS-master/macOS Downloads/publicrelease/001-51042 - 10.15.7 macOS Catalina$ 
                                                                                                             ____________________________
[02:09:10]yy@vubuntu:~/___/gibMacOS-master/macOS Downloads/publicrelease/001-51042 - 10.15.7 macOS Catalina$ udisksctl mount -b /dev/sdb1
Mounted /dev/sdb1 at /media/yy/OPENCORE.
                                                                                                             ______________________
[02:09:17]yy@vubuntu:~/___/gibMacOS-master/macOS Downloads/publicrelease/001-51042 - 10.15.7 macOS Catalina$ cd /media/yy/OPENCORE/
                                         _____________________________
[02:09:38]yy@vubuntu:/media/yy/OPENCORE$ mkdir com.apple.recovery.boot
                                         ____________________________________________________________________________________________________________________________________
[02:09:46]yy@vubuntu:/media/yy/OPENCORE$ cp ~/___/gibMacOS-master/macOS\ Downloads/publicrelease/001-51042\ -\ 10.15.7\ macOS\ Catalina/BaseSystem.* com.apple.recovery.boot/












[02:25:12]yy@vubuntu:/media/yy/OPENCORE$ tree  # after cleaning up EFI/OC/ per https://dortania.github.io/OpenCore-Install-Guide/installer-guide/opencore-efi.html
.
├── com.apple.recovery.boot
│   ├── BaseSystem.chunklist
│   └── BaseSystem.dmg
└── EFI
    ├── BOOT
    │   └── BOOTx64.efi
    └── OC
        ├── ACPI
        ├── Bootstrap
        │   └── Bootstrap.efi
        ├── Drivers
        │   └── OpenRuntime.efi
        ├── Kexts
        ├── OpenCore.efi
        ├── Resources
        │   ├── Audio
        │   ├── Font
        │   ├── Image
        │   └── Label
        └── Tools
            └── OpenShell.efi

14 directories, 7 files






                                            __________________
[14:33:35]yy@vubuntu:~/___/SSDTTime-master$ ./SSDTTime.command            
Downloading iasl.zip                                                                                                                                                     
 - Extracting                                                                                                                                                            
 - Found iasl                                                                                                                                                            
   - Chmod +x                                                                                                                                                            
   - Copying to Scripts directory                                                                                                                                        
  #######################################################                                                                                                                
 #                     SSDT Time                       #                                                                                                                 
#######################################################                                                                                                                  
                                                                                                                                                                         
Current DSDT:  None                                                                                                                                                      
                                                                                                                                                                         
1. FixHPET       - Patch Out IRQ Conflicts                                                                                                                               
2. FakeEC        - OS-Aware Fake EC                                                                                                                                      
3. FakeEC Laptop - Only Builds Fake EC - Leaves Existing Untouched                                                                                                       
4. PluginType    - Sets plugin-type = 1 on First ProcessorObj                                                                                                            
5. PMC           - Enables Native NVRAM on True 300-Series Boards                                                                                                        
6. AWAC          - Context-Aware AWAC Disable and RTC Fake                                                                                                               
7. USB Reset     - Reset USB controllers to allow hardware mapping                                                                                                       
8. Dump DSDT     - Automatically dump the system DSDT                                                                                                                    
                                                                                                                                                                         
D. Select DSDT or origin folder                                                                                                                                          
Q. Quit                                                                                                                                                                  
                                                                                                                                                                         
Please make a selection:  8                                                                                                                                              
  #######################################################                                                                                                                
 #                    Dumping DSDT                     #                                                                                                                 
#######################################################                                                                                                                  
                                          
Checking if DSDT exists                                                             
Copying DSDT to safe location.            
You have to enter your password to copy the file:                                   
[sudo] password for yy:                                                             
Changing file ownership
Success!
Press [enter] to return to main menu...
  #######################################################
 #                     SSDT Time                       #                                                                                                                 
#######################################################                                                                                                                  

Current DSDT:  /home/yy/___/SSDTTime-master/Results/DSDT.aml

1. FixHPET       - Patch Out IRQ Conflicts 
2. FakeEC        - OS-Aware Fake EC
3. FakeEC Laptop - Only Builds Fake EC - Leaves Existing Untouched
4. PluginType    - Sets plugin-type = 1 on First ProcessorObj
5. PMC           - Enables Native NVRAM on True 300-Series Boards
6. AWAC          - Context-Aware AWAC Disable and RTC Fake
7. USB Reset     - Reset USB controllers to allow hardware mapping
8. Dump DSDT     - Automatically dump the system DSDT

D. Select DSDT or origin folder
Q. Quit

Please make a selection:  q
  #######################################################
 #                     SSDT Time                       #
#######################################################
by CorpNewt

Thanks for testing it out, for bugs/comments/complaints
send me a message on Reddit, or check out my GitHub:

www.reddit.com/u/corpnewt
www.github.com/corpnewt

Have a nice afternoon!


                                            ___________
[14:37:23]yy@vubuntu:~/___/SSDTTime-master$ lh Results/
total 12K
-r-------- 1 yy 9.1K Oct  4 14:37 DSDT.aml 








                                            _____________________________
[14:39:24]yy@vubuntu:~/___/SSDTTime-master$ sudo apt install acpica-tools 
                                            ___________
[14:39:47]yy@vubuntu:~/___/SSDTTime-master$ cd Results/
                                                    _____________
[14:39:54]yy@vubuntu:~/___/SSDTTime-master/Results$ iasl DSDT.aml 

Intel ACPI Component Architecture
ASL+ Optimizing Compiler/Disassembler version 20190509
Copyright (c) 2000 - 2019 Intel Corporation

File appears to be binary: found 4076 non-ASCII characters, disassembling
Binary file appears to be a valid ACPI table, disassembling
Input file DSDT.aml, Length 0x242F (9263) bytes
ACPI: DSDT 0x0000000000000000 00242F (v01 BOCHS  BXPCDSDT 00000001 BXPC 00000001)
Pass 1 parse of [DSDT]
Pass 2 parse of [DSDT]
Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)

Parsing completed
Disassembly completed
ASL Output:    DSDT.dsl - 97532 bytes
                                                    __
[14:39:59]yy@vubuntu:~/___/SSDTTime-master/Results$ lh
total 108K
-r-------- 1 yy 9.1K Oct  4 14:37 DSDT.aml
-rw-rw-r-- 1 yy  96K Oct  4 14:39 DSDT.dsl



ACPI

* use OpenCore-0.6.1-DEBUG/Docs/AcpiSamples/SSDT-EC-USBX.dsl





First I used these:

Type:         iMacPro1,1
Serial:       C02D85YCHX87
Board Serial: C02034108CDJG36JC
SmUUID:       8AA4C467-6860-46C1-A772-0B559A6D41A8

... and iMessage didn't let me log in, so I re-generated serials and found these:
Type:         iMacPro1,1
Serial:       C02Y4072HX87
Board Serial: C02903403CDJG36CB
SmUUID:       2B015DA3-07F5-4412-B986-4503E8ABF130






[22:47:51]yy@vubuntu:~/___$ GenSMBIOS-master/GenSMBIOS.command 
  #######################################################
 #          Getting MacSerial Remote Version           #
#######################################################
                                                                                                    
Gathering latest macserial info...                                                                  
  #######################################################
 #                     GenSMBIOS                       #
#######################################################
                                                                                                    
MacSerial v2.1.2                                                                                    
Current plist: None                                                                                 
Plist type:    Unknown

1. Install/Update MacSerial
2. Select config.plist
3. Generate SMBIOS
4. Generate UUID
5. List Current SMBIOS

Q. Quit

Please select an option:  1
  #######################################################
 #                 Getting MacSerial                   #
#######################################################

Gathering latest macserial info...
 - LinuxURL: https://github.com/acidanthera/macinfopkg/releases/download/2.1.2/macinfo-2.1.2-linux.zip

Downloading macinfo-2.1.2-linux.zip...
 - Extracting...
 - Found macserial
   - Chmod +x...
   - Copying to Scripts directory...

Cleaning up...

Done.
  #######################################################
 #                     GenSMBIOS                       #
#######################################################

MacSerial v2.1.2
Current plist: None
Plist type:    Unknown

1. Install/Update MacSerial
2. Select config.plist
3. Generate SMBIOS
4. Generate UUID
5. List Current SMBIOS

Q. Quit

Please select an option:  3
  #######################################################
 #                  Generate SMBIOS                    #
#######################################################

M. Main Menu
Q. Quit

Please type the SMBIOS to gen and the number
of times to generate [max 20] (i.e. iMac18,3 5):  iMacPro1,1 5
  #######################################################
 #              iMacPro1,1 SMBIOS Info                 #
#######################################################

Type:         iMacPro1,1
Serial:       C02CGSZGHX87
Board Serial: C02012306QXJG361H
SmUUID:       2FCAC376-F1C3-463A-9FDA-8E511195318A

Type:         iMacPro1,1
Serial:       C02V7JY0HX87
Board Serial: C02733100CDJG36FB
SmUUID:       FC7A470C-8982-44EE-B571-F8FEADD4E226

Type:         iMacPro1,1
Serial:       C02D85YCHX87
Board Serial: C02034108CDJG36JC
SmUUID:       8AA4C467-6860-46C1-A772-0B559A6D41A8

Type:         iMacPro1,1
Serial:       C02ZT4ZHHX87
Board Serial: C02950902CDJG36CB
SmUUID:       AB1D1839-C2E1-4F69-BB18-148376882CA4

Type:         iMacPro1,1
Serial:       C02YR0P4HX87
Board Serial: C02921403GUJG361M
SmUUID:       C78432D1-0ECB-4F11-BAED-CA56A9E99AFE

Press [enter] to return...
  #######################################################
 #                     GenSMBIOS                       #
#######################################################

MacSerial v2.1.2
Current plist: None
Plist type:    Unknown

1. Install/Update MacSerial
2. Select config.plist
3. Generate SMBIOS
4. Generate UUID
5. List Current SMBIOS

Q. Quit

Please select an option:  q
  #######################################################
 #                     GenSMBIOS                       #
#######################################################
by CorpNewt

Thanks for testing it out, for bugs/comments/complaints
send me a message on Reddit, or check out my GitHub:

www.reddit.com/u/corpnewt
www.github.com/corpnewt

Have a nice night!


[23:02:38]yy@vubuntu:~/___$ 

```
