param (
    [Parameter()]
    [switch]$Demo,
    [Parameter()]
    [string]$Email,
    [Parameter()]
    [string]$Password
)

function GetToken {
    param (
        [Parameter(Mandatory=$true)]
        [string]$tenant,
        [Parameter(Mandatory=$true)]
        [string]$client_id,
        [Parameter(Mandatory=$true)]
        [string]$email,
        [Parameter(Mandatory=$true)]
        [string]$password,
        [Parameter(Mandatory=$false)]
        [string]$response_type = "token",
        [Parameter(Mandatory=$false)]
        [string]$scope = "openid email",
        [Parameter(Mandatory=$false)]
        [string]$redirect_uri = "https://localhost"
    )

    $uri = "https://$tenant.eu.auth0.com/authorize?response_type=$response_type&client_id=$client_id&scope=$scope&redirect_uri=$redirect_uri"
    $response1 = Invoke-WebRequest -Method "GET" -Uri $uri -MaximumRedirection 0 -SessionVariable session -ErrorAction Ignore
    $state = ($response1.Headers.Location -split "state=")[1] 

    $uri = "https://$tenant.eu.auth0.com/u/login/identifier?state=$state"
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

    $uri = "https://$tenant.eu.auth0.com/u/login/password?state=$state"
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

if ($demo.IsPresent) {
    $tenant = "microlise-demo"
    $client_id = "kjuA6qqOfegjrVhFn16JUe5ZZT5Gf4VE"

    if ($email -eq "")  {
        $creds = IMPORT-CLIXML -Path "$env:USERPROFILE\demo-aries.creds"
        $email = $creds.UserName
        $password = $creds.GetNetworkCredential().Password
    }

    Write-Host "Generating a token for $email in the demo environment"
} else {
    $tenant = "microlise-test"
    $client_id = "iIEWwXq9a29FJPqpbcKQxAbMgdJQKiuQ"

    if ($email -eq "") {
        $creds = IMPORT-CLIXML -Path "$env:USERPROFILE\lab-aries.creds"
        $email = $creds.UserName
        $password = $creds.GetNetworkCredential().Password
    }

    Write-Host "Generating a token for $email in the lab environment"
}

$token = GetToken -tenant $tenant -client_id $client_id -email $email -password $password
return "`nBearer $token"
