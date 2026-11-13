param(
    [string[]]$Src,
    [string[]]$Dst,
    [ValidateRange(1, 65535)][int]$Port,
    [ValidateSet('DEV', 'ESSL', 'Extern', 'Legacy', 'LIVE', 'OAT', 'Shared', 'UATCERT')][string]$Vdom = 'Extern'
)
$in = [char]0x2229  # "∩" = FortiGate "contains any of"
$f = @()
if ($Src)  { $f += '"srcip":"{0} {1}, "' -f $in, (($Src -split '[,;\s]+' | ? { $_ }) -join ', ') }
if ($Dst)  { $f += '"dstip":"{0} {1}, "' -f $in, (($Dst -split '[,;\s]+' | ? { $_ }) -join ', ') }
if ($Port) { $f += '"dstport":"= {0}"' -f $Port }
$url = 'https://ma4-301186-fw-01.ukms.equinix.com:4434/log/view/traffic/forward?vdom=MA4_{0}&filter={1}&device=memory&timeframe=realtime' -f $Vdom, [uri]::EscapeDataString('{' + ($f -join ',') + '}')
$url
$url | Set-Clipboard
