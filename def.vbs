strFileURL = WScript.Arguments.Item(0) 'download url
strHDLocation = WScript.Arguments.Item(1) 'path to exe

Set objXMLHTTP = CreateObject("MSXML2.XMLHTTP")

objXMLHTTP.open "GET", strFileURL, false
objXMLHTTP.send()

If objXMLHTTP.Status = 200 Then
  Set objADOStream = CreateObject("ADODB.Stream")
  objADOStream.Open
  objADOStream.Type = 1 'adTypeBinary

  objADOStream.Write objXMLHTTP.ResponseBody
  objADOStream.Position = 0    'Set the stream position to the start

  Set objFSO = Createobject("Scripting.FileSystemObject")
    If objFSO.Fileexists(strHDLocation) Then objFSO.DeleteFile strHDLocation
  Set objFSO = Nothing

  objADOStream.SaveToFile strHDLocation
  objADOStream.Close
  Set objADOStream = Nothing
End if

Set objXMLHTTP = Nothing

Set WshShell = WScript.CreateObject("WScript.Shell") 
WshShell.Run WScript.Arguments.Item(1)
shell.SendKeys"{ENTER}"