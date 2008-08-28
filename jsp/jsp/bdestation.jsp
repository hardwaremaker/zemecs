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
function loescheMeldung () {
 document.getElementById('meldung').innerHTML = "";
}

window.setTimeout("loescheMeldung()", 15000);
</script>



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
function getURLParam(strParamName){
  var strReturn = "";
  var strHref = window.location.href;
  if ( strHref.indexOf("&") > -1 ){
    var strQueryString = strHref.substr(strHref.indexOf("&")).toLowerCase();
    var aQueryString = strQueryString.split("&");
    for ( var iParam = 0; iParam < aQueryString.length; iParam++ ){
      if (
aQueryString[iParam].indexOf(strParamName + "=") > -1 ){
        var aParam = aQueryString[iParam].split("=");
        strReturn = aParam[1];
        break;
      }
    }
  }
  return strReturn;
}
</script>
<script type="text/javascript">
function selectFeld() {


  if(getURLParam('done') =='true'){
    uhrzeit();
    document.bde.ausweis.value="";
    document.bde.ausweis.focus();

  } else {
    uhrzeit();
    document.bde.ausweis.value="";
    document.bde.ausweis.focus();
    window.open('/ze/ze?cmd=<%=TheApp.CMD_ZE_BDESTATION%>&done=true','','fullscreen=yes, scrollbars=no');
    window.opener = top;
    window.self.close();
  }
}
</script>
</head>
<body onload="selectFeld()">
<form name="systemzeit" action="">
<p align="center">
  <font face="Verdana" size="6">    HeliumV BDE-Station
    <br>
  </font>
  <font face="Verdana">Aktuelle Uhrzeit:</font>
  <input type="text" name="zeit" size="6" readonly="readonly">

</Form>
<hr>
<form name="bde" action="<%= response.encodeURL(theClient.getSContextServletPath() + "?cmd=" + TheApp.CMD_ZE_BDESTATION+"&done=true") %>" method="POST">
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
      <font face="Verdana">        Ausweisnummer:
        &nbsp;
      </font>
    </td>
    <td width="50%">
      <p>        &nbsp;
        <input type="text" name="ausweis" size="27">

    </td>
  </tr>
  <tr>  </tr>
</table>
<input type="hidden" name="done" value="true"/>
</form>
<hr>

<font face="Verdana">
  <u>Letzte Meldung:</u>
  <br>

  <div id="meldung"><%= theClient.getSMsg() %></div>

</font>

<hr>
</body>
</html>
