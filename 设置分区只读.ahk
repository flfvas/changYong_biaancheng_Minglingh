; AutoHotkey 1.1 脚本
; 输入分区盘符，调用 PowerShell 设置属性

InputBox, driveLetter, 分区盘符, 请输入分区盘符（例如 D）:
if ErrorLevel
{
    MsgBox, 已取消
    ExitApp
}

; 菜单选择：1=只读，2=读写
InputBox, choice, 属性选择, 输入 1 设置只读，输入 2 设置读写:
if ErrorLevel
{
    MsgBox, 已取消
    ExitApp
}

if (choice = "1")
    psCmd := "Get-Partition -DriveLetter " . driveLetter . " | Set-Partition -IsReadOnly $true"
else if (choice = "2")
    psCmd := "Get-Partition -DriveLetter " . driveLetter . " | Set-Partition -IsReadOnly $false"
else
{
    MsgBox, 输入无效
    ExitApp
}

; 调用 PowerShell
RunWait, %ComSpec% /c powershell -NoProfile -Command "%psCmd%",, Hide

MsgBox, 已完成对 %driveLetter% 分区的属性设置
ExitApp