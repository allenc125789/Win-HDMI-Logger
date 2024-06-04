$runscript = 1;

while($runscript -eq 1)
{
    $wmiobject = (get-wmiobject -namespace root\WMI -computername localhost -Query "Select * from WmiMonitorConnectionParams")
    $HDMI_Monitors = 0;
    $datenow = (Get-Date -Format "dddd MM/dd/yyyy hh:mm:%s")
    foreach ($letter in $wmiobject)
    {
        if($letter["VideoOutputTechnology"] -eq 5) #HDMI cable have value of 5 
        {
            $HDMI_Monitors += 1;
        }
    }
    if($HDMI_Monitors -ne $current_conns)
    {
        $current_conns = $HDMI_Monitors;
        "$current_conns Monitor(s) connected. $datenow" | Add-Content -Path .\HDMI-logs.txt
    }
    if ( [ System.Environment ]:: HasShutdownStarted )
    {
        $runscript = 0
    }
}
