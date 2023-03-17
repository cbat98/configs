param (
    [Parameter(Mandatory=$false)]
    [string]$email = "rahmat@test.com",
    [Parameter(Mandatory=$false)]
    [string]$password = "Password123"
)

function GetToken {
    param (
        [Parameter(Mandatory=$true)]
        [string]$email,
        [Parameter(Mandatory=$true)]
        [string]$password,
        [Parameter(Mandatory=$false)]
        [string]$response_type = "token",
        [Parameter(Mandatory=$false)]
        [string]$client_id = "iIEWwXq9a29FJPqpbcKQxAbMgdJQKiuQ",
        [Parameter(Mandatory=$false)]
        [string]$scope = "openid email",
        [Parameter(Mandatory=$false)]
        [string]$redirect_uri = "https://localhost"
    )

    $uri = "https://microlise-test.eu.auth0.com/authorize?response_type=$response_type&client_id=$client_id&scope=$scope&redirect_uri=$redirect_uri"
    $headers = @{
        "Upgrade-Insecure-Requests" = "1";
        "User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Insomnia/2022.7.5 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36"
        "Accept" = "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9";
        "Sec-Fetch-Site" = "none";
        "Sec-Fetch-Mode" = "navigate";
        "Sec-Fetch-User" = "?1";
        "Sec-Fetch-Dest" = "document";
        "Accept-Encoding" = "gzip, deflate, br";
        "Accept-Language" = "en-GB";
    }
    $response1 = Invoke-WebRequest -Method "GET" -Uri $uri -Headers $headers -MaximumRedirection 0 -SessionVariable session -ErrorAction Ignore
    $state = ($response1.Headers.Location -split "state=")[1] 

    $uri = "https://microlise-test.eu.auth0.com/u/login/identifier?state=$state"
    $body = @{
        "state" = "$state";
        "username" = "$email";
        "js-available" = "false";
        "webauthn-available" = "true";
        "is-brave" = "false";
        "webauthn-platform-available" = "false";
        "action" = "default";
    }
    Invoke-WebRequest -Method "POST" -Uri $uri -Headers $headers -WebSession $session -Body $body -ContentType "application/x-www-form-urlencoded" -MaximumRedirection 9 | Out-Null

    $uri = "https://microlise-test.eu.auth0.com/u/login/password?state=$state"
    $body = @{
        "state" = "$state";
        "username" = "$email";
        "password" = "$password";
        "action" = "default";
    }
    try {
        Invoke-WebRequest -Method "POST" -Uri $uri -Headers $headers -WebSession $session -Body $body -ContentType "application/x-www-form-urlencoded" -MaximumRedirection 1 | Out-Null
    } catch {
        return ($_ -split "access_token=" -split "&scope")[1]
    }
}

$token = GetToken -email $email -password $password
Write-Host "Bearer $token"

