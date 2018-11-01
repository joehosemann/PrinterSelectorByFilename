#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

FullFilePath = %1%
Printer := ""

IniRead, AdobePath, PrinterSelectorByFilename.ini, General, AdobePath
IniRead, Printer_Labeller, PrinterSelectorByFilename.ini, General, Printer_Labeller
IniRead, Printer_Standard, PrinterSelectorByFilename.ini, General, Printer_Standard
IniRead, FileName_Label, PrinterSelectorByFilename.ini, General, FileName_Label
IniRead, FileName_Standard, PrinterSelectorByFilename.ini, General, FileName_Standard

SplitPath, 1, fname,, extension, nameWithoutExtension

; Labeller
IfInString, nameWithoutExtension, %FileName_Label%
{
	Printer := "Labeller"
}
IfInString, nameWithoutExtension, ShippingLabel
{
	Printer := "Labeller"
}

; 8.5x11 Printer
IfInString, nameWithoutExtension, %FileName_Standard%
{
	Printer := "8.5"
}
IfInString, nameWithoutExtension, PackingSlip
{
	Printer := "8.5"
}

If (Printer = "Labeller")
{
	Run %AdobePath% /t %FullFilePath% %Printer_Labeller%
}
If (Printer = "8.5")
{
	Run %AdobePath% /t %FullFilePath% %Printer_Standard%
}

WinClose, Adobe Acrobat Reader
WinWaitClose
FileDelete, %FullFilePath%

ExitApp
