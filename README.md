# 《崩坏：星穹铁道》跃迁历史链接获取器
此脚本仅适用于**Windows 10及以上**版本。

__代码来自[Star Rail Station](https://gist.github.com/Star-Rail-Station/2512df54c4f35d399cc9abbde665e8f0)。__

## 如何使用
1. 登录《崩坏：星穹铁道》PC端并打开游戏内的跃迁历史记录。
2. 打开Windows PowerShell。<small><font color="gray">（你可以通过Windows搜索「Windows PowerShell」找到该程序。）</font></small>
3. 粘贴并运行下述命令：
   ```powershell
   $response = Invoke-WebRequest -Uri "https://gitee.com/xyz8848/StarRail-Warp-History-Url-Grabbers/raw/main/get_warp_link_cn.ps1"
   $content = $response.Content
   Set-Content -Path $env:TEMP\temp.ps1 -Value $content -Encoding UTF8
   & chcp 65001 | Out-Null
   Invoke-Expression -Command "& $env:TEMP\temp.ps1"
   ```
