<%@ page import="javax.servlet.http.HttpUtils.*" %>
<%@ page import="com.lp.webapp.frame.*" %>
<% TheClient theClient = (TheClient)session.getAttribute(session.getId()); %>
<?xml version="1.0" encoding="UTF-8"?>
<html>
<head>
</head>
<body>
  <p>F: <%= theClient.getSMsg() %></p>
</body>
</html>
