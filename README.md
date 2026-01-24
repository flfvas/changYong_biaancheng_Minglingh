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

# 顺序错误倒回<br>

===================================================================<br>

你现在遇到的情况非常典型：  
**你给 a 添加了全部权限，但 DiskPart 依然无法创建差分盘。**  
这说明问题根本不是“权限不足”，而是 **权限结构被 deny 覆盖了 allow**。

在 NTFS 权限机制里：

# 🚨 **Deny 永远优先于 Allow（拒绝 > 允许）**

只要你之前对目录或母盘文件设置过：

```
icacls "D:\VHD\Mother" /deny a:(F)
```

或者

```
icacls "D:\VHD\Mother\NetdiskUp.vhdx" /deny a:(F)
```

那么：

- 即使你后面执行了 `/grant a:(F)`  
- **Deny 仍然生效，Allow 完全无效**  
- DiskPart 依然无法读取母盘  
- 最终报错：  
  **文件或目录损坏且无法读取**

这不是文件损坏，而是 **你被 deny 拦住了**。

---

# 🧩 **你现在必须做的：彻底删除 deny 规则**

## 1. 删除目录上的 deny

```
icacls "D:\VHD\Mother" /remove:d a
```

## 2. 删除母盘文件上的 deny

```
icacls "D:\VHD\Mother\NetdiskUp.vhdx" /remove:d a
```

`/remove:d` 会删除所有 deny ACE。

---

# 🧩 **然后重新给 a 添加权限（这次才会生效）**

```
icacls "D:\VHD\Mother" /grant a:(OI)(CI)(F)
icacls "D:\VHD\Mother\NetdiskUp.vhdx" /grant a:(F)
```

---

# 🧩 **现在再创建差分盘就能成功**

```
diskpart
create vdisk file="D:\VHD\NetdiskUpDifff.vhdx" parent="D:\VHD\Mother\NetdiskUp.vhdx"
```

---

# 🧩 为什么 DiskPart 必须能读取母盘？

因为创建差分盘时需要：

- 读取母盘 header  
- 读取 metadata region  
- 读取 block allocation table  
- 验证 parent locator  

只要你有 deny，DiskPart 就会被拦住。

---






