# 🛡️ Windows EXE Firewall Blocker

Script automatizado en **PowerShell** diseñado para generar de forma masiva reglas de bloqueo de tráfico (Entrada y Salida) para todos los archivos ejecutables (`.exe`) contenidos en una ruta específica y sus subcarpetas.

---

## 🚀 Uso Rápido (Una sola línea)

Puedes descargar, ejecutar y limpiar el script de manera totalmente desatendida abriendo **PowerShell como Administrador** y ejecutando la siguiente línea:

```powershell
$tmp = "$env:TEMP\BloquearEXEs.ps1"; irm "https://raw.githubusercontent.com/uLl0a/win-exe-firewall/refs/heads/main/BloquearEXEs.ps1" -OutFile $tmp; . $tmp; Remove-Item $tmp -ErrorAction SilentlyContinue
