# Instalar Chocolatey si no está instalado
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Instalar Software especializado
choco install nodejs
choco install python
choco install inkscape
choco install vscode
choco install git
choco install rust
choco install googlechrome
choco install brave
choco install docker-desktop
npm install -g --unsafe-perm node-red
npm install -g node-red-dashboard node-red-contrib-ui-svg

