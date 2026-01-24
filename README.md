# Markdown-chanGYongyuvfav

<h1 style="background-color:#DDD0C8; color:#6B4C5B; border-radius:20px; padding:10px;">
TitleHere
</h1>

```
https://papple23g-ahkcompiler.herokuapp.com/ahkblockly
```

```
https://scratch.mit.edu/
```

::创建差分VHDX
```
diskpart
```

```
create vdisk file="差分盘路径" parent="母盘路径"
```

修改当前启动系统启动名称

```
bcdedit /set {current} description "Windows"
```

创建VHDX
```
创建vhdx文件
create vdisk file="D:\VHD\disk.vhdx" maximum=307200 type=expandable
选择vhdx文件
select vdisk file="D:\VHD\disk.vhdx"
附加vhdx文件(还未初始化)
attach vdisk
初始化
create partition primary
格式化
format fs=ntfs unit=4096 quick label="VHDX300G"
分配盘符
assign letter=V
退出命令行
exit
```
