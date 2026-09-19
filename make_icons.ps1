Add-Type -AssemblyName System.Drawing

function MakeIcon([int]$sz, [string]$outPath) {
    $bmp = New-Object System.Drawing.Bitmap($sz, $sz)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias

    # Sfondo Verde (#16a34a)
    $bgBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(22, 163, 74))
    $g.FillRectangle($bgBrush, 0, 0, $sz, $sz)

    # Cerchio centrale leggermente più scuro
    $circleBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(21, 128, 61))
    $m = [int]($sz * 0.08)
    $cSz = $sz - ($m * 2)
    $g.FillEllipse($circleBrush, $m, $m, $cSz, $cSz)

    # Posate bianche
    $wBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)

    # Forchetta
    $fX = [int]($sz * 0.30)
    $fY = [int]($sz * 0.22)
    $fW = [int]($sz * 0.12)
    $fH = [int]($sz * 0.56)
    $g.FillRectangle($wBrush, $fX, $fY, $fW, $fH)

    # Cucchiaio
    $sX = [int]($sz * 0.56)
    $sY = [int]($sz * 0.22)
    $sW = [int]($sz * 0.14)
    $sH = [int]($sz * 0.56)
    $g.FillEllipse($wBrush, $sX, $sY, $sW, [int]($sH * 0.45))
    $g.FillRectangle($wBrush, [int]($sX + $sW * 0.3), [int]($sY + $sH * 0.3), [int]($sW * 0.4), [int]($sH * 0.7))

    $bmp.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)
    $g.Dispose()
    $bmp.Dispose()
}

MakeIcon 192 "e:\DIARIO ALIMENTARE\icon-192.png"
MakeIcon 512 "e:\DIARIO ALIMENTARE\icon-512.png"
Write-Host "Icons generated successfully!"
