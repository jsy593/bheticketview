<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>快捷回复详情</title>
<link href="res/views/default/css/basic.css" rel="stylesheet" />
<link href="res/views/default/css/index.css" rel="stylesheet" />
</head>
<body>
	<div class="wrap">
		<div class="margincenter">
			<div class="clear"></div>
		    	<div class="mainDetail">
		    	<input type="hidden" value="${quickReply.uuid}" class="js_uuid"/>
		            <div><span class="spandetail">标题：</span>${quickReply.title }</div>
		            <div><span class="spandetail">内容：</span>${quickReply.content }</div>
		            <div><span class="spandetail">提交人：</span>${quickReply.username }</div>
		            
		            
		            <c:if test="${quickReply.status == 0}">
		            	<div><span class="spandetail">状态：</span>隐藏</div>
		            </c:if>
		            <c:if test="${quickReply.status == 1}">
		            	<div><span class="spandetail">状态：</span>显示</div>
		           	</c:if>
		            <c:if test="${quickReply.status == 2}">
		            	<div><span class="spandetail">状态：</span>已删除</div>
		           	</c:if>
		            <div><span class="spandetail">时间：</span>${quickReply.createTime }</div>
		          
		        </div>
		        <c:if test="${quickReply.status == 0}">
	            <div class="btndiv">
	                <input type="button" class="btnorder" onclick="changeStatus(1)" value="显示" />
<!-- 	                 <input type="button" class="btnorder" onclick="changeStatus(2)" value="删除" /> -->
	            </div>
	            </c:if>
		        <c:if test="${quickReply.status == 1}">
	            <div class="btndiv">
	                <input type="button" class="btnorder" onclick="changeStatus(0)" value="隐藏" />
<!-- 	                 <input type="button" class="btnorder" onclick="changeStatus(2)" value="删除" /> -->
	            </div>
	            </c:if>
		       
		</div>
    </div>

</body>
</html>
	<script type="text/javascript" src="res/views/default/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="res/views/default/js/quickReply/quickReplyDetails.js"></script>
	<script type="text/javascript" src="res/views/default/js/basic.js"></script>