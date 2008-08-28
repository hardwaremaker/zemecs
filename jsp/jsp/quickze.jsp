<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.lp.webapp.frame.*"%>
<%TheClient theClient = (TheClient) session.getAttribute(session.getId());%>
<html>
<meta name="pragma" content="no-cache">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="expires" content="0">
<title>HeliumV Logon</title>
<head>
<script type="text/javascript">

function pruefen() {

    if(document.cookie){

      if(getURLParam('reenter')=='true'){
      }else {
        a=document.cookie;
        if(a.search("anmeldename")!= -1){
          user=a.substring(a.indexOf("=",a.search("anmeldename"))+1,a.indexOf(";",a.search("anmeldename")));
          pass=a.substring(a.indexOf("=",a.search("pass"))+1,a.indexOf(";",a.search("pass")));
          locale=a.substring(a.indexOf("=",a.search("locale"))+1,a.indexOf(";",a.search("locale")));
          document.logon.username.value=user;
          document.logon.password.value=pass;
          document.logon.locale.value=locale;
          document.logon.submit();
        }
      }
    }

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

function savecookie() {

    var ablauf = new Date();
var infuenfTagen = ablauf.getTime() + (30 * 24 * 60 * 60 * 1000);
ablauf.setTime(infuenfTagen);

document.cookie = "anmeldename="+document.logon.username.value+";";
document.cookie = "expires=" + ablauf.toGMTString()+";";
document.cookie = "pass="+document.logon.password.value+";";
document.cookie = "locale="+document.logon.locale.value+";";
document.cookie = "Max-Age=2592000;";
document.logon.submit();
}
</script>
</head>
<body onload="pruefen()">
<form name="logon" action="<%= response.encodeURL(theClient.getSContextServletPath() + "?cmd=" + TheApp.CMD_ZE_QUICKZEITERFASSUNG)%>" method="post">
<p><font face="Verdana"><b>Login für HeliumV Quickzeiterfassung:</b></font></p>

<table border="0" width="240" cellspacing="1" cellpadding="0">
    <tr>
      <td width="80">  <font face="Verdana">Benutzername&nbsp;&nbsp;&nbsp;</font></td>
      <td width="150">
<input type="text" name="username" size="20">
      </td>
    </tr>
    <tr>
      <td width="80">
  <font face="Verdana">
  Passwort&nbsp;</font></td>
      <td width="150">
<input type="password" name="password" size="20">
      </td>
    </tr>
<tr>
      <td width="80">
  <font face="Verdana">
  Sprache&nbsp;</font></td>
      <td width="150">
<input type="text" name="locale" size="20">
      </td>
    </tr>
    <tr>
      <td width="212" colspan="2">
<input type="button" value="Anmelden" name="login" onclick="savecookie()">
      </td>
    </tr>
  </table>


</form>
</body>
</html>
