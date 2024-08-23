# Konfigurationsvariablen
$EmpfaengerListe = "empfaenger1@beispiel.de, empfaenger2@beispiel.de"
$BerichtPfad = "C:\Berichte\Tagesbericht.xlsx"
$SMTPServer = "smtp.beispiel.de"
$EmailFrom = "berichter@beispiel.de"
$EmailSubject = "Täglicher Bericht"
$DashboardURL = "http://dashboard.beispiel.de/api/benachrichtigung"  # Beispiel-URL für das Dashboard

# Funktion zum Erstellen des Berichts
function ErstelleBericht {
    # Hier könnte der Code stehen, der tatsächlich den Bericht generiert
    Write-Output "Bericht wurde erstellt."
}

# Funktion zum Senden des Berichts
function SendeBericht {
    Param (
        [string]$Bericht,
        [string]$Empfaenger
    )
    Send-MailMessage -From $EmailFrom -To $Empfaenger -Subject $EmailSubject -Attachments $Bericht -SmtpServer $SMTPServer
    Write-Output "Bericht wurde gesendet an $Empfaenger."
}

# Funktion zur Benachrichtigung des Dashboards
function SendeDashboardBenachrichtigung {
    Param (
        [string]$Nachricht,
        [string]$URL
    )
    
    try {
        # Beispielcode für die Dashboard-Benachrichtigung
        $response = Invoke-RestMethod -Uri $URL -Method Post -Body (@{Nachricht=$Nachricht} | ConvertTo-Json) -ContentType "application/json"
        Write-Output "Dashboard wurde benachrichtigt: $Nachricht"
    }
    catch {
        Write-Output "Fehler beim Senden der Dashboard-Benachrichtigung: $_"
    }
}

# Hauptteil des Skripts
ErstelleBericht
SendeBericht -Bericht $BerichtPfad -Empfaenger $EmpfaengerListe

# Nachricht für das Dashboard vorbereiten
$Nachricht = "Bericht wurde am $(Get-Date -Format 'dd.MM.yyyy HH:mm:ss') erfolgreich erstellt und versendet."
SendeDashboardBenachrichtigung -Nachricht $Nachricht -URL $DashboardURL
