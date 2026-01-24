要用 **SYSTEM 身份运行 DiskPart**，Windows 本身没有直接按钮，但可以通过一个非常稳定的方式做到：**PsExec（微软官方 Sysinternals 工具）**。  
这是所有管理员、取证工程师、系统工程师都在用的方法。

下面我给你最简洁、最可靠的步骤。

---

# 🧩 方法：用 PsExec 以 SYSTEM 身份启动 DiskPart

## **步骤 1：下载 PsExec（微软官方）**
PsExec 属于 Sysinternals Suite，你可以从微软官网下载。  
（这是官方工具，不是第三方。）

---

## **步骤 2：以 SYSTEM 身份打开 CMD**

在普通管理员 CMD 中运行：

```
psexec -sid cmd.exe
```

解释：  
- `-s` → 以 SYSTEM 身份运行  
- `-i` → 允许交互式窗口  
- `-d` → 不等待程序退出（可选）

执行后会弹出一个新的 CMD 窗口，这个窗口就是 **SYSTEM 权限**。

你可以确认一下：

```
whoami
```

输出应该是：

```
nt authority\system
```

---

## **步骤 3：在 SYSTEM CMD 中运行 DiskPart**

```
diskpart
```

现在 DiskPart 就是 **SYSTEM 权限**运行的。

---

# 🧩 为什么你必须用 SYSTEM 身份运行 DiskPart？

因为你之前对母盘目录设置了：

- 拒绝 a（你的账户）访问  
- 只允许 SYSTEM 访问  

DiskPart 默认以 **当前用户身份（你 a）** 运行，所以：

- 你被 deny  
- DiskPart 也被 deny  
- 于是报错：  
  **文件或目录损坏且无法读取**

但 SYSTEM 永远不会被 deny，所以：

✔ SYSTEM DiskPart 能读取母盘  
✔ 能创建差分盘  
✔ 不会破坏你的隐藏策略  
✔ 不需要给 a 添加权限  

---

# 🧩 最终建议（最稳的工作流）

以后你要对 VHDX 做任何操作（尤其是差分盘）：

1. 打开 SYSTEM CMD  
   ```
   psexec -sid cmd.exe
   ```

2. 在 SYSTEM CMD 里运行 DiskPart  
   ```
   diskpart
   ```

3. 做完后关闭窗口即可  
   不会影响你的母盘隐藏策略

---

如果你愿意，我可以帮你做一个：

- **一键 SYSTEM DiskPart 启动脚本**  
- **自动创建差分盘 + 自动恢复隐藏权限脚本**  
- 或者检查你当前的 ACL 是否还有残留 deny  

你想继续优化哪一部分。
