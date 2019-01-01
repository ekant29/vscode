<#
EmailFrom,noreply@smartusys.com
EmailPassword,Smart@2013
EmailHost,10.100.1.216
EmailUser,noreply@smartusys.com
#>

function Send-ToEmail([string]$email)
{
    $Username = 'SchedulerMonitoring@smartenergywater.in'
    $Password = 'Smart2018%'
    $message = new-object Net.Mail.MailMessage
    $message.From = "SchedulerMonitoring@smartenergywater.in"
    $message.To.Add($email)
    #$message.CC.Add($emailCC)
    $message.Subject = 'abc'
    $message.Body = 'abcde'
    $message.IsBodyHtml = $true
    #$attachment = New-Object Net.Mail.Attachment($attachmentpath)
    #$message.Attachments.Add($attachment)

    $smtp = new-object Net.Mail.SmtpClient("smtp.office365.com", "587")
    $smtp.EnableSSL = $true
    $smtp.Credentials = New-Object System.Net.NetworkCredential($Username, $Password)
    $smtp.send($message)
    #$attachment.Dispose()
 }

Send-ToEmail  -email "ekant29@gmail.com"
