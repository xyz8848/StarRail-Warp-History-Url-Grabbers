# StarRail Warp History Url Grabbers
# https://github.com/xyz8848/StarRail-Warp-History-Url-Grabbers
# https://gitee.com/xyz8848/StarRail-Warp-History-Url-Grabbers

[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12

Add-Type -AssemblyName System.Web

$ProgressPreference = 'SilentlyContinue'

$game_path = ""

Write-Output "\u6b63\u5728\u5c1d\u8bd5\u5b9a\u4f4d\u8dc3\u8fc1URL..."

if ($args.Length -eq 0) {
    $app_data = [Environment]::GetFolderPath('ApplicationData')
    $locallow_path = "$app_data\..\LocalLow\miHoYo\$([char]0x5d29)$([char]0x574f)$([char]0xff1a)$([char]0x661f)$([char]0x7a79)$([char]0x94c1)$([char]0x9053)\"

    $log_path = "$locallow_path\Player.log"

    if (-Not [IO.File]::Exists($log_path)) {
        Write-Output "\u627e\u4e0d\u5230\u65e5\u5fd7\u6587\u4ef6\uff01"
        return
    }

    $log_lines = Get-Content $log_path -First 11

    if ([string]::IsNullOrEmpty($log_lines)) {
        $log_path = "$locallow_path\Player-prev.log"

        if (-Not [IO.File]::Exists($log_path)) {
            Write-Output "\u627e\u4e0d\u5230\u65e5\u5fd7\u6587\u4ef6\uff01"
            return
        }

        $log_lines = Get-Content $log_path -First 11
    }

    if ([string]::IsNullOrEmpty($log_lines)) {
        Write-Output "\u627e\u4e0d\u5230\u65e5\u5fd7\u6587\u4ef6\uff01(1)"
        return
    }

    $log_lines = $log_lines.split([Environment]::NewLine)

    for ($i = 0; $i -lt 10; $i++) {
        $log_line = $log_lines[$i]

        if ($log_line.startsWith("Loading player data from ")) {
            $game_path = $log_line.replace("Loading player data from ", "").replace("data.unity3d", "")
            break
        }
    }
} else {
    $game_path = $args[0]
}

if ([string]::IsNullOrEmpty($game_path)) {
    Write-Output "\u627e\u4e0d\u5230\u65e5\u5fd7\u6587\u4ef6\uff01(2)"
}

$copy_path = [IO.Path]::GetTempPath() + [Guid]::NewGuid().ToString()

$cache_path = "$game_path/webCaches/Cache/Cache_Data/data_2"
$cache_folders = Get-ChildItem "$game_path/webCaches/" -Directory
$max_version = 0

for ($i = 0; $i -le $cache_folders.Length; $i++) {
    $cache_folder = $cache_folders[$i].Name
    if ($cache_folder -match '^\d+\.\d+\.\d+\.\d+$') {
        $version = [int]-join($cache_folder.Split("."))
        if ($version -ge $max_version) {
            $max_version = $version
            $cache_path = "$game_path/webCaches/$cache_folder/Cache/Cache_Data/data_2"
        }
    }
}

Copy-Item -Path $cache_path -Destination $copy_path
$cache_data = Get-Content -Encoding UTF8 -Raw $copy_path
Remove-Item -Path $copy_path

$cache_data_split = $cache_data -split '1/0/'

for ($i = $cache_data_split.Length - 1; $i -ge 0; $i--) {
    $line = $cache_data_split[$i]

    if ($line.StartsWith('http') -and $line.Contains("getGachaLog")) {
        $url = ($line -split "\0")[0]

        $res = Invoke-WebRequest -Uri $url -ContentType "application/json" -UseBasicParsing | ConvertFrom-Json

        if ($res.retcode -eq 0) {
            $uri = [Uri]$url
            $query = [Web.HttpUtility]::ParseQueryString($uri.Query)

            $keys = $query.AllKeys
            foreach ($key in $keys) {
                # Retain required params
                if ($key -eq "authkey") { continue }
                if ($key -eq "authkey_ver") { continue }
                if ($key -eq "sign_type") { continue }
                if ($key -eq "game_biz") { continue }
                if ($key -eq "lang") { continue }

                $query.Remove($key)
            }

            $latest_url = $uri.Scheme + "://" + $uri.Host + $uri.AbsolutePath + "?" + $query.ToString()

            Write-Output "\u627e\u5230\u8dc3\u8fc1\u5386\u53f2URL\uff01"
            Write-Output $latest_url
            Set-Clipboard -Value $latest_url
            Write-Output "\u8dc3\u8fc1\u5386\u53f2URL\u5df2\u4fdd\u5b58\u5230\u526a\u8d34\u677f\u3002"
            return;
        }
    }
}

Write-Output "\u627e\u4e0d\u5230\u8dc3\u8fc1\u5386\u53f2URL\u3002"
Write-Output "\u8bf7\u786e\u4fdd\u5728\u8fd0\u884c\u811a\u672c\u4e4b\u524d\u5728\u6e38\u620f\u5185\u6253\u5f00\u8fc7\u8dc3\u8fc1\u5386\u53f2\u8bb0\u5f55\u3002"
