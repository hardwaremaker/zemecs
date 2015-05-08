<%@page import="javax.servlet.http.HttpUtils.*"%>
<%@page import="com.lp.webapp.frame.*"%>
<%TheClient theClient = (TheClient) session.getAttribute(session.getId());%>
<html>
<meta name="pragma" content="no-cache">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="expires" content="0">

<head>

<title>HeliumV BDE-Station</title>
<script type="text/javascript">
function uhrzeit()
{
var zeit = new Date();
var Uhrzeit;

if(zeit.getHours() < 10) {Uhrzeit="0" + zeit.getHours() + ":";}
else {Uhrzeit=zeit.getHours() + ":";}

if(zeit.getMinutes() < 10) {Uhrzeit=Uhrzeit + "0" + zeit.getMinutes() + ":";}
else {Uhrzeit=Uhrzeit + zeit.getMinutes() + ":";}

if(zeit.getSeconds() < 10) {Uhrzeit=Uhrzeit + "0" + zeit.getSeconds();}
else {Uhrzeit=Uhrzeit + zeit.getSeconds();}

document.systemzeit.zeit.value=Uhrzeit;
window.setTimeout("uhrzeit()",1000);
}
</script>
<script type="text/javascript">
function selectFeld() {
        uhrzeit();
        document.bde.option.value="";
        document.bde.option.focus();
}
</script>
</head>
<body onload="selectFeld()">

<form name="systemzeit" action="" >
<p align="center"><font face="Verdana" size="6">HeliumV BDE-Station<br>
</font>
<font face="Verdana">
Aktuelle Uhrzeit:</font> <input type="text" name="zeit" size="6" readonly="readonly">
</form>
<hr>
<form name="bde" action="<%= response.encodeURL(theClient.getSContextServletPath() + "?cmd=" + TheApp.CMD_ZE_BDESTATION2+"&done=true") %>" method="POST">
<p align="right">
  <a href="javascript:window.close()">
    <font face="Verdana">
      <b>X SCHLIESSEN</b>
    </font>
  </a>
</p>
<table border="0" width="100%" cellspacing="0" cellpadding="0">
  <tr>
    <td width="50%" align="right">
      <font face="Verdana">        Person:
        &nbsp;
      </font>
    </td>
    <td width="50%">
      <p> <font face="Verdana">&nbsp;<b> <%=((java.util.HashMap)theClient.getData()).get("person")%></b></font>
    </td>
  </tr>
  <tr>
    <td width="50%" align="right">
      <font face="Verdana">        Beleg/ Sondert&auml;tigkeit/ Kombi-Code:
        &nbsp;
      </font>
    </td>
    <td width="50%">
      <p>        &nbsp;
        <input type="text" name="option" size="27">

    </td>
  </tr>

</table>
</form>
<hr>
</body>
</html>
