<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>登录</title>
<link href="res/views/default/css/basic.css" rel="stylesheet" />
<link href="res/views/default/css/index.css" rel="stylesheet" />
</head>

<body class="bgbody">
	<div class="wrap">
    	<div class="warp-login">
        	<div class="login">
                <div><h1 class="loginh1">BHE通用工单系统</h1></div>
                <div class="logindiv">
                    <label class="labellogin">登录账号：</label><input  type="text" class="txtlogin"/>
                </div>
                <div class="logindiv">
                    <label class="labellogin">登录密码：</label><input  type="password" class="txtlogin"/>
                </div>
                <div> 
                    <input type="submit"  value="登录" class="btnlogin"/> 
                    <a href="toRegist" class="colorccc">注册</a>/<a href="toFindPwd" class="colorccc">找回密码</a>
                </div>
       		</div>        
        </div>    	
    </div>
	
	<script type="text/javascript" src="res/views/default/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="res/views/default/js/index.js"></script>
</body>
</html>
