
#Requires AutoHotkey v2.0
;#NoTrayIcon

$!c:: {
    clipText := FormatTime(, "yyyyMMdd-HHmmss") "-" A_MSec
    A_Clipboard := clipText
    A_Clipboard := clipText

    psCommand := "
    (
    $clipText = Get-Clipboard
    $vhdxPath = \"D:\VHDX\$clipText.vhdx\"
    $diskpartScript = @\"
    create vdisk file=\"$vhdxPath\" maximum=204800 type=expandable
    select vdisk file=\"$vhdxPath\"
    attach vdisk
    convert gpt
    create partition primary
    format fs=ntfs unit=4096 quick label=\"$clipText\"
    assign letter=A
    exit
    \"@
    $tempFile = [System.IO.Path]::GetTempFileName()
    Set-Content -Path $tempFile -Value $diskpartScript -Encoding ASCII
    diskpart /s $tempFile
    Remove-Item $tempFile
    )"

    ; 以管理员身份运行 PowerShell
    RunWait("powershell -NoProfile -ExecutionPolicy Bypass -Command " psCommand, , "RunAs")
}