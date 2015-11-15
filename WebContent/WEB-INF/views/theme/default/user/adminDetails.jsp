<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>系统管理员详情</title>
<link href="res/views/default/css/basic.css" rel="stylesheet" />
<link href="res/views/default/css/index.css" rel="stylesheet" />
</head>
<div class="clear"></div>
<body>
	<div class="wrap">
		<div class="margincenter">
	    	<div class="mainDetail">
	    	<input type="hidden" class="js_uuid" value="${user.uuid}">
	             <div class="height30"><span>姓名：</span>${user.realName}</div>
	             <div class="height30"><span>账号：</span>${user.username}</div>
	            <div class="height30"><span>邮箱：</span>${user.email}</div>
	            <div class="height30"><span>电话：</span>${user.phone}</div>
	            <div class="height30"><span>性别：</span>${user.sex}</div>
	            <div class="height30">	            
		            <c:if test="${user.status == 0}">
		            	<div><span>状态：</span>待审核</div>
		            </c:if>
		            <c:if test="${user.status == 1}">
		            	<div><span >状态：</span>正常</div>
		            </c:if>
		            <c:if test="${user.status == 2}">
		            	<div><span>状态：</span>审核未通过</div>
		            </c:if>
		            <c:if test="${user.status == 3}">
		            	<div><span>状态：</span>删除</div>
		            </c:if>
		            <c:if test="${user.status == 4}">
		            	<div><span>状态：</span>冻结</div>
		            </c:if>
	            </div> 
	            <div class="height30"><span>备注：</span>${user.remark}</div>
	            <div class="height30"><span>时间：</span>${user.createTime}</div>
	            <div class="btndiv">
	            
	            <c:if test="${user.status == 0}"><!-- 未审核 -->
	                <input type="button" class="js_pass btnorder" onclick="changeStatus(1)" value="通过" />
	                <input type="button" class="js-nopass btnorder"  value="不通过" />
	             </c:if>
	            <c:if test="${user.status == 1}"><!-- 正常 -->
	                <input type="button" class="js_forbidden btnorder" onclick="changeStatus(4)" value="冻结" />
	                <input type="button" class="js_forbidden btnorder" onclick="changeStatus(3)" value="删除" />
	              </c:if>
	            <c:if test="${user.status == 2}"><!-- 审核未通过 -->
	                <input type="button" class="js_pass btnorder" onclick="changeStatus(1)" value="通过" />
	                <input type="button" class="js_freeze btnorder" onclick="changeStatus(3)"value="删除" />
	              </c:if>
	            <c:if test="${user.status == 3}"><!-- 已删除 -->
	                <input type="button" class="js_pass btnorder" onclick="changeStatus(1)" value="启用" />
	              </c:if>
	            <c:if test="${user.status == 4}"><!-- 冻结 -->
	                <input type="button" class="js_pass btnorder" onclick="changeStatus(1)" value="启用" />
	                <input type="button" class="js_forbidden btnorder" onclick="changeStatus(3)" value="删除" />
	              </c:if>
	            </div>
	        </div>
	        <!--理由弹框页面开始-->
	        	<div class="reasondiv">
	            	<div>
	                	 <span class="spandetail left">理由：</span><textarea class="js_reason"></textarea>
	                </div>
	                <div class="mar100">
	                	<input type="button" class="btnorder" value="确定" onclick="changeStatus(2)" />
	                	<input type="button" class="btnorder js-cancel" value="取消" />
	                </div>
	              
	                
	            </div>
	        
	         <!--理由弹框页面结束-->
		</div>
    </div>

</body>
</html>
<script type="text/javascript" src="res/views/default/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="res/views/default/js/user/adminDetails.js"></script>
	<script type="text/javascript" src="res/views/default/js/basic.js"></script>