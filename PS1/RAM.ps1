# ------------------------------------------------------------------------------------------------------------------------------------
# PowerShell Script by MNS @ Warsaw , 03/10/2020 -------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------------------------------------------------------
# Purpose : Describe the key characteristics of the Physical Memory (RAM) in the current machine. ------------------------------------
# ------------------------------------------------------------------------------------------------------------------------------------

# RAM information on current machine
Get-WmiObject Win32_PhysicalMemory | Select-Object BankLabel, @{Name="Capacity, GB"; Expression={$_.Capacity / 1GB}}, Manufacturer

# To find out the frequency at which RAM runs, run the command:
Get-WmiObject Win32_PhysicalMemory | Select-Object Speed

# To find out the voltage of the memory modules, run the command:
# DDR 2.5V 2500mV  
# DDR2 1.8V 1800mV  
# DDR3 1.5V 1500mV  
# DDR4 1.2V 1200mV
Get-WmiObject Win32_PhysicalMemory | Select-Object ConfiguredVoltage

# To find out the type (generation) of memory modules, run the command:
# the numbers 26 indicate that DDR4 memory modules are installed
# on a computer in which DDR3 memory modules are installed, the numbers 24 tell us about this.
Get-WmiObject Win32_PhysicalMemory | Select-Object SMBIOSMemoryType

# To check RAM type (the form factor of installed memory modules)
# the number 8 indicates that the memory modules correspond to the DIMM form factor, the standard standard size of desktop computers.
# he number 12 indicates that the memory modules correspond to the SODIMM form factor, which is usually installed in laptops.
Get-WmiObject Win32_PhysicalMemory | Select-Object FormFactor

# ------------------------------------------------------------------------------------------------------------------------------------
# End of Script RAN.ps1 --------------------------------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------------------------------------------------------
