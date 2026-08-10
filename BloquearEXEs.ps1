[CmdletBinding()]
param (
    [Parameter(Mandatory = $true, HelpMessage = "Ingresa la ruta de la carpeta")]
    [string]$RutaCarpeta
)

# Verificar si la ruta existe
if (-not (Test-Path -Path $RutaCarpeta)) {
    Write-Host "Error: La ruta '$RutaCarpeta' no existe." -ForegroundColor Red
    exit
}

# Resolver la ruta completa por si se pasan rutas relativas como "."
$RutaAbsoluta = (Resolve-Path -Path $RutaCarpeta).Path

# Obtener todos los archivos .exe de forma recursiva
$archivosExe = Get-ChildItem -Path $RutaAbsoluta -Filter "*.exe" -Recurse

if ($archivosExe.Count -eq 0) {
    Write-Host "No se encontraron archivos .exe en la ruta especificada." -ForegroundColor Yellow
    exit
}

Write-Host "Se encontraron $($archivosExe.Count) ejecutables. Creando reglas de firewall..." -ForegroundColor Yellow

foreach ($exe in $archivosExe) {
    $nombreReglaEntrada = "Bloqueo Entrada - $($exe.Name)"
    $nombreReglaSalida  = "Bloqueo Salida - $($exe.Name)"
    
    # Crear regla de Salida (Outbound)
    New-NetFirewallRule -DisplayName $nombreReglaSalida `
                        -Direction Outbound `
                        -Program $exe.FullName `
                        -Action Block `
                        -Profile Any | Out-Null
                        
    # Crear regla de Entrada (Inbound)
    New-NetFirewallRule -DisplayName $nombreReglaEntrada `
                        -Direction Inbound `
                        -Program $exe.FullName `
                        -Action Block `
                        -Profile Any | Out-Null

    Write-Host "Bloqueado: $($exe.FullName)" -ForegroundColor Green
}

Write-Host "`n¡Proceso completado con éxito!" -ForegroundColor Cyan