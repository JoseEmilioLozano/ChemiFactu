<% '#v.2 27-12-2019 11:48:32# %>
<%
Response.ContentType = "text/html"
Response.AddHeader "Content-Type", "text/html;charset=UTF-8"
Response.CodePage = 65001
Response.CharSet = "UTF-8"

Set Cnx=Server.CreateObject("ADODB.Connection")
bbdd = Server.MapPath("../../datos/datos.mdb")

Cnx.Open "Provider=Microsoft.Jet.OLEDB.4.0; Data Source='" & bbdd & "';User Id=Admin;Password="
%>
