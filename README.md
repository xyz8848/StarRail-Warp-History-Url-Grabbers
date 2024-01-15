# 《崩坏：星穹铁道》跃迁历史链接获取器
此脚本仅适用于<font color="red">**Windows 10及以上**</font>版本。

__代码来自[Star Rail Station](https://gist.github.com/Star-Rail-Station/2512df54c4f35d399cc9abbde665e8f0)。__

[![jsDelivr hits per day](https://img.shields.io/jsdelivr/gh/hd/xyz8848/StarRail-Warp-History-Url-Grabbers?style=flat-square)](https://github.com/xyz8848/StarRail-Warp-History-Url-Grabbers)
[![jsDelivr hits per week](https://img.shields.io/jsdelivr/gh/hw/xyz8848/StarRail-Warp-History-Url-Grabbers?style=flat-square)](https://github.com/xyz8848/StarRail-Warp-History-Url-Grabbers)
[![jsDelivr hits per month](https://img.shields.io/jsdelivr/gh/hm/xyz8848/StarRail-Warp-History-Url-Grabbers?style=flat-square)](https://github.com/xyz8848/StarRail-Warp-History-Url-Grabbers)
[![jsDelivr hits per year](https://img.shields.io/jsdelivr/gh/hy/xyz8848/StarRail-Warp-History-Url-Grabbers?style=flat-square)](https://github.com/xyz8848/StarRail-Warp-History-Url-Grabbers)

## 如何使用
1. 登录《崩坏：星穹铁道》PC端并打开游戏内的跃迁历史记录。
2. 打开Windows PowerShell，然后粘贴并运行下述命令。<small><font color="gray">（你可以通过Windows搜索「Windows PowerShell」找到该程序。）</font></small>
3. ```
   [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12; Invoke-Expression (New-Object Net.WebClient).DownloadString("https://cdn.jsdelivr.net/gh/xyz8848/StarRail-Warp-History-Url-Grabbers/get_warp_link_cn.ps1?cachebust=srs")
   ```