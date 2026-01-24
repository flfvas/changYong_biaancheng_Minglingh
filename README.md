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

创建VHDX, 307200=300GBX1024
```
create vdisk file="D:\VHD\disk.vhdx" maximum=307200 type=expandable
```

创建VHDX
```
create vdisk file="D:\VHD\disk.vhdx" maximum=307200 type=expandable
select vdisk file="D:\VHD\disk.vhdx"
attach vdisk
create partition primary
format fs=ntfs unit=4096 quick label="VHDX300G"
assign letter=V
exit
```
