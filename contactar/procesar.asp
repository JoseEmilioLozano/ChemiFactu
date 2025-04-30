<!--#include file="../conexion.asp"-->
<%
'prevenir spam con honeypot
if (Request.Form("secondname") <> "") then
    response.end  'no hacer nada si es spam
end if

Nombre = request.form("name")
Email = request.form("email")
Mensaje = request.form("message")
Telefono = request.form("telefono")

if Telefono="" Then
  Telefono = " "
end if

if isNull(Telefono) Then
  Telefono = " "
end if

Browser = Request.ServerVariables("HTTP_USER_AGENT")

FechaMensaje = Date()

Dim ObjSendMail
Set ObjSendMail = CreateObject("CDO.Configuration")
Set objSendmsg =  CreateObject ("CDO.Message")
ObjSendMail.Fields ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
ObjSendMail.Fields ("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "smtp.dondominio.com"
'ObjSendMail.Fields ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 465 '587
ObjSendMail.Fields ("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = true 'Use SSL for the connection
ObjSendMail.Fields ("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") =60
ObjSendMail.Fields ("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1 'basic (clear-text) authentication
ObjSendMail.Fields ("http://schemas.microsoft.com/cdo/configuration/sendusername") = "sevidor_emails@abacosoftware.com"
ObjSendMail.Fields ("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "3333333"

ObjSendMail.Fields.Update
set objSendmsg.Configuration = ObjSendMail

objSendmsg.From = "sevidor_emails@abacosoftware.com"
objSendmsg.Subject = "Contacto nuevo desde Carrito5 (segundo formulario)"

htmlBOdy = "<h2>Nuevo contacto desde Carrito5 (segundo formulario)</h2>"
htmlBOdy = htmlBOdy & "Nombre: " & Nombre & "<br/>"
htmlBOdy = htmlBOdy & "Email: " & Email & "<br/>"
htmlBOdy = htmlBOdy & "Teléfono: " & Telefono & "<br/>"
htmlBOdy = htmlBOdy & "Mensaje: " & Mensaje & "<br/>"
htmlBOdy = htmlBOdy & "Navegador: " & Browser & "<br/>"
objSendmsg.HTMLBody = htmlBOdy

objSendmsg.BodyPart.Charset = "utf-8"
objSendmsg.TextBodyPart.Charset = "utf-8"
objSendmsg.HTMLBodyPart.Charset = "utf-8"
objSendmsg.To = "emilio@caja5.es"
objSendmsg.Send

queryInsertarContacto = "INSERT INTO contactos (nombre, email, fecha_mensaje, ip, plan) "
queryInsertarContacto = queryInsertarContacto & " VALUES "
queryInsertarContacto = queryInsertarContacto & "(?, ?, ?, ?, ?)"

set cmd = server.createobject("ADODB.Command")
cmd.ActiveConnection = Cnx
cmd.CommandText = queryInsertarContacto
cmd.CommandType = 1

IP = Request.ServerVariables("REMOTE_ADDR")
cmd.Parameters.Append cmd.CreateParameter("nombre", 200, 1, 200, Nombre)
cmd.Parameters.Append cmd.CreateParameter("email", 200, 1, 200, Email)
cmd.Parameters.Append cmd.CreateParameter("fecha", 200, 1, 200, FechaMensaje)
cmd.Parameters.Append cmd.CreateParameter("ip", 200, 1, 200, IP)
cmd.Parameters.Append cmd.CreateParameter("plan", 200, 1, 200, Plan)

cmd.Execute()
%>
