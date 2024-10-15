# URL per il binario del Collector (specifica l'ultima versione stabile)
$otelUrl = "https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/v0.111.0/otelcol_0.111.0_windows_amd64.tar.gz"

# Cartella di destinazione
$installPath = "C:\opentelemetry"
$zipFile = "$installPath\otelcol.tar.gz"
$exeFile = "$installPath\otelcol.exe"

# Crea la cartella di destinazione se non esiste
Write-Host "Crea la cartella di destinazione se non esiste"
If (-Not (Test-Path $installPath)) {
    New-Item -ItemType Directory -Force -Path $installPath
}

# Scarica il Collector
Write-Host "Scarica il Collector"
Invoke-WebRequest -Uri $otelUrl -OutFile $zipFile

# Estrai il file zip
Write-Host "Estrai il file zip"
#Expand-Archive -Path $zipFile -DestinationPath "$installPath" -Force
tar -xvzf $zipFile -C $installPath

# Rimuovi il file zip
Write-Host "Rimuovi il file zip"
Remove-Item $zipFile

# Aggiungi il percorso del Collector al PATH
Write-Host "Aggiungi il percorso del Collector al PATH"
$env:Path += ";$installPath"
[Environment]::SetEnvironmentVariable("Path", $env:Path, [EnvironmentVariableTarget]::Machine)

# Verifica se l'installazione è corretta
Write-Host "Verifica se l'installazione è corretta"
& $exeFile --version
