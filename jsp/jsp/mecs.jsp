<%@ page import="java.io.*" %><%@ page import="com.lp.webapp.frame.*" %><% TheClient theClient = (TheClient)session.getAttribute(session.getId()); %><%= theClient.getSMsg() %>
