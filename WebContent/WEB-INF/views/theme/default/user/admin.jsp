<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<link href="res/views/default/css/basic.css" rel="stylesheet" />
<link href="res/views/default/css/index.css" rel="stylesheet" />
<link href="res/views/default/js/jqpagination/css/jqpagination.css" rel="stylesheet" />
<div class="clear"></div>
<body>
	<div class="wrap">
		<div class="margincenter">
			<form action="${base}/getAdminList?titleNo=0" method="post">
	    	<div class="searchdiv">
	        	<div class="left marr30">
	        	状态：<select class="js_status selestatiu" name="status">
	        		<option value="-1">状态</option>
	        		<option <c:if test="${status == 0}">selected</c:if> value="0">未审核</option>
	        		<option <c:if test="${status == 1}">selected</c:if> value="1">正常</option>
	        		<option <c:if test="${status == 2}">selected</c:if> value="2">审核未通过</option>
<%-- 	        		<option <c:if test="${status == 3}">selected</c:if> value="3">删除</option> --%>
	        		<option <c:if test="${status == 4}">selected</c:if> value="4">冻结</option>
	        		
	        		</select>
	            </div>
	            
	            <div class="">
	                <input  type="text" name="content" class="js_search_text txtsearch" value="${content }"  placeholder="请输入用户名"/>
	                <input type="submit" value="搜索" class="js_search btnorder" />
	            </div>
	        </div>
	        </form>
	    	<div class="clear"></div>
	        <div>
	        	<table class="bheTable"  cellspadding="0" cellspacing="0">
	                	<tr>
	                    	<th width="35px" ><input  type="checkbox"/></th>
	                        <th>用户名</th>
	                        <th>性别</th>
	                        <th>手机号</th>
	                        <th>时间</th>
	                        <th>备注</th>
	                        <th>操作</th>
	                    </tr>
	                    	
	       		<c:forEach var="admin" items="${adminList.list}">
	                    <tr>
	                    	<td width="35px"><input  type="checkbox"/></td>
	                        <td>${admin.username}</td>
	                        <td>${admin.sex}</td>
	                        <td>${admin.phone}</td>
	                        <td>${admin.createTime}</td>
	                        <td>${admin.remark}</td>
	                        <td><a href="javascript:void(0)" onclick="linkHref('${admin.uuid}')">详情</a></td>
	                    </tr>
	       		
	       		</c:forEach>
	                            
	                
	          </table>
	        </div>
	          	<div class="pagination right">
				    <a href="#" class="first" data-action="first">&laquo;</a>
				    <a href="#" class="previous" data-action="previous">&lsaquo;</a>
				    <input type="text" readonly="readonly" data-max-page="${adminList.maxPage}" />
				    <a href="#" class="next" data-action="next">&rsaquo;</a>
				    <a href="#" class="last" data-action="last">&raquo;</a>
				</div>
	        
		</div>
    	
    
    </div>
</body>
	<script type="text/javascript" src="res/views/default/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="res/views/default/js/user/admin.js"></script>
	<script type="text/javascript" src="res/views/default/js/basic.js"></script>
	<script type="text/javascript" src="res/views/default/js/jqpagination/js/jquery.jqpagination.min.js"></script> 
	<script type="text/javascript">
	//加载产品列表
	$('.pagination').jqPagination({
		current_page : '${pageIndex}',
		max_page : '${adminList.maxPage}',
	    paged: function(page) {
	    	var status = $(".js_status").val();
	    	var content = $(".js_search_text").val();
			window.location.href = "getAdminList?status=" + status + "&content=" + content + "&pageIndex=" + page + "&pageSize=15";
		    }
	});
</script>