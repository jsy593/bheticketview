<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>系统管理员</title>
<link href="res/views/default/css/basic.css" rel="stylesheet" />
<link href="res/views/default/css/index.css" rel="stylesheet" />
<link href="res/views/default/js/jqpagination/css/jqpagination.css" rel="stylesheet" />
</head>
<script src="res/views/default/js/jquery-1.8.3.min.js"></script>
<script src="res/views/default/js/basic.js"></script>
<body>
	<div class="clear"></div>
	<div class="margincenter">
	
	<!-- 搜索开始 -->
		<form action="${base}/getTicketList?titleNo=0" method="post">
			<div class="searchdiv">
	        	<div class="left marr30">
	        	状态：<select class="js_status selestatiu" name="status">
<%-- 		        		<option value="-1" <c:if test="${status == -1}">selected</c:if>>状态</option> --%>
	        		<c:if test="${roleinfo.code == 'departmentAdmin' }">
		        		<option value="-2" <c:if test="${status == -2}">selected</c:if>>所有</option>
	        		</c:if>
	        		<option <c:if test="${status == 0}">selected</c:if> value="0">未处理</option>
	        		<option <c:if test="${status == 1}">selected</c:if> value="1">正在处理</option>
	        		<option <c:if test="${status == 2}">selected</c:if> value="2">等待用户反馈</option>
	        		<option <c:if test="${status == 3}">selected</c:if> value="3">问题关闭</option>
<%-- 	        		<option <c:if test="${status == 4}">selected</c:if> value="4">已删除</option> --%>
	        		
	        		</select>
	                <input  type="text" name="content" class="js_search_text txtsearch" value="${content }"  placeholder="请输入查询条件"/>
	                <input type="submit" value="搜索" class="js_search btnorder" />
	            </div>
	        </div>
	        </form>
	<!-- 搜索结束 -->
	        
	       <!-- 分配方式开始 -->
	       	<c:if test="${roleinfo.code == 'departmentAdmin' }">
		        <div class="searchdiv">
		        	分配方式：<select class="js_allotType selestatiu" name="allotType">
		        		<option <c:if test="${allotType == 0}">selected</c:if> value="0">手动分配</option>
		        		<option <c:if test="${allotType == 1}">selected</c:if> value="1">自动分配</option>
		        		
		        		</select>
		    	</div>
	    	</c:if>
	       <!-- 分配方式结束-->
	        
	        
	    	<div class="">
	        	<table width="100%" border="0"  cellspacing="0" cellpadding="0" class="bheTable">
	                	<tr>
	                    	<th width="35px" ><input  type="checkbox"/></th>
	                        <th>问题</th>
	                        <th>客户id</th>
	                        <th>状态</th>
	                        <th>时间</th>
	                        <th>紧急程度</th>
	                        <th>操作</th>
	                    </tr>
	                    <input type="hidden"  value="${list }"/>
	              <c:forEach items="${ticket.list }" var="list" >
	                    <tr>
	                    	<td width="35px"><input  type="checkbox"/></td>
	                        <td>${list.question }</td>
	                        <td>${list.outerUserId}</td>
	                        <td>
	                         <c:if test="${list.status == 0}">未处理</c:if>
	                         <c:if test="${list.status == 1}">正在处理</c:if>
	                         <c:if test="${list.status == 2}">等待用户反馈</c:if>
	                         <c:if test="${list.status == 3}">问题关闭</c:if>
	                         <c:if test="${list.status == 4}">已删除</c:if>
	                         </td>
	                        <td>${list.createTime}</td>
	                        <td>
	                         <c:if test="${list.level == 1}">一般</c:if>
	                         <c:if test="${list.level == 2}">紧急</c:if>
	                         <c:if test="${list.level == 3}">非常紧急</c:if>           
	                        </td>         
	                        <td><a href="getTicketDetails?uuid=${list.uuid }&titleNo=0">详情</a></td>
	                    </tr>
	              </c:forEach>
	                    
	          </table>
	         </div>
	          <div class="pagination right">
				    <a href="#" class="first" data-action="first">&laquo;</a>
				    <a href="#" class="previous" data-action="previous">&lsaquo;</a>
				    <input type="text" readonly="readonly" data-max-page="${ticket.maxPage}" />
				    <a href="#" class="next" data-action="next">&rsaquo;</a>
				    <a href="#" class="last" data-action="last">&raquo;</a>
				</div> 
	</div>
	 <script type="text/javascript" src="res/views/default/js/jqpagination/js/jquery.jqpagination.min.js"></script> 
	 <script type="text/javascript" src="res/views/default/js/ticket/ticketList.js"></script> 
    <script type="text/javascript">
	//加载产品列表
	$('.pagination').jqPagination({
		current_page : '${pageIndex}',
		max_page : '${ticket.maxPage}',
	    paged: function(page) {
	    	var status = $(".js_status").val();
	    	var content = $(".js_search_text").val();
			window.location.href = "getTicketList?titleNo=0&status=" + status + "&content=" + content + "&pageIndex=" + page + "&pageSize=15";
		    }
	});
</script>
	</body>
</html>
