# Instalar Chocolatey si no está instalado
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
$downloadFolder = [System.IO.Path]::Combine($env:USERPROFILE, "Downloads")
function Download {
    param (
        [string]$fileID,
        [string]$destination
    )
    $url = "$fileID"
    Invoke-WebRequest -Uri $url -OutFile $destination
}
# Descargar Codesys 3.5 v14 desde Google Drive
$codesysID = "https://terabox.com/s/1cbuPZkMi9rM8KmbT-JPm7w" # Reemplaza con el ID del archivo en Google Drive
$codesysInstaller = [System.IO.Path]::Combine($downloadFolder, "codesys_installer.exe")

$fluidsimID = "https://terabox.com/s/1pbNwsUMq2w3WPXVzZG6XGA" # Reemplaza con el ID del archivo en Google Drive
$fluidsimInstaller = [System.IO.Path]::Combine($downloadFolder, "fluidsim_installer.exe")
# Iniciar descarga e instalación en segundo plano
Start-Job -ScriptBlock {
    Download -fileID $using:codesysID -destination $using:codesysInstaller
}
Start-Job -ScriptBlock {
    Download -fileID $using:fluidsimID -destination $using:fluidsimInstaller
    
}
# Instalar Software especializado
Start-Job -ScriptBlock {
  choco install nodejs -y
  choco install 7zip -y
  choco install python -y
  choco install inkscape -y
  choco install vscode -y
  choco install git -y
  choco install rust -y
  choco install googlechrome -y
  choco install brave -y
  choco install docker-desktop -y
  npm install -g --unsafe-perm node-red
  npm install -g node-red-dashboard node-red-contrib-ui-svg
}
# Esperar a que todos los trabajos en segundo plano terminen
Get-Job | Wait-Job
# Recoger resultados de los trabajos (opcional)
Get-Job | Receive-Job
# Limpiar trabajos
Get-Job | Remove-Job
# Instalar programas descargados
Start-Job -ScriptBlock {
    Start-Process $using:codesysInstaller -ArgumentList "/S" -Wait
    Start-Process $using:fluidsimInstaller -ArgumentList "/S" -Wait
}

