<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>系统详情</title>
<link href="res/views/default/css/basic.css" rel="stylesheet" />
<link href="res/views/default/css/index.css" rel="stylesheet" />
</head>
<body>
	<div class="clear"></div>
	<div class="wrap">
		<div class="margincenter">
	    	<div class="mainDetail">
	    	<input type="hidden" value="${system.uuid}" class="js_uuid"/>
	    	<input type="hidden" value="${system.systemName}" class="js_systemName"/>
	            <div><span class="spandetail">系统名称：</span>${system.systemName }</div>
	            <div><span class="spandetail">管理员：</span>${system.username }</div>
	            <div><span class="spandetail">appId：</span>${system.appId }</div>
	            <div><span class="spandetail">key：</span>${system.appKey }</div>
	            
	            
	            <c:if test="${system.status == 0}">
	            	<div><span class="spandetail">状态：</span>待审核</div>
	            </c:if>
	            <c:if test="${system.status == 1}">
	            	<div><span class="spandetail">状态：</span>正常</div>
	           	</c:if>
	            <c:if test="${system.status == 2}">
	            	<div><span class="spandetail">状态：</span>冻结</div>
	           	</c:if>
	            <c:if test="${system.status == 3}">
	            	<div><span class="spandetail">状态：</span>审核未通过</div>
	           	</c:if>
	            <div><span class="spandetail">时间：</span>${system.createTime }</div>
	            <div><span class="spandetail">备注：</span>${system.remark }</div>
	            <c:if test="${system.status == 0}">
	            <div class="btndiv">
	                <input type="button" class="btnorder"  onclick="changeStatus(1)" value="通过" />
	                <input type="button" class="btnorder" onclick="changeStatus(3)" value="不通过" />
	            </div>
	            </c:if>
	            <c:if test="${system.status == 1}">
	            <div class="btndiv">
	                <input type="button" class="btnorder" onclick="changeStatus(2)" value="冻结" />
	            </div>
	            </c:if>
	            <c:if test="${system.status == 2}">
	            <div class="btndiv">
	                <input type="button" class="btnorder" onclick="startSystem(1)" value="启用" />
	            </div>
	            </c:if>
	            <%-- 
	            <c:if test="${system.status == 3}">
	            <div class="btndiv">
	                <input type="button" class="btnorder" onclick="changeStatus(1)" value="通过" />
	            </div>
	            </c:if> --%>
	        </div>
		</div>
    </div>

</body>
</html>
	<script type="text/javascript" src="res/views/default/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="res/views/default/js/system/systemDetails.js"></script>
	<script type="text/javascript" src="res/views/default/js/basic.js"></script>