
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

# VHDX相关命令<br>

===================================================================<br>
## 创建VHDX文件
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


## 先创建差分VHDX, 避免设置权限后权限不足<br>

```
diskpart
```

```
create vdisk file="D:\VHD\NetdiskUpDifff.vhdx" parent="D:\VHD\Mother\NetdiskUp.vhdx"

```


## 拒绝列出文件, 保护差分盘母盘<br>


### 🧩 一、目录权限（让你自己看不到目录内容）

假设目录是：

```
D:\VHD\Mother
```

### **1. 设置隐藏文件夹关闭继承**

```
attrib +s +h "D:\VHD\Mother"
```

```
attrib +h +s D:\VHD\Mother\NetdiskUp.vhdx
```

```
icacls "D:\VHD\Mother" /inheritance:r
```

---

### **2. 给 SYSTEM 完全控制**

```
icacls "D:\VHD\Mother" /grant:r SYSTEM:(OI)(CI)(F)
```

---

### **3. 拒绝你的账户 a 访问目录（关键）**

```
icacls "D:\VHD\Mother" /deny a:(OI)(CI)(F)
```

---


### 🧩 四、最终效果（完全符合你的需求）

| 对象 | 你（a） | SYSTEM | 子盘挂载 | 隐蔽性 |
|------|---------|--------|----------|--------|
| 目录 | ❌ 无法进入 | ✔ | ✔ | ★★★★ |
| 母盘文件 | ❌ 无法打开 | ✔ | ✔ | ★★★★ |
| 差分链 | 不受影响 | ✔ | ✔ | — |

你自己完全无法看到或打开母盘文件，误双击也不可能破坏差分链。

---



===================================================================<br>

# Wepe不能运行diskgenius时创建efi分区<br>

===================================================================<br>


## 1. 进入 diskpart
```
diskpart
```

## 2. 列出磁盘
```
list disk
```

## 3. 选择目标磁盘（示例：Disk 1）
```
select disk 1
```

---

## 📌 **创建 EFI System Partition（100MB）**
Windows 官方推荐大小：**100 MB**，格式化为 FAT32。
4k格式化要300M
```
创建 EFI 分区，并自动“选中”它
create partition efi size=300
只格式化选中的efi, 不格式化disk 1
format quick fs=fat32 label="System" unit=4096
```

---

## 📌 **创建 MSR 分区（16MB）**
Windows 官方标准：**16 MB**（不格式化、不分配盘符）。
MSR 不格式化没有簇
• 	MSR 没有文件系统
• 	MSR 没有簇（cluster）
• 	MSR 不挂载、不分配盘符

```
create partition msr size=16
```

---





===================================================================<br>

# win11没有网络情况下安装<br>

===================================================================<br>

## 📌 **最简指令总结（你可以直接用）**

```
Shift + F10
OOBE\BYPASSNRO
```




===================================================================<br>

# 防止IP泄露<br>

===================================================================<br>

### ✔ 方案 B：返回内网 IP（也很自然）
如果你不想暴露 VPN IP，可以允许返回内网地址（192.168.x.x）：

设置：
```
media.peerconnection.enabled
```
= true
```
media.peerconnection.ice.default_address_only
```
= false
```
media.peerconnection.ice.no_host
```
= false


```
intl.accept_languages
```
```
nl-NL,nl,en-US,en,zh-TW,zh
```



效果：
- WebRTC 返回内网 IP  
- 像家庭用户  
- 风控评分中性偏低  
- 不泄露公网 IP（前提是 VPN 接管了 STUN）

---

### ❌ 避免“启用但无返回”的状态
这是风控模型最难判断的状态 → 容易被误判为代理或脚本。

---

## 🎯 结论

你现在的 WebRTC 状态属于“启用但无返回”，在真实用户中不常见，**风控系统可能会提高评分，但不会直接封禁**。  
如果你想更像真实用户，建议调整为：

- 返回 VPN IP（最自然）  
- 或返回内网 IP（也很常见）  
- 避免“空白 / timeout”状态  

如果你愿意，我可以帮你做一个**“WebRTC 风控评分模拟器”**，让你测试不同配置在网站眼中的风险等级。















