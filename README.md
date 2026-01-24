# Markdown-chanGYongyuvfav

<h1 style="background-color:#DDD0C8; color:#6B4C5B; border-radius:20px; padding:10px;">
TitleHere
</h1>



===================================================================<br>

# 常用地址X<br>

===================================================================<br>
```
https://papple23g-ahkcompiler.herokuapp.com/ahkblockly
```

```
https://scratch.mit.edu/
```

===================================================================<br>

# 修改当前启动系统启动名称<br>

===================================================================<br>

```
bcdedit /set {current} description "Windows"
```




===================================================================<br>

# 创建VHDX<br>

===================================================================<br>

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




===================================================================<br>

# 拒绝列出文件<br>

===================================================================<br>


# 🧩 一、目录权限（让你自己看不到目录内容）

假设目录是：

```
D:\VHDX\Parent
```

## **1. 设置隐藏文件夹关闭继承**

```
attrib +s +h "D:\VHDX\Parent"
```

```
attrib +h +s D:\VHDX\Parent\base.vhdx
```

```
icacls "D:\VHDX\Parent" /inheritance:r
```

---

## **2. 给 SYSTEM 完全控制**

```
icacls "D:\VHDX\Parent" /grant:r SYSTEM:(OI)(CI)(F)
```

---

## **3. 拒绝你的账户 a 访问目录（关键）**

```
icacls "D:\VHDX\Parent" /deny a:(OI)(CI)(F)
```

这会让你：

- 看不到目录内容  
- 无法进入目录  
- 无法打开母盘文件  
- 无法误操作

---

# 🧩 二、母盘文件权限（让你完全无法打开）

## **3. 拒绝你的账户 a**

```
icacls "D:\VHDX\Parent\base.vhdx" /deny a:(F)
```

---


# 🧩 四、最终效果（完全符合你的需求）

| 对象 | 你（a） | SYSTEM | 子盘挂载 | 隐蔽性 |
|------|---------|--------|----------|--------|
| 目录 | ❌ 无法进入 | ✔ | ✔ | ★★★★ |
| 母盘文件 | ❌ 无法打开 | ✔ | ✔ | ★★★★ |
| 差分链 | 不受影响 | ✔ | ✔ | — |

你自己完全无法看到或打开母盘文件，误双击也不可能破坏差分链。

---




===================================================================<br>

# 创建差分VHDX<br>

===================================================================<br>
```
diskpart
```

```
create vdisk file="差分盘路径" parent="母盘路径"
```


















