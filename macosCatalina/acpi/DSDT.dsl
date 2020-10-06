/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20190509 (64-bit version)
 * Copyright (c) 2000 - 2019 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of DSDT.aml, Sun Oct  4 14:39:59 2020
 *
 * Original Table Header:
 *     Signature        "DSDT"
 *     Length           0x0000242F (9263)
 *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
 *     Checksum         0x26
 *     OEM ID           "BOCHS "
 *     OEM Table ID     "BXPCDSDT"
 *     OEM Revision     0x00000001 (1)
 *     Compiler ID      "BXPC"
 *     Compiler Version 0x00000001 (1)
 */
DefinitionBlock ("", "DSDT", 1, "BOCHS ", "BXPCDSDT", 0x00000001)
{
    Scope (\)
    {
        OperationRegion (DBG, SystemIO, 0x0402, One)
        Field (DBG, ByteAcc, NoLock, Preserve)
        {
            DBGB,   8
        }

        Method (DBUG, 1, NotSerialized)
        {
            ToHexString (Arg0, Local0)
            ToBuffer (Local0, Local0)
            Local1 = (SizeOf (Local0) - One)
            Local2 = Zero
            While ((Local2 < Local1))
            {
                DBGB = DerefOf (Local0 [Local2])
                Local2++
            }

            DBGB = 0x0A
        }
    }

    Scope (_SB)
    {
        Device (PCI0)
        {
            Name (_HID, EisaId ("PNP0A08") /* PCI Express Bus */)  // _HID: Hardware ID
            Name (_CID, EisaId ("PNP0A03") /* PCI Bus */)  // _CID: Compatible ID
            Name (_ADR, Zero)  // _ADR: Address
            Name (_UID, One)  // _UID: Unique ID
            Method (_OSC, 4, NotSerialized)  // _OSC: Operating System Capabilities
            {
                CreateDWordField (Arg3, Zero, CDW1)
                If ((Arg0 == ToUUID ("33db4d5b-1ff7-401c-9657-7441c03dd766") /* PCI Host Bridge Device */))
                {
                    CreateDWordField (Arg3, 0x04, CDW2)
                    CreateDWordField (Arg3, 0x08, CDW3)
                    Local0 = CDW3 /* \_SB_.PCI0._OSC.CDW3 */
                    Local0 &= 0x1F
                    If ((Arg1 != One))
                    {
                        CDW1 |= 0x08
                    }

                    If ((CDW3 != Local0))
                    {
                        CDW1 |= 0x10
                    }

                    CDW3 = Local0
                }
                Else
                {
                    CDW1 |= 0x04
                }

                Return (Arg3)
            }
        }
    }

    Scope (_SB)
    {
        Device (HPET)
        {
            Name (_HID, EisaId ("PNP0103") /* HPET System Timer */)  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            OperationRegion (HPTM, SystemMemory, 0xFED00000, 0x0400)
            Field (HPTM, DWordAcc, Lock, Preserve)
            {
                VEND,   32, 
                PRD,    32
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Local0 = VEND /* \_SB_.HPET.VEND */
                Local1 = PRD /* \_SB_.HPET.PRD_ */
                Local0 >>= 0x10
                If (((Local0 == Zero) || (Local0 == 0xFFFF)))
                {
                    Return (Zero)
                }

                If (((Local1 == Zero) || (Local1 > 0x05F5E100)))
                {
                    Return (Zero)
                }

                Return (0x0F)
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadOnly,
                    0xFED00000,         // Address Base
                    0x00000400,         // Address Length
                    )
            })
        }
    }

    Scope (_SB.PCI0)
    {
        Device (ISA)
        {
            Name (_ADR, 0x001F0000)  // _ADR: Address
            OperationRegion (PIRQ, PCI_Config, 0x60, 0x0C)
            OperationRegion (LPCD, PCI_Config, 0x80, 0x02)
            Field (LPCD, AnyAcc, NoLock, Preserve)
            {
                COMA,   3, 
                    ,   1, 
                COMB,   3, 
                Offset (0x01), 
                LPTD,   2
            }

            OperationRegion (LPCE, PCI_Config, 0x82, 0x02)
            Field (LPCE, AnyAcc, NoLock, Preserve)
            {
                CAEN,   1, 
                CBEN,   1, 
                LPEN,   1
            }
        }
    }

    Scope (_SB.PCI0.ISA)
    {
        Device (RTC)
        {
            Name (_HID, EisaId ("PNP0B00") /* AT Real-Time Clock */)  // _HID: Hardware ID
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                IO (Decode16,
                    0x0070,             // Range Minimum
                    0x0070,             // Range Maximum
                    0x10,               // Alignment
                    0x02,               // Length
                    )
                IRQNoFlags ()
                    {8}
                IO (Decode16,
                    0x0072,             // Range Minimum
                    0x0072,             // Range Maximum
                    0x02,               // Alignment
                    0x06,               // Length
                    )
            })
        }

        Device (KBD)
        {
            Name (_HID, EisaId ("PNP0303") /* IBM Enhanced Keyboard (101/102-key, PS/2 Mouse) */)  // _HID: Hardware ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (0x0F)
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                IO (Decode16,
                    0x0060,             // Range Minimum
                    0x0060,             // Range Maximum
                    0x01,               // Alignment
                    0x01,               // Length
                    )
                IO (Decode16,
                    0x0064,             // Range Minimum
                    0x0064,             // Range Maximum
                    0x01,               // Alignment
                    0x01,               // Length
                    )
                IRQNoFlags ()
                    {1}
            })
        }

        Device (MOU)
        {
            Name (_HID, EisaId ("PNP0F13") /* PS/2 Mouse */)  // _HID: Hardware ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (0x0F)
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                IRQNoFlags ()
                    {12}
            })
        }

        Device (LPT)
        {
            Name (_HID, EisaId ("PNP0400") /* Standard LPT Parallel Port */)  // _HID: Hardware ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Local0 = LPEN /* \_SB_.PCI0.ISA_.LPEN */
                If ((Local0 == Zero))
                {
                    Return (Zero)
                }
                Else
                {
                    Return (0x0F)
                }
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                IO (Decode16,
                    0x0378,             // Range Minimum
                    0x0378,             // Range Maximum
                    0x08,               // Alignment
                    0x08,               // Length
                    )
                IRQNoFlags ()
                    {7}
            })
        }

        Device (COM1)
        {
            Name (_HID, EisaId ("PNP0501") /* 16550A-compatible COM Serial Port */)  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Local0 = CAEN /* \_SB_.PCI0.ISA_.CAEN */
                If ((Local0 == Zero))
                {
                    Return (Zero)
                }
                Else
                {
                    Return (0x0F)
                }
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                IO (Decode16,
                    0x03F8,             // Range Minimum
                    0x03F8,             // Range Maximum
                    0x00,               // Alignment
                    0x08,               // Length
                    )
                IRQNoFlags ()
                    {4}
            })
        }

        Device (COM2)
        {
            Name (_HID, EisaId ("PNP0501") /* 16550A-compatible COM Serial Port */)  // _HID: Hardware ID
            Name (_UID, 0x02)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Local0 = CBEN /* \_SB_.PCI0.ISA_.CBEN */
                If ((Local0 == Zero))
                {
                    Return (Zero)
                }
                Else
                {
                    Return (0x0F)
                }
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                IO (Decode16,
                    0x02F8,             // Range Minimum
                    0x02F8,             // Range Maximum
                    0x00,               // Alignment
                    0x08,               // Length
                    )
                IRQNoFlags ()
                    {3}
            })
        }
    }

    Name (PICF, Zero)
    Method (_PIC, 1, NotSerialized)  // _PIC: Interrupt Model
    {
        PICF = Arg0
    }

    Scope (_SB)
    {
        Scope (PCI0)
        {
            Name (PRTP, Package (0x80)
            {
                Package (0x04)
                {
                    0xFFFF, 
                    Zero, 
                    LNKE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0xFFFF, 
                    One, 
                    LNKF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0xFFFF, 
                    0x02, 
                    LNKG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0xFFFF, 
                    0x03, 
                    LNKH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0001FFFF, 
                    Zero, 
                    LNKF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0001FFFF, 
                    One, 
                    LNKG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0001FFFF, 
                    0x02, 
                    LNKH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0001FFFF, 
                    0x03, 
                    LNKE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0002FFFF, 
                    Zero, 
                    LNKG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0002FFFF, 
                    One, 
                    LNKH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0002FFFF, 
                    0x02, 
                    LNKE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0002FFFF, 
                    0x03, 
                    LNKF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0003FFFF, 
                    Zero, 
                    LNKH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0003FFFF, 
                    One, 
                    LNKE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0003FFFF, 
                    0x02, 
                    LNKF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0003FFFF, 
                    0x03, 
                    LNKG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0004FFFF, 
                    Zero, 
                    LNKE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0004FFFF, 
                    One, 
                    LNKF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0004FFFF, 
                    0x02, 
                    LNKG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0004FFFF, 
                    0x03, 
                    LNKH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0005FFFF, 
                    Zero, 
                    LNKF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0005FFFF, 
                    One, 
                    LNKG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0005FFFF, 
                    0x02, 
                    LNKH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0005FFFF, 
                    0x03, 
                    LNKE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0006FFFF, 
                    Zero, 
                    LNKG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0006FFFF, 
                    One, 
                    LNKH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0006FFFF, 
                    0x02, 
                    LNKE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0006FFFF, 
                    0x03, 
                    LNKF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0007FFFF, 
                    Zero, 
                    LNKH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0007FFFF, 
                    One, 
                    LNKE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0007FFFF, 
                    0x02, 
                    LNKF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0007FFFF, 
                    0x03, 
                    LNKG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0008FFFF, 
                    Zero, 
                    LNKE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0008FFFF, 
                    One, 
                    LNKF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0008FFFF, 
                    0x02, 
                    LNKG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0008FFFF, 
                    0x03, 
                    LNKH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0009FFFF, 
                    Zero, 
                    LNKF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0009FFFF, 
                    One, 
                    LNKG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0009FFFF, 
                    0x02, 
                    LNKH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0009FFFF, 
                    0x03, 
                    LNKE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000AFFFF, 
                    Zero, 
                    LNKG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000AFFFF, 
                    One, 
                    LNKH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000AFFFF, 
                    0x02, 
                    LNKE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000AFFFF, 
                    0x03, 
                    LNKF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000BFFFF, 
                    Zero, 
                    LNKH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000BFFFF, 
                    One, 
                    LNKE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000BFFFF, 
                    0x02, 
                    LNKF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000BFFFF, 
                    0x03, 
                    LNKG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000CFFFF, 
                    Zero, 
                    LNKE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000CFFFF, 
                    One, 
                    LNKF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000CFFFF, 
                    0x02, 
                    LNKG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000CFFFF, 
                    0x03, 
                    LNKH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000DFFFF, 
                    Zero, 
                    LNKF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000DFFFF, 
                    One, 
                    LNKG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000DFFFF, 
                    0x02, 
                    LNKH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000DFFFF, 
                    0x03, 
                    LNKE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000EFFFF, 
                    Zero, 
                    LNKG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000EFFFF, 
                    One, 
                    LNKH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000EFFFF, 
                    0x02, 
                    LNKE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000EFFFF, 
                    0x03, 
                    LNKF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000FFFFF, 
                    Zero, 
                    LNKH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000FFFFF, 
                    One, 
                    LNKE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000FFFFF, 
                    0x02, 
                    LNKF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000FFFFF, 
                    0x03, 
                    LNKG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0010FFFF, 
                    Zero, 
                    LNKE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0010FFFF, 
                    One, 
                    LNKF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0010FFFF, 
                    0x02, 
                    LNKG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0010FFFF, 
                    0x03, 
                    LNKH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0011FFFF, 
                    Zero, 
                    LNKF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0011FFFF, 
                    One, 
                    LNKG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0011FFFF, 
                    0x02, 
                    LNKH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0011FFFF, 
                    0x03, 
                    LNKE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0012FFFF, 
                    Zero, 
                    LNKG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0012FFFF, 
                    One, 
                    LNKH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0012FFFF, 
                    0x02, 
                    LNKE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0012FFFF, 
                    0x03, 
                    LNKF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0013FFFF, 
                    Zero, 
                    LNKH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0013FFFF, 
                    One, 
                    LNKE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0013FFFF, 
                    0x02, 
                    LNKF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0013FFFF, 
                    0x03, 
                    LNKG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0014FFFF, 
                    Zero, 
                    LNKE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0014FFFF, 
                    One, 
                    LNKF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0014FFFF, 
                    0x02, 
                    LNKG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0014FFFF, 
                    0x03, 
                    LNKH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0015FFFF, 
                    Zero, 
                    LNKF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0015FFFF, 
                    One, 
                    LNKG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0015FFFF, 
                    0x02, 
                    LNKH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0015FFFF, 
                    0x03, 
                    LNKE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0016FFFF, 
                    Zero, 
                    LNKG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0016FFFF, 
                    One, 
                    LNKH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0016FFFF, 
                    0x02, 
                    LNKE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0016FFFF, 
                    0x03, 
                    LNKF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0017FFFF, 
                    Zero, 
                    LNKH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0017FFFF, 
                    One, 
                    LNKE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0017FFFF, 
                    0x02, 
                    LNKF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0017FFFF, 
                    0x03, 
                    LNKG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0018FFFF, 
                    Zero, 
                    LNKE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0018FFFF, 
                    One, 
                    LNKF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0018FFFF, 
                    0x02, 
                    LNKG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0018FFFF, 
                    0x03, 
                    LNKH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0019FFFF, 
                    Zero, 
                    LNKA, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0019FFFF, 
                    One, 
                    LNKB, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0019FFFF, 
                    0x02, 
                    LNKC, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0019FFFF, 
                    0x03, 
                    LNKD, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001AFFFF, 
                    Zero, 
                    LNKA, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001AFFFF, 
                    One, 
                    LNKB, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001AFFFF, 
                    0x02, 
                    LNKC, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001AFFFF, 
                    0x03, 
                    LNKD, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001BFFFF, 
                    Zero, 
                    LNKA, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001BFFFF, 
                    One, 
                    LNKB, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001BFFFF, 
                    0x02, 
                    LNKC, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001BFFFF, 
                    0x03, 
                    LNKD, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001CFFFF, 
                    Zero, 
                    LNKA, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001CFFFF, 
                    One, 
                    LNKB, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001CFFFF, 
                    0x02, 
                    LNKC, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001CFFFF, 
                    0x03, 
                    LNKD, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001DFFFF, 
                    Zero, 
                    LNKA, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001DFFFF, 
                    One, 
                    LNKB, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001DFFFF, 
                    0x02, 
                    LNKC, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001DFFFF, 
                    0x03, 
                    LNKD, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001EFFFF, 
                    Zero, 
                    LNKE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001EFFFF, 
                    One, 
                    LNKF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001EFFFF, 
                    0x02, 
                    LNKG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001EFFFF, 
                    0x03, 
                    LNKH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001FFFFF, 
                    Zero, 
                    LNKA, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001FFFFF, 
                    One, 
                    LNKB, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001FFFFF, 
                    0x02, 
                    LNKC, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001FFFFF, 
                    0x03, 
                    LNKD, 
                    Zero
                }
            })
            Name (PRTA, Package (0x80)
            {
                Package (0x04)
                {
                    0xFFFF, 
                    Zero, 
                    GSIE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0xFFFF, 
                    One, 
                    GSIF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0xFFFF, 
                    0x02, 
                    GSIG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0xFFFF, 
                    0x03, 
                    GSIH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0001FFFF, 
                    Zero, 
                    GSIF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0001FFFF, 
                    One, 
                    GSIG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0001FFFF, 
                    0x02, 
                    GSIH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0001FFFF, 
                    0x03, 
                    GSIE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0002FFFF, 
                    Zero, 
                    GSIG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0002FFFF, 
                    One, 
                    GSIH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0002FFFF, 
                    0x02, 
                    GSIE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0002FFFF, 
                    0x03, 
                    GSIF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0003FFFF, 
                    Zero, 
                    GSIH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0003FFFF, 
                    One, 
                    GSIE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0003FFFF, 
                    0x02, 
                    GSIF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0003FFFF, 
                    0x03, 
                    GSIG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0004FFFF, 
                    Zero, 
                    GSIE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0004FFFF, 
                    One, 
                    GSIF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0004FFFF, 
                    0x02, 
                    GSIG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0004FFFF, 
                    0x03, 
                    GSIH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0005FFFF, 
                    Zero, 
                    GSIF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0005FFFF, 
                    One, 
                    GSIG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0005FFFF, 
                    0x02, 
                    GSIH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0005FFFF, 
                    0x03, 
                    GSIE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0006FFFF, 
                    Zero, 
                    GSIG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0006FFFF, 
                    One, 
                    GSIH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0006FFFF, 
                    0x02, 
                    GSIE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0006FFFF, 
                    0x03, 
                    GSIF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0007FFFF, 
                    Zero, 
                    GSIH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0007FFFF, 
                    One, 
                    GSIE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0007FFFF, 
                    0x02, 
                    GSIF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0007FFFF, 
                    0x03, 
                    GSIG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0008FFFF, 
                    Zero, 
                    GSIE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0008FFFF, 
                    One, 
                    GSIF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0008FFFF, 
                    0x02, 
                    GSIG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0008FFFF, 
                    0x03, 
                    GSIH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0009FFFF, 
                    Zero, 
                    GSIF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0009FFFF, 
                    One, 
                    GSIG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0009FFFF, 
                    0x02, 
                    GSIH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0009FFFF, 
                    0x03, 
                    GSIE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000AFFFF, 
                    Zero, 
                    GSIG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000AFFFF, 
                    One, 
                    GSIH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000AFFFF, 
                    0x02, 
                    GSIE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000AFFFF, 
                    0x03, 
                    GSIF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000BFFFF, 
                    Zero, 
                    GSIH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000BFFFF, 
                    One, 
                    GSIE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000BFFFF, 
                    0x02, 
                    GSIF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000BFFFF, 
                    0x03, 
                    GSIG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000CFFFF, 
                    Zero, 
                    GSIE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000CFFFF, 
                    One, 
                    GSIF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000CFFFF, 
                    0x02, 
                    GSIG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000CFFFF, 
                    0x03, 
                    GSIH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000DFFFF, 
                    Zero, 
                    GSIF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000DFFFF, 
                    One, 
                    GSIG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000DFFFF, 
                    0x02, 
                    GSIH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000DFFFF, 
                    0x03, 
                    GSIE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000EFFFF, 
                    Zero, 
                    GSIG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000EFFFF, 
                    One, 
                    GSIH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000EFFFF, 
                    0x02, 
                    GSIE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000EFFFF, 
                    0x03, 
                    GSIF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000FFFFF, 
                    Zero, 
                    GSIH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000FFFFF, 
                    One, 
                    GSIE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000FFFFF, 
                    0x02, 
                    GSIF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000FFFFF, 
                    0x03, 
                    GSIG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0010FFFF, 
                    Zero, 
                    GSIE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0010FFFF, 
                    One, 
                    GSIF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0010FFFF, 
                    0x02, 
                    GSIG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0010FFFF, 
                    0x03, 
                    GSIH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0011FFFF, 
                    Zero, 
                    GSIF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0011FFFF, 
                    One, 
                    GSIG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0011FFFF, 
                    0x02, 
                    GSIH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0011FFFF, 
                    0x03, 
                    GSIE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0012FFFF, 
                    Zero, 
                    GSIG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0012FFFF, 
                    One, 
                    GSIH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0012FFFF, 
                    0x02, 
                    GSIE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0012FFFF, 
                    0x03, 
                    GSIF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0013FFFF, 
                    Zero, 
                    GSIH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0013FFFF, 
                    One, 
                    GSIE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0013FFFF, 
                    0x02, 
                    GSIF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0013FFFF, 
                    0x03, 
                    GSIG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0014FFFF, 
                    Zero, 
                    GSIE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0014FFFF, 
                    One, 
                    GSIF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0014FFFF, 
                    0x02, 
                    GSIG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0014FFFF, 
                    0x03, 
                    GSIH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0015FFFF, 
                    Zero, 
                    GSIF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0015FFFF, 
                    One, 
                    GSIG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0015FFFF, 
                    0x02, 
                    GSIH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0015FFFF, 
                    0x03, 
                    GSIE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0016FFFF, 
                    Zero, 
                    GSIG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0016FFFF, 
                    One, 
                    GSIH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0016FFFF, 
                    0x02, 
                    GSIE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0016FFFF, 
                    0x03, 
                    GSIF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0017FFFF, 
                    Zero, 
                    GSIH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0017FFFF, 
                    One, 
                    GSIE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0017FFFF, 
                    0x02, 
                    GSIF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0017FFFF, 
                    0x03, 
                    GSIG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0018FFFF, 
                    Zero, 
                    GSIE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0018FFFF, 
                    One, 
                    GSIF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0018FFFF, 
                    0x02, 
                    GSIG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0018FFFF, 
                    0x03, 
                    GSIH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0019FFFF, 
                    Zero, 
                    GSIA, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0019FFFF, 
                    One, 
                    GSIB, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0019FFFF, 
                    0x02, 
                    GSIC, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0019FFFF, 
                    0x03, 
                    GSID, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001AFFFF, 
                    Zero, 
                    GSIA, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001AFFFF, 
                    One, 
                    GSIB, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001AFFFF, 
                    0x02, 
                    GSIC, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001AFFFF, 
                    0x03, 
                    GSID, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001BFFFF, 
                    Zero, 
                    GSIA, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001BFFFF, 
                    One, 
                    GSIB, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001BFFFF, 
                    0x02, 
                    GSIC, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001BFFFF, 
                    0x03, 
                    GSID, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001CFFFF, 
                    Zero, 
                    GSIA, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001CFFFF, 
                    One, 
                    GSIB, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001CFFFF, 
                    0x02, 
                    GSIC, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001CFFFF, 
                    0x03, 
                    GSID, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001DFFFF, 
                    Zero, 
                    GSIA, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001DFFFF, 
                    One, 
                    GSIB, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001DFFFF, 
                    0x02, 
                    GSIC, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001DFFFF, 
                    0x03, 
                    GSID, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001EFFFF, 
                    Zero, 
                    GSIE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001EFFFF, 
                    One, 
                    GSIF, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001EFFFF, 
                    0x02, 
                    GSIG, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001EFFFF, 
                    0x03, 
                    GSIH, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001FFFFF, 
                    Zero, 
                    GSIA, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001FFFFF, 
                    One, 
                    GSIB, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001FFFFF, 
                    0x02, 
                    GSIC, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001FFFFF, 
                    0x03, 
                    GSID, 
                    Zero
                }
            })
            Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
            {
                If ((PICF == Zero))
                {
                    Return (PRTP) /* \_SB_.PCI0.PRTP */
                }
                Else
                {
                    Return (PRTA) /* \_SB_.PCI0.PRTA */
                }
            }
        }

        Field (PCI0.ISA.PIRQ, ByteAcc, NoLock, Preserve)
        {
            PRQA,   8, 
            PRQB,   8, 
            PRQC,   8, 
            PRQD,   8, 
            Offset (0x08), 
            PRQE,   8, 
            PRQF,   8, 
            PRQG,   8, 
            PRQH,   8
        }

        Method (IQST, 1, NotSerialized)
        {
            If ((0x80 & Arg0))
            {
                Return (0x09)
            }

            Return (0x0B)
        }

        Method (IQCR, 1, Serialized)
        {
            Name (PRR0, ResourceTemplate ()
            {
                Interrupt (ResourceConsumer, Level, ActiveHigh, Shared, ,, _Y00)
                {
                    0x00000000,
                }
            })
            CreateDWordField (PRR0, \_SB.IQCR._Y00._INT, PRRI)  // _INT: Interrupts
            PRRI = (Arg0 & 0x0F)
            Return (PRR0) /* \_SB_.IQCR.PRR0 */
        }

        Device (LNKA)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
            {
                Interrupt (ResourceConsumer, Level, ActiveHigh, Shared, ,, )
                {
                    0x00000005,
                    0x0000000A,
                    0x0000000B,
                }
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (IQST (PRQA))
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
                PRQA |= 0x80
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Return (IQCR (PRQA))
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
                CreateDWordField (Arg0, 0x05, PRRI)
                PRQA = PRRI /* \_SB_.LNKA._SRS.PRRI */
            }
        }

        Device (LNKB)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
            {
                Interrupt (ResourceConsumer, Level, ActiveHigh, Shared, ,, )
                {
                    0x00000005,
                    0x0000000A,
                    0x0000000B,
                }
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (IQST (PRQB))
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
                PRQB |= 0x80
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Return (IQCR (PRQB))
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
                CreateDWordField (Arg0, 0x05, PRRI)
                PRQB = PRRI /* \_SB_.LNKB._SRS.PRRI */
            }
        }

        Device (LNKC)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, 0x02)  // _UID: Unique ID
            Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
            {
                Interrupt (ResourceConsumer, Level, ActiveHigh, Shared, ,, )
                {
                    0x00000005,
                    0x0000000A,
                    0x0000000B,
                }
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (IQST (PRQC))
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
                PRQC |= 0x80
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Return (IQCR (PRQC))
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
                CreateDWordField (Arg0, 0x05, PRRI)
                PRQC = PRRI /* \_SB_.LNKC._SRS.PRRI */
            }
        }

        Device (LNKD)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, 0x03)  // _UID: Unique ID
            Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
            {
                Interrupt (ResourceConsumer, Level, ActiveHigh, Shared, ,, )
                {
                    0x00000005,
                    0x0000000A,
                    0x0000000B,
                }
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (IQST (PRQD))
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
                PRQD |= 0x80
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Return (IQCR (PRQD))
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
                CreateDWordField (Arg0, 0x05, PRRI)
                PRQD = PRRI /* \_SB_.LNKD._SRS.PRRI */
            }
        }

        Device (LNKE)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, 0x04)  // _UID: Unique ID
            Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
            {
                Interrupt (ResourceConsumer, Level, ActiveHigh, Shared, ,, )
                {
                    0x00000005,
                    0x0000000A,
                    0x0000000B,
                }
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (IQST (PRQE))
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
                PRQE |= 0x80
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Return (IQCR (PRQE))
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
                CreateDWordField (Arg0, 0x05, PRRI)
                PRQE = PRRI /* \_SB_.LNKE._SRS.PRRI */
            }
        }

        Device (LNKF)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, 0x05)  // _UID: Unique ID
            Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
            {
                Interrupt (ResourceConsumer, Level, ActiveHigh, Shared, ,, )
                {
                    0x00000005,
                    0x0000000A,
                    0x0000000B,
                }
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (IQST (PRQF))
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
                PRQF |= 0x80
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Return (IQCR (PRQF))
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
                CreateDWordField (Arg0, 0x05, PRRI)
                PRQF = PRRI /* \_SB_.LNKF._SRS.PRRI */
            }
        }

        Device (LNKG)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, 0x06)  // _UID: Unique ID
            Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
            {
                Interrupt (ResourceConsumer, Level, ActiveHigh, Shared, ,, )
                {
                    0x00000005,
                    0x0000000A,
                    0x0000000B,
                }
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (IQST (PRQG))
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
                PRQG |= 0x80
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Return (IQCR (PRQG))
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
                CreateDWordField (Arg0, 0x05, PRRI)
                PRQG = PRRI /* \_SB_.LNKG._SRS.PRRI */
            }
        }

        Device (LNKH)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, 0x07)  // _UID: Unique ID
            Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
            {
                Interrupt (ResourceConsumer, Level, ActiveHigh, Shared, ,, )
                {
                    0x00000005,
                    0x0000000A,
                    0x0000000B,
                }
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (IQST (PRQH))
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
                PRQH |= 0x80
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Return (IQCR (PRQH))
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
                CreateDWordField (Arg0, 0x05, PRRI)
                PRQH = PRRI /* \_SB_.LNKH._SRS.PRRI */
            }
        }

        Device (GSIA)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, 0x10)  // _UID: Unique ID
            Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
            {
                Interrupt (ResourceConsumer, Level, ActiveHigh, Shared, ,, )
                {
                    0x00000010,
                }
            })
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Interrupt (ResourceConsumer, Level, ActiveHigh, Shared, ,, )
                {
                    0x00000010,
                }
            })
            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
            }
        }

        Device (GSIB)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, 0x11)  // _UID: Unique ID
            Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
            {
                Interrupt (ResourceConsumer, Level, ActiveHigh, Shared, ,, )
                {
                    0x00000011,
                }
            })
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Interrupt (ResourceConsumer, Level, ActiveHigh, Shared, ,, )
                {
                    0x00000011,
                }
            })
            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
            }
        }

        Device (GSIC)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, 0x12)  // _UID: Unique ID
            Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
            {
                Interrupt (ResourceConsumer, Level, ActiveHigh, Shared, ,, )
                {
                    0x00000012,
                }
            })
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Interrupt (ResourceConsumer, Level, ActiveHigh, Shared, ,, )
                {
                    0x00000012,
                }
            })
            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
            }
        }

        Device (GSID)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, 0x13)  // _UID: Unique ID
            Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
            {
                Interrupt (ResourceConsumer, Level, ActiveHigh, Shared, ,, )
                {
                    0x00000013,
                }
            })
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Interrupt (ResourceConsumer, Level, ActiveHigh, Shared, ,, )
                {
                    0x00000013,
                }
            })
            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
            }
        }

        Device (GSIE)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, 0x14)  // _UID: Unique ID
            Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
            {
                Interrupt (ResourceConsumer, Level, ActiveHigh, Shared, ,, )
                {
                    0x00000014,
                }
            })
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Interrupt (ResourceConsumer, Level, ActiveHigh, Shared, ,, )
                {
                    0x00000014,
                }
            })
            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
            }
        }

        Device (GSIF)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, 0x15)  // _UID: Unique ID
            Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
            {
                Interrupt (ResourceConsumer, Level, ActiveHigh, Shared, ,, )
                {
                    0x00000015,
                }
            })
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Interrupt (ResourceConsumer, Level, ActiveHigh, Shared, ,, )
                {
                    0x00000015,
                }
            })
            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
            }
        }

        Device (GSIG)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, 0x16)  // _UID: Unique ID
            Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
            {
                Interrupt (ResourceConsumer, Level, ActiveHigh, Shared, ,, )
                {
                    0x00000016,
                }
            })
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Interrupt (ResourceConsumer, Level, ActiveHigh, Shared, ,, )
                {
                    0x00000016,
                }
            })
            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
            }
        }

        Device (GSIH)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, 0x17)  // _UID: Unique ID
            Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
            {
                Interrupt (ResourceConsumer, Level, ActiveHigh, Shared, ,, )
                {
                    0x00000017,
                }
            })
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Interrupt (ResourceConsumer, Level, ActiveHigh, Shared, ,, )
                {
                    0x00000017,
                }
            })
            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
            }
        }
    }

    Scope (_SB.PCI0)
    {
        Device (SMB0)
        {
            Name (_HID, EisaId ("APP0005"))  // _HID: Hardware ID
            Name (_ADR, 0x001F0003)  // _ADR: Address
        }
    }

    Scope (_SB)
    {
        Device (\_SB.PCI0.PRES)
        {
            Name (_HID, EisaId ("PNP0A06") /* Generic Container Device */)  // _HID: Hardware ID
            Name (_UID, "CPU Hotplug resources")  // _UID: Unique ID
            Mutex (CPLK, 0x00)
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                IO (Decode16,
                    0x0CD8,             // Range Minimum
                    0x0CD8,             // Range Maximum
                    0x01,               // Alignment
                    0x0C,               // Length
                    )
            })
            OperationRegion (PRST, SystemIO, 0x0CD8, 0x0C)
            Field (PRST, ByteAcc, NoLock, WriteAsZeros)
            {
                Offset (0x04), 
                CPEN,   1, 
                CINS,   1, 
                CRMV,   1, 
                CEJ0,   1, 
                Offset (0x05), 
                CCMD,   8
            }

            Field (PRST, DWordAcc, NoLock, Preserve)
            {
                CSEL,   32, 
                Offset (0x08), 
                CDAT,   32
            }

            Method (_INI, 0, Serialized)  // _INI: Initialize
            {
                CSEL = Zero
            }
        }

        Device (\_SB.CPUS)
        {
            Name (_HID, "ACPI0010" /* Processor Container Device */)  // _HID: Hardware ID
            Name (_CID, EisaId ("PNP0A05") /* Generic Container Device */)  // _CID: Compatible ID
            Method (CTFY, 2, NotSerialized)
            {
                If ((Arg0 == Zero))
                {
                    Notify (C000, Arg1)
                }

                If ((Arg0 == One))
                {
                    Notify (C001, Arg1)
                }

                If ((Arg0 == 0x02))
                {
                    Notify (C002, Arg1)
                }

                If ((Arg0 == 0x03))
                {
                    Notify (C003, Arg1)
                }

                If ((Arg0 == 0x04))
                {
                    Notify (C004, Arg1)
                }

                If ((Arg0 == 0x05))
                {
                    Notify (C005, Arg1)
                }

                If ((Arg0 == 0x06))
                {
                    Notify (C006, Arg1)
                }

                If ((Arg0 == 0x07))
                {
                    Notify (C007, Arg1)
                }

                If ((Arg0 == 0x08))
                {
                    Notify (C008, Arg1)
                }

                If ((Arg0 == 0x09))
                {
                    Notify (C009, Arg1)
                }

                If ((Arg0 == 0x0A))
                {
                    Notify (C00A, Arg1)
                }

                If ((Arg0 == 0x0B))
                {
                    Notify (C00B, Arg1)
                }

                If ((Arg0 == 0x0C))
                {
                    Notify (C00C, Arg1)
                }

                If ((Arg0 == 0x0D))
                {
                    Notify (C00D, Arg1)
                }

                If ((Arg0 == 0x0E))
                {
                    Notify (C00E, Arg1)
                }

                If ((Arg0 == 0x0F))
                {
                    Notify (C00F, Arg1)
                }
            }

            Method (CSTA, 1, Serialized)
            {
                Acquire (\_SB.PCI0.PRES.CPLK, 0xFFFF)
                \_SB.PCI0.PRES.CSEL = Arg0
                Local0 = Zero
                If ((\_SB.PCI0.PRES.CPEN == One))
                {
                    Local0 = 0x0F
                }

                Release (\_SB.PCI0.PRES.CPLK)
                Return (Local0)
            }

            Method (CEJ0, 1, Serialized)
            {
                Acquire (\_SB.PCI0.PRES.CPLK, 0xFFFF)
                \_SB.PCI0.PRES.CSEL = Arg0
                \_SB.PCI0.PRES.CEJ0 = One
                Release (\_SB.PCI0.PRES.CPLK)
            }

            Method (CSCN, 0, Serialized)
            {
                Acquire (\_SB.PCI0.PRES.CPLK, 0xFFFF)
                Local0 = One
                While ((Local0 == One))
                {
                    Local0 = Zero
                    \_SB.PCI0.PRES.CCMD = Zero
                    If ((\_SB.PCI0.PRES.CINS == One))
                    {
                        CTFY (\_SB.PCI0.PRES.CDAT, One)
                        \_SB.PCI0.PRES.CINS = One
                        Local0 = One
                    }
                    ElseIf ((\_SB.PCI0.PRES.CRMV == One))
                    {
                        CTFY (\_SB.PCI0.PRES.CDAT, 0x03)
                        \_SB.PCI0.PRES.CRMV = One
                        Local0 = One
                    }
                }

                Release (\_SB.PCI0.PRES.CPLK)
            }

            Method (COST, 4, Serialized)
            {
                Acquire (\_SB.PCI0.PRES.CPLK, 0xFFFF)
                \_SB.PCI0.PRES.CSEL = Arg0
                \_SB.PCI0.PRES.CCMD = One
                \_SB.PCI0.PRES.CDAT = Arg1
                \_SB.PCI0.PRES.CCMD = 0x02
                \_SB.PCI0.PRES.CDAT = Arg2
                Release (\_SB.PCI0.PRES.CPLK)
            }

            Processor (C000, 0x00, 0x00000000, 0x00)
            {
                Method (_STA, 0, Serialized)  // _STA: Status
                {
                    Return (CSTA (Zero))
                }

                Name (_MAT, Buffer (0x08)  // _MAT: Multiple APIC Table Entry
                {
                     0x00, 0x08, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00   // ........
                })
                Method (_OST, 3, Serialized)  // _OST: OSPM Status Indication
                {
                    COST (Zero, Arg0, Arg1, Arg2)
                }
            }

            Processor (C001, 0x01, 0x00000000, 0x00)
            {
                Method (_STA, 0, Serialized)  // _STA: Status
                {
                    Return (CSTA (One))
                }

                Name (_MAT, Buffer (0x08)  // _MAT: Multiple APIC Table Entry
                {
                     0x00, 0x08, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00   // ........
                })
                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device, x=0-9
                {
                    CEJ0 (One)
                }

                Method (_OST, 3, Serialized)  // _OST: OSPM Status Indication
                {
                    COST (One, Arg0, Arg1, Arg2)
                }
            }

            Processor (C002, 0x02, 0x00000000, 0x00)
            {
                Method (_STA, 0, Serialized)  // _STA: Status
                {
                    Return (CSTA (0x02))
                }

                Name (_MAT, Buffer (0x08)  // _MAT: Multiple APIC Table Entry
                {
                     0x00, 0x08, 0x02, 0x02, 0x01, 0x00, 0x00, 0x00   // ........
                })
                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device, x=0-9
                {
                    CEJ0 (0x02)
                }

                Method (_OST, 3, Serialized)  // _OST: OSPM Status Indication
                {
                    COST (0x02, Arg0, Arg1, Arg2)
                }
            }

            Processor (C003, 0x03, 0x00000000, 0x00)
            {
                Method (_STA, 0, Serialized)  // _STA: Status
                {
                    Return (CSTA (0x03))
                }

                Name (_MAT, Buffer (0x08)  // _MAT: Multiple APIC Table Entry
                {
                     0x00, 0x08, 0x03, 0x03, 0x01, 0x00, 0x00, 0x00   // ........
                })
                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device, x=0-9
                {
                    CEJ0 (0x03)
                }

                Method (_OST, 3, Serialized)  // _OST: OSPM Status Indication
                {
                    COST (0x03, Arg0, Arg1, Arg2)
                }
            }

            Processor (C004, 0x04, 0x00000000, 0x00)
            {
                Method (_STA, 0, Serialized)  // _STA: Status
                {
                    Return (CSTA (0x04))
                }

                Name (_MAT, Buffer (0x08)  // _MAT: Multiple APIC Table Entry
                {
                     0x00, 0x08, 0x04, 0x04, 0x01, 0x00, 0x00, 0x00   // ........
                })
                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device, x=0-9
                {
                    CEJ0 (0x04)
                }

                Method (_OST, 3, Serialized)  // _OST: OSPM Status Indication
                {
                    COST (0x04, Arg0, Arg1, Arg2)
                }
            }

            Processor (C005, 0x05, 0x00000000, 0x00)
            {
                Method (_STA, 0, Serialized)  // _STA: Status
                {
                    Return (CSTA (0x05))
                }

                Name (_MAT, Buffer (0x08)  // _MAT: Multiple APIC Table Entry
                {
                     0x00, 0x08, 0x05, 0x05, 0x01, 0x00, 0x00, 0x00   // ........
                })
                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device, x=0-9
                {
                    CEJ0 (0x05)
                }

                Method (_OST, 3, Serialized)  // _OST: OSPM Status Indication
                {
                    COST (0x05, Arg0, Arg1, Arg2)
                }
            }

            Processor (C006, 0x06, 0x00000000, 0x00)
            {
                Method (_STA, 0, Serialized)  // _STA: Status
                {
                    Return (CSTA (0x06))
                }

                Name (_MAT, Buffer (0x08)  // _MAT: Multiple APIC Table Entry
                {
                     0x00, 0x08, 0x06, 0x06, 0x01, 0x00, 0x00, 0x00   // ........
                })
                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device, x=0-9
                {
                    CEJ0 (0x06)
                }

                Method (_OST, 3, Serialized)  // _OST: OSPM Status Indication
                {
                    COST (0x06, Arg0, Arg1, Arg2)
                }
            }

            Processor (C007, 0x07, 0x00000000, 0x00)
            {
                Method (_STA, 0, Serialized)  // _STA: Status
                {
                    Return (CSTA (0x07))
                }

                Name (_MAT, Buffer (0x08)  // _MAT: Multiple APIC Table Entry
                {
                     0x00, 0x08, 0x07, 0x07, 0x01, 0x00, 0x00, 0x00   // ........
                })
                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device, x=0-9
                {
                    CEJ0 (0x07)
                }

                Method (_OST, 3, Serialized)  // _OST: OSPM Status Indication
                {
                    COST (0x07, Arg0, Arg1, Arg2)
                }
            }

            Processor (C008, 0x08, 0x00000000, 0x00)
            {
                Method (_STA, 0, Serialized)  // _STA: Status
                {
                    Return (CSTA (0x08))
                }

                Name (_MAT, Buffer (0x08)  // _MAT: Multiple APIC Table Entry
                {
                     0x00, 0x08, 0x08, 0x08, 0x01, 0x00, 0x00, 0x00   // ........
                })
                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device, x=0-9
                {
                    CEJ0 (0x08)
                }

                Method (_OST, 3, Serialized)  // _OST: OSPM Status Indication
                {
                    COST (0x08, Arg0, Arg1, Arg2)
                }
            }

            Processor (C009, 0x09, 0x00000000, 0x00)
            {
                Method (_STA, 0, Serialized)  // _STA: Status
                {
                    Return (CSTA (0x09))
                }

                Name (_MAT, Buffer (0x08)  // _MAT: Multiple APIC Table Entry
                {
                     0x00, 0x08, 0x09, 0x09, 0x01, 0x00, 0x00, 0x00   // ........
                })
                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device, x=0-9
                {
                    CEJ0 (0x09)
                }

                Method (_OST, 3, Serialized)  // _OST: OSPM Status Indication
                {
                    COST (0x09, Arg0, Arg1, Arg2)
                }
            }

            Processor (C00A, 0x0A, 0x00000000, 0x00)
            {
                Method (_STA, 0, Serialized)  // _STA: Status
                {
                    Return (CSTA (0x0A))
                }

                Name (_MAT, Buffer (0x08)  // _MAT: Multiple APIC Table Entry
                {
                     0x00, 0x08, 0x0A, 0x0A, 0x01, 0x00, 0x00, 0x00   // ........
                })
                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device, x=0-9
                {
                    CEJ0 (0x0A)
                }

                Method (_OST, 3, Serialized)  // _OST: OSPM Status Indication
                {
                    COST (0x0A, Arg0, Arg1, Arg2)
                }
            }

            Processor (C00B, 0x0B, 0x00000000, 0x00)
            {
                Method (_STA, 0, Serialized)  // _STA: Status
                {
                    Return (CSTA (0x0B))
                }

                Name (_MAT, Buffer (0x08)  // _MAT: Multiple APIC Table Entry
                {
                     0x00, 0x08, 0x0B, 0x0B, 0x01, 0x00, 0x00, 0x00   // ........
                })
                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device, x=0-9
                {
                    CEJ0 (0x0B)
                }

                Method (_OST, 3, Serialized)  // _OST: OSPM Status Indication
                {
                    COST (0x0B, Arg0, Arg1, Arg2)
                }
            }

            Processor (C00C, 0x0C, 0x00000000, 0x00)
            {
                Method (_STA, 0, Serialized)  // _STA: Status
                {
                    Return (CSTA (0x0C))
                }

                Name (_MAT, Buffer (0x08)  // _MAT: Multiple APIC Table Entry
                {
                     0x00, 0x08, 0x0C, 0x0C, 0x01, 0x00, 0x00, 0x00   // ........
                })
                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device, x=0-9
                {
                    CEJ0 (0x0C)
                }

                Method (_OST, 3, Serialized)  // _OST: OSPM Status Indication
                {
                    COST (0x0C, Arg0, Arg1, Arg2)
                }
            }

            Processor (C00D, 0x0D, 0x00000000, 0x00)
            {
                Method (_STA, 0, Serialized)  // _STA: Status
                {
                    Return (CSTA (0x0D))
                }

                Name (_MAT, Buffer (0x08)  // _MAT: Multiple APIC Table Entry
                {
                     0x00, 0x08, 0x0D, 0x0D, 0x01, 0x00, 0x00, 0x00   // ........
                })
                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device, x=0-9
                {
                    CEJ0 (0x0D)
                }

                Method (_OST, 3, Serialized)  // _OST: OSPM Status Indication
                {
                    COST (0x0D, Arg0, Arg1, Arg2)
                }
            }

            Processor (C00E, 0x0E, 0x00000000, 0x00)
            {
                Method (_STA, 0, Serialized)  // _STA: Status
                {
                    Return (CSTA (0x0E))
                }

                Name (_MAT, Buffer (0x08)  // _MAT: Multiple APIC Table Entry
                {
                     0x00, 0x08, 0x0E, 0x0E, 0x01, 0x00, 0x00, 0x00   // ........
                })
                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device, x=0-9
                {
                    CEJ0 (0x0E)
                }

                Method (_OST, 3, Serialized)  // _OST: OSPM Status Indication
                {
                    COST (0x0E, Arg0, Arg1, Arg2)
                }
            }

            Processor (C00F, 0x0F, 0x00000000, 0x00)
            {
                Method (_STA, 0, Serialized)  // _STA: Status
                {
                    Return (CSTA (0x0F))
                }

                Name (_MAT, Buffer (0x08)  // _MAT: Multiple APIC Table Entry
                {
                     0x00, 0x08, 0x0F, 0x0F, 0x01, 0x00, 0x00, 0x00   // ........
                })
                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device, x=0-9
                {
                    CEJ0 (0x0F)
                }

                Method (_OST, 3, Serialized)  // _OST: OSPM Status Indication
                {
                    COST (0x0F, Arg0, Arg1, Arg2)
                }
            }
        }
    }

    Method (\_GPE._E02, 0, NotSerialized)  // _Exx: Edge-Triggered GPE, xx=0x00-0xFF
    {
        \_SB.CPUS.CSCN ()
    }

    Scope (_GPE)
    {
        Name (_HID, "ACPI0006" /* GPE Block Device */)  // _HID: Hardware ID
    }

    Scope (\_SB.PCI0)
    {
        Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
        {
            WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                0x0000,             // Granularity
                0x0000,             // Range Minimum
                0x00FF,             // Range Maximum
                0x0000,             // Translation Offset
                0x0100,             // Length
                ,, )
            IO (Decode16,
                0x0CF8,             // Range Minimum
                0x0CF8,             // Range Maximum
                0x01,               // Alignment
                0x08,               // Length
                )
            WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                0x0000,             // Granularity
                0x0000,             // Range Minimum
                0x0CF7,             // Range Maximum
                0x0000,             // Translation Offset
                0x0CF8,             // Length
                ,, , TypeStatic, DenseTranslation)
            WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                0x0000,             // Granularity
                0x0D00,             // Range Minimum
                0xFFFF,             // Range Maximum
                0x0000,             // Translation Offset
                0xF300,             // Length
                ,, , TypeStatic, DenseTranslation)
            DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                0x00000000,         // Granularity
                0x000A0000,         // Range Minimum
                0x000BFFFF,         // Range Maximum
                0x00000000,         // Translation Offset
                0x00020000,         // Length
                ,, , AddressRangeMemory, TypeStatic)
            DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                0x00000000,         // Granularity
                0x80000000,         // Range Minimum
                0xAFFFFFFF,         // Range Maximum
                0x00000000,         // Translation Offset
                0x30000000,         // Length
                ,, , AddressRangeMemory, TypeStatic)
            DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                0x00000000,         // Granularity
                0xC0000000,         // Range Minimum
                0xFEBFFFFF,         // Range Maximum
                0x00000000,         // Translation Offset
                0x3EC00000,         // Length
                ,, , AddressRangeMemory, TypeStatic)
            QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                0x0000000000000000, // Granularity
                0x0000000800000000, // Range Minimum
                0x0000000FFFFFFFFF, // Range Maximum
                0x0000000000000000, // Translation Offset
                0x0000000800000000, // Length
                ,, , AddressRangeMemory, TypeStatic)
        })
        Device (GPE0)
        {
            Name (_HID, "PNP0A06" /* Generic Container Device */)  // _HID: Hardware ID
            Name (_UID, "GPE0 resources")  // _UID: Unique ID
            Name (_STA, 0x0B)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                IO (Decode16,
                    0x0620,             // Range Minimum
                    0x0620,             // Range Maximum
                    0x01,               // Alignment
                    0x10,               // Length
                    )
            })
        }
    }

    Scope (\)
    {
        Name (_S3, Package (0x04)  // _S3_: S3 System State
        {
            One, 
            One, 
            Zero, 
            Zero
        })
        Name (_S4, Package (0x04)  // _S4_: S4 System State
        {
            0x02, 
            0x02, 
            Zero, 
            Zero
        })
        Name (_S5, Package (0x04)  // _S5_: S5 System State
        {
            Zero, 
            Zero, 
            Zero, 
            Zero
        })
    }

    Scope (\_SB.PCI0)
    {
        Device (FWCF)
        {
            Name (_HID, "QEMU0002")  // _HID: Hardware ID
            Name (_STA, 0x0B)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                IO (Decode16,
                    0x0510,             // Range Minimum
                    0x0510,             // Range Maximum
                    0x01,               // Alignment
                    0x0C,               // Length
                    )
            })
        }
    }

    Scope (\_SB.PCI0.ISA)
    {
        Device (SMC)
        {
            Name (_HID, EisaId ("APP0001"))  // _HID: Hardware ID
            Name (_STA, 0x0B)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                IO (Decode16,
                    0x0300,             // Range Minimum
                    0x0300,             // Range Maximum
                    0x01,               // Alignment
                    0x20,               // Length
                    )
                IRQNoFlags ()
                    {6}
            })
        }
    }

    Scope (\_SB)
    {
        Scope (PCI0)
        {
            Device (S00)
            {
                Name (_ADR, Zero)  // _ADR: Address
            }

            Device (S08)
            {
                Name (_ADR, 0x00010000)  // _ADR: Address
            }

            Device (S10)
            {
                Name (_ADR, 0x00020000)  // _ADR: Address
                Method (_S1D, 0, NotSerialized)  // _S1D: S1 Device State
                {
                    Return (Zero)
                }

                Method (_S2D, 0, NotSerialized)  // _S2D: S2 Device State
                {
                    Return (Zero)
                }

                Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
                {
                    Return (Zero)
                }
            }

            Device (S38)
            {
                Name (_ADR, 0x00070000)  // _ADR: Address
            }

            Method (PCNT, 0, NotSerialized)
            {
            }
        }
    }
}

