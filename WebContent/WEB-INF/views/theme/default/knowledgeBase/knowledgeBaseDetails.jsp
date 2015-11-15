<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>知识库详情</title>
<link href="res/views/default/css/basic.css" rel="stylesheet" />
<link href="res/views/default/css/index.css" rel="stylesheet" />
</head>
<body>
	<div class="wrap">
	<div class="margincenter">
		<div class="clear"></div>
	    	<div class="mainDetail">
	    	<input type="hidden" value="${knowledgeBase.uuid}" class="js_uuid"/>
	            <div><span class="spandetail">问题：</span>${knowledgeBase.question }</div>
	            <div><span class="spandetail">回答：</span>${knowledgeBase.answer }</div>
	            <div><span class="spandetail">提交人：</span>${knowledgeBase.username }</div>
	            
	            
	            <c:if test="${knowledgeBase.status == 1}">
	            	<div><span class="spandetail">状态：</span>正常</div>
	            </c:if>
	            <c:if test="${knowledgeBase.status == 2}">
	            	<div><span class="spandetail">状态：</span>待审核</div>
	           	</c:if>
	            <c:if test="${knowledgeBase.status == 3}">
	            	<div><span class="spandetail">状态：</span>失效</div>
	           	</c:if>
	            <c:if test="${knowledgeBase.status == 4}">
	            	<div><span class="spandetail">状态：</span>删除</div>
	           	</c:if>
	            <div><span class="spandetail">排序值：</span>${knowledgeBase.rank }</div>
	            <div><span class="spandetail">时间：</span>${knowledgeBase.createTime }</div>
	            <div><span class="spandetail">问题分类：</span>${knowledgeBase.typeName }</div>
	          	<c:if test="${roleinfo.code == 'departmentAdmin' }">
	       		   	<c:if test="${knowledgeBase.status == 2}">
	          			<input type="button" class="btnorder"  onclick="changeStatus(1,'${knowledgeBase.uuid}', '${userinfo.systemIndex }')" value="通过" />
		            	<input type="button" class="btnorder" onclick="changeStatus(3,'${knowledgeBase.uuid}', '${userinfo.systemIndex }')" value="不通过" />
	          		</c:if>
	          		<c:if test="${knowledgeBase.status == 1}">
	          			<input type="button" class="btnorder" onclick="changeStatus(3,'${knowledgeBase.uuid}', '${userinfo.systemIndex }')" value="禁用" />
	                </c:if>
	                <c:if test="${knowledgeBase.status == 3}">
	          			<input type="button" class="btnorder"  onclick="changeStatus(1,'${knowledgeBase.uuid}', '${userinfo.systemIndex }')" value="启用" />
		           	</c:if>
	          	</c:if>
	        </div>
	</div>
    </div>

</body>
</html>
	<script type="text/javascript" src="res/views/default/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="res/views/default/js/knowledgeBase/knowledgeBaseDetails.js"></script>
	<script type="text/javascript" src="res/views/default/js/basic.js"></script>