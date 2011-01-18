<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.lp.webapp.frame.*"%>
<%TheClient theClient = (TheClient) session.getAttribute(session.getId());%>
<% theClient.setUserName(System.getProperty("user.name"));%>
<html>
<meta name="pragma" content="no-cache">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="expires" content="0">
<title>HeliumV Online-Zeiterfassung</title>
<head>


<script type="text/javascript">
function refreshAuftraegeUndArtikel() {
  document.kunden.kunde.value="";
  document.kunden.belegart.value=document.belegarten.belegart.value;
  document.auftraege.auftrag.value="";
  document.artikel.artikel.value="";
  document.kunden.submit();
}
</script>

<script type="text/javascript">
function refreshArtikel() {
  document.auftraege.kunde.value=document.kunden.kunde.value;
  document.auftraege.belegart.value=document.belegarten.belegart.value;
  document.auftraege.submit();
}
</script>

<script type="text/javascript">
function bucheAufAuftrag() {
  document.artikel.bucheauftrag.value="true";
  document.artikel.bemerkung.value=document.bemerkung.bemerkung.value;
  document.artikel.kunde.value=document.kunden.kunde.value;
  document.artikel.auftrag.value=document.auftraege.auftrag.value;
  document.artikel.belegart.value=document.belegarten.belegart.value;
  document.artikel.submit();
  window.blur();
}
</script>
<script type="text/javascript">
function bucheSondertaetigkeit() {
  document.taetigkeiten.buchesondertaetigkeit.value="true";
  document.taetigkeiten.bemerkung.value=document.bemerkung.bemerkung.value;
  document.taetigkeiten.belegart.value=document.belegarten.belegart.value;
  document.taetigkeiten.submit();
  window.blur();
}
</script>
<script type="text/javascript">
function maximize() {
  window.moveTo(0, 0);
  window.resizeTo(screen.width, screen.height);
  if(document.cookie){
      var ablauf = new Date();
var infuenfTagen = ablauf.getTime() + (30 * 24 * 60 * 60 * 1000);
   ablauf.setTime(infuenfTagen);
   document.cookie = "expires=" + ablauf.toGMTString()+";";
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
</head>
<body onload="maximize()">

<table border="1" width="1010" cellspacing="0" cellpadding="0">
  <tr>
    <td width="100%" colspan="4">
       <%
      HashMap hm = (HashMap) theClient.getData();
      String person = (String) hm.get("person");
    %>
      <p align="center">
        <font face="Verdana" size="6"><%= person %>        </font>

    </td>
  </tr>
  <tr>
    <td width="150"><font face="Verdana" size="4"><input type="button" value="<%=hm.get("bezeichnung_sondertaetigkeit")%>" name="taet" onclick="bucheSondertaetigkeit()"></font></td>
    <td width="300"><font face="Verdana" size="4"><%=hm.get("bezeichnung_kunde")%></font></td>
    <td width="300"><font face="Verdana" size="4"><%=hm.get("bezeichnung_offenerauftrag")%></font></td>
    <td width="300"><font face="Verdana" size="4"><input type="button" value="<%=hm.get("bezeichnung_taetigkeit")%>" name="auft" onclick="bucheAufAuftrag()"></font></td>
  </tr>
   <tr>
    <td valign="top">

    <form name="taetigkeiten" action="<%= response.encodeURL(theClient.getSContextServletPath() + "?cmd=" + TheApp.CMD_ZE_QUICKZEITERFASSUNG)%>" method="post">
      <input type="hidden" name="buchesondertaetigkeit" size="20">
      <input type="hidden" name="bemerkung" size="20">
       <input type="hidden" name="belegart" size="20">
      <select size="15" name="taetigkeit" ondblclick="bucheSondertaetigkeit()">
      <%
        LinkedHashMap taetigkeiten = (LinkedHashMap) hm.get("taetigkeiten");
        Iterator it = taetigkeiten.keySet().iterator();
        while (it.hasNext()) {
          Object key = it.next();
          Object value = taetigkeiten.get(key);
      %>
        <option value="<%= key %>"><%= value %>        </option>
      <%}      %>
      </select>
    </form>
    <font face="Verdana" size="4"><%=hm.get("bezeichnung_belegart")%></font>
 <form name="belegarten" action="<%= response.encodeURL(theClient.getSContextServletPath() + "?cmd=" + TheApp.CMD_ZE_QUICKZEITERFASSUNG)%>" method="post">
      <input type="hidden" name="buchesondertaetigkeit" size="20">
      <input type="hidden" name="bemerkung" size="20">
      <select size="5" name="belegart" onclick="refreshAuftraegeUndArtikel()">
      <%
        LinkedHashMap belegarten = (LinkedHashMap) hm.get("belegarten");
        Iterator itBel = belegarten.keySet().iterator();
        String selected = "";
        while (itBel.hasNext()) {
          Object key = itBel.next();
          Object value = belegarten.get(key);
          selected = "selected";
          if (hm.get("selectedbelegart") != null && hm.get("selectedbelegart").equals(key)) {
            selected = "selected";
          }
          else {
            selected = "";
          }
      %>
        <option <%= selected%>  value="<%= key %>"><%= value %>        </option>
      <%}      %>
      </select>
    </form>
    </td>
    <td width="25%">

    <form name="kunden" action="<%= response.encodeURL(theClient.getSContextServletPath() + "?cmd=" + TheApp.CMD_ZE_QUICKZEITERFASSUNG)%>" method="post">
       <input type="hidden" name="belegart" size="20">
      <select size="25" name="kunde" onclick="refreshAuftraegeUndArtikel()">
      <%
        hm = (HashMap) theClient.getData();
        LinkedHashMap tm = (LinkedHashMap) hm.get("kunden");
        it = tm.keySet().iterator();
        selected = "";
        while (it.hasNext()) {
          Object key = it.next();
          Object value = tm.get(key);
            selected = "selected";
          if (hm.get("selectedkunde") != null && hm.get("selectedkunde").equals(key)) {
            selected = "selected";
          }
          else {
            selected = "";
          }
      %>
        <option <%= selected%> value=" <%=key %>"><%= value %>        </option>
      <%}      %>
      </select>
      </form>

    </td>
    <td width="25%">
     <form name="auftraege" action="<%= response.encodeURL(theClient.getSContextServletPath() + "?cmd=" + TheApp.CMD_ZE_QUICKZEITERFASSUNG)%>" method="post">
     <input type="hidden" name="kunde" size="20">
      <input type="hidden" name="belegart" size="20">
     <select size="25" name="auftrag" onclick="refreshArtikel()">
      <%
        LinkedHashMap auftraege = (LinkedHashMap) hm.get("auftraege");
        if (auftraege != null) {
          it = auftraege.keySet().iterator();
          while (it.hasNext()) {
            Object key = it.next();
              Object value = auftraege.get(key);
            selected = "selected";
          if (hm.get("selectedauftrag") != null && hm.get("selectedauftrag").equals(key.toString())) {
            selected = "selected";
          }
          else {
            selected = "";
          }

      %>
        <option  <%= selected%> value="<%= key %>"><%= value %>        </option>
      <%}}      %>
      </select>
     </form>
    </td>
    <td width="25%">

    <form name="artikel" action="<%= response.encodeURL(theClient.getSContextServletPath() + "?cmd=" + TheApp.CMD_ZE_QUICKZEITERFASSUNG)%>" method="post">
    <input type="hidden" name="bucheauftrag" size="20">
    <input type="hidden" name="bemerkung" size="20">
    <input type="hidden" name="kunde" size="20">
    <input type="hidden" name="belegart" size="20">
    <input type="hidden" name="auftrag" size="20">
     <select size="25" name="artikel" ondblclick="bucheAufAuftrag()">
      <%
        LinkedHashMap artikel = (LinkedHashMap) hm.get("artikel");
        if (auftraege != null) {
          it = artikel.keySet().iterator();
          while (it.hasNext()) {
            Object key = it.next();
            Object value = artikel.get(key);
      %>
        <option value="<%= key %>"><%= value %>        </option>
      <%}}      %>
      </select>
    </form>
    </td>
  </tr>

  <tr>

    <td width="25%"></td>
    <td width="75%" colspan="3"><font face="Verdana" size="4"><%=hm.get("bezeichnung_bemerkung")%>:</font> <br>

     <form name="bemerkung" action="">


      <input type="text" name="bemerkung" size="80">
      </form>


  </tr>
  <tr>
    <td width="100%" colspan="4">
    <font face="Verdana" size="4"><%= theClient.getSMsg()%>      </font>
    </td>
  </tr>
</table>
</body>
</html>
