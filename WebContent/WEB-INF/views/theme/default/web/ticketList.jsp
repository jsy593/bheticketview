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
<%-- 	<form action="${base}/getTicketList" method="post"> --%>
<!-- 		<div class="searchdiv"> -->
<!--         	<div class="left marr30"> -->
<!--         	状态：<select class="js_status selestatiu" name="status"> -->
<!--         		<option value="-1">状态</option> -->
<%--         		<option <c:if test="${status == 0}">selected</c:if> value="0">未处理</option> --%>
<%--         		<option <c:if test="${status == 1}">selected</c:if> value="1">正在处理</option> --%>
<%--         		<option <c:if test="${status == 2}">selected</c:if> value="2">等待用户反馈</option> --%>
<%--         		<option <c:if test="${status == 3}">selected</c:if> value="3">问题关闭</option> --%>
<%--         		<option <c:if test="${status == 4}">selected</c:if> value="4">已删除</option> --%>
        		
<!--         		</select> -->
<!--             </div> -->
            
<!--             <div class=""> -->
<%--                 <input  type="text" name="content" class="js_search_text txtsearch" value="${content }"  placeholder="请输入查询条件"/> --%>
<!--                 <input type="submit" value="搜索" class="js_search btnorder" /> -->
<!--             </div> -->
<!--         </div> -->
<!--         </form> -->
    	<div class="">
        	<table width="100%" border="0"  cellspacing="0" cellpadding="0" class="bheTable">
                	<tr>
                        <th>问题</th>
                        <th>状态</th>
                        <th>时间</th>
                        <th>操作</th>
                    </tr>
                    <input type="hidden"  value="${list }"/>
              <c:forEach items="${data.list }" var="list" >
                    <tr>
                        <td>${list.content }</td>
                         <c:if test="${list.status == 0}"><td>未处理</td></c:if>
                         <c:if test="${list.status == 1}"><td>正在处理</td></c:if>
                         <c:if test="${list.status == 2}"><td>等待用户反馈</td></c:if>
                         <c:if test="${list.status == 3}"><td>问题关闭</td></c:if>
                         <c:if test="${list.status == 4}"><td>已删除</td></c:if>
                        <td>${list.createTime}</td>
                        <td><a href="getUserTicketDetails?uuid=${list.uuid }&systemIndex=${data.systemIndex}">详情</a></td>
                    </tr>
              </c:forEach>
                    
          </table>
          
            <div class="pagination right">
					    <a href="#" class="first" data-action="first">&laquo;</a>
					    <a href="#" class="previous" data-action="previous">&lsaquo;</a>
					    <input type="text" readonly="readonly" data-max-page="${data.maxPage }" />
					    <a href="#" class="next" data-action="next">&rsaquo;</a>
					    <a href="#" class="last" data-action="last">&raquo;</a>
					</div> 
		        </div>
          <script type="text/javascript" src="res/views/default/js/jqpagination/js/jquery.jqpagination.min.js"></script> 
		  <script>
		  $('.pagination').jqPagination({
			current_page : '${pageIndex}',
			max_page : '${data.maxPage }',
		    paged: function(page) {
		    	var status = $(".js_status").val();
		    	var content = $(".js_search_text").val();
				window.location.href = "getQuickReplyList?titleNo=2&status=" + status + "&content=" + content + "&pageIndex=" + page + "&pageSize=15";
			    }
		  });
		</script>
	</body>
</html>
