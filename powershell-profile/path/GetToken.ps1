param (
    [Parameter(Mandatory=$false)]
    [string]$email = "microlise@microlise.com",
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
    $response1 = Invoke-WebRequest -Method "GET" -Uri $uri -MaximumRedirection 0 -SessionVariable session -ErrorAction Ignore
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
    Invoke-WebRequest -Method "POST" -Uri $uri -WebSession $session -Body $body -ContentType "application/x-www-form-urlencoded" -MaximumRedirection 9 | Out-Null

    $uri = "https://microlise-test.eu.auth0.com/u/login/password?state=$state"
    $body = @{
        "state" = "$state";
        "username" = "$email";
        "password" = "$password";
        "action" = "default";
    }
    try {
        Invoke-WebRequest -Method "POST" -Uri $uri -WebSession $session -Body $body -ContentType "application/x-www-form-urlencoded" -MaximumRedirection 1 | Out-Null
    } catch {
        return ($_ -split "access_token=" -split "&scope")[1]
    }
}

$token = GetToken -email $email -password $password
return "Bearer $token"
