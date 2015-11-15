<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@ taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>知识库管理</title>
<link href="res/views/default/css/basic.css" rel="stylesheet" />
<link href="res/views/default/css/index.css" rel="stylesheet" />
</head>
<body>
	<div class="wrap">
		<div class="margincenter">
			<div class="mainDetail">
				<div>
					<p>
						<span class=" spandetail">标题：</span>
						<input type="text" name="title" class="js_title txtvalue" />
					</p><br/>
					<p>
						<span class=" spandetail">内容：</span>
						<input type="text" name="content" class="js_content txtvalue" />
					</p><br/>
					</div>
					<div class="btndiv">
						<input type="button" class="btnorder" value="确定" onclick="addQuickReply()"/> 
						<input type="reset" class="btnorder"  value="取消" />
					</div>
	
				</div>
		</div>
		</div>

 
</body>
</html>
	<script type="text/javascript" src="res/views/default/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="res/views/default/js/quickReply/addQuickReply.js"></script>
	<script type="text/javascript" src="res/views/default/js/basic.js"></script>
