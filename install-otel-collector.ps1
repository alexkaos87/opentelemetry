# URL per il binario del Collector (specifica l'ultima versione stabile)
$otelUrl = "https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/v0.111.0/otelcol_0.111.0_windows_amd64.tar.gz"

# Cartella di destinazione
$installPath = "C:\opentelemetry"

# Crea la cartella di destinazione se non esiste
If (-Not (Test-Path $installPath)) {
    New-Item -ItemType Directory -Force -Path $installPath
}

# Scarica il Collector
Invoke-WebRequest -Uri $otelUrl -OutFile "$installPath\otelcol.zip"

# Estrai il file zip
Expand-Archive -Path "$installPath\otelcol.zip" -DestinationPath $installPath -Force

# Rimuovi il file zip
Remove-Item "$installPath\otelcol.zip"

# Aggiungi il percorso del Collector al PATH
$env:Path += ";$installPath"
[Environment]::SetEnvironmentVariable("Path", $env:Path, [EnvironmentVariableTarget]::Machine)

# Verifica se l'installazione è corretta
& "$installPath\otelcol.exe" --version
