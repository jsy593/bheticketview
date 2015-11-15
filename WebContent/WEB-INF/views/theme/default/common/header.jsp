<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript" src="res/views/default/js/jquery-1.8.3.min.js"></script>
<body>
	<div class="wrap">
    	<div class="header">
    		<div class="margincenter">     		
	        	<div class="headertop">
	            	<div class="headertopleft left">通用工单系统：${userinfo.realName }</div>
	                <div class="headertopright right"><a href="logout" class="exita">退出登录</a> </div>&nbsp;&nbsp;&nbsp;
	            	<div class="headertopright right"><a href="toPersonalCenter" class="js_personalCenter header">个人中心&nbsp;&nbsp;&nbsp;</a></div>
	            	<div class="headertopright right"><a href="toHome" class="header">返回首页&nbsp;&nbsp;&nbsp;</a></div>
	            </div>
    		</div>
        </div>

        <div class="margincenter">
	        <div class="main">
	        	<c:if test="${roleinfo.code == 'superAdmin'}">
		        	<div class="systemdiv">            	
		               <ul class="systemUl">
		               		<li><a href="getAdminList?titleNo=0">系统管理员</a></li>
		               		<li><a href="getSystemList?titleNo=1">系统管理</a></li>
		               </ul>
		            </div>
	        	</c:if>
	        	<c:if test="${roleinfo.code == 'systemAdmin'}">		            
		            <div class="systemdiv">            	
		               <ul class="systemUl">
		               		<li><a href="getSystemManagerList?userId=${userinfo.uuid }&titleNo=0" >系统管理</a></li>
		               		<li><a href="toDepartmentManager?titleNo=1" >部门维护</a></li>
		               		<li><a href="getBigQuestionTypeList?titleNo=2">分类管理</a></li>
		               </ul>
		            </div>
		            
	            </c:if>
	            <c:if test="${roleinfo.code == 'departmentAdmin'}">
		             <div class="systemdiv">            	
		               <ul class="systemUl">
		               		<li><a href="getTicketList?titleNo=0" >工单分配</a></li>
		               		<li><a href="getKnowledgeBaseList?titleNo=1" >知识库审核</a></li>
		               		<li><a href="getSmallQuestionTypeList?titleNo=2" >分类管理</a></li>
		               		<li><a href="getTicketMoveList?audtId=${userinfo.uuid }&titleNo=3">流转审核</a></li>
		               		<li><a href="getPeopleManageList?departmentId=${userinfo.departmentId }&titleNo=4" >人员管理</a></li>
		               </ul>
		            </div>
		            
	            </c:if>
	            <c:if test="${roleinfo.code == 'staff'}">
		            <div class="systemdiv">            	
		               <ul class="systemUl">
		               		<li><a href="getTicketList?titleNo=0">当前任务</a></li>
		               		<li><a href="getKnowledgeBaseList?titleNo=1" >知识库管理</a></li>
		               		<li><a href="getQuickReplyList?titleNo=2" >快捷回复管理</a></li>
		               </ul>
		            </div>
		            
	            </c:if>
	        </div>

        </div>
    </div>
    <script type="text/javascript">
    	$(document).ready(function(){
//     		$(".systemUl li:first-child").toggleClass("spesystemli");
//     		$(".systemUl li a").click(function(){
//     			$(this).siblings().removeClass("spesystemli");
//     			$(".systemUl").find("li").addClass("spesystemli"); 
//     		});
    		$(".systemUl li:eq(${titleNo})").addClass("spesystemli");
    	});
    
    </script>
</body>