<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><tiles:insertAttribute name="title" ignore="true" /></title>

<link rel="stylesheet" href="<c:url value="res/views/default/css/basic.css"/>"> 
<link rel="stylesheet" href="<c:url value="res/views/default/css/index.css"/>"> 
</head>
<body>


<tiles:insertAttribute name="header" />

<tiles:insertAttribute name="center"/>

<tiles:insertAttribute name="footer"/>

</body>
</html>