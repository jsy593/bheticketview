<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@ taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<link href="res/views/default/css/basic.css" rel="stylesheet" />
<link href="res/views/default/css/index.css" rel="stylesheet" />
<link href="res/views/default/js/jqpagination/css/jqpagination.css" rel="stylesheet" />
<body>
<div class="clear"></div>
	<div class="wrap">
	<div class="margincenter">
		<form action="${base}/getSystemList?titleNo=1" method="post">
	    	<div class="searchdiv">
	        	<div class="left">
	        		<div class="marr30 left">
	        			状态：<select class="selestatiu" name="status">
								<option value="-1">状态</option>
								<option <c:if test="${status == 0}">selected</c:if> value="0">未审核</option>
	        					<option <c:if test="${status == 1}">selected</c:if> value="1">正常</option>
	        					<option <c:if test="${status == 2}">selected</c:if> value="2">冻结</option>
	        					<option <c:if test="${status == 3}">selected</c:if> value="3">审核未通过</option>
	
						</select>
					</div>
	                <div class="left">
	                	<input  type="text" value="${content }"  name="content" class="txtsearch"  placeholder="请输入系统名称"/><input type="submit" value="搜索" class="btnorder" />
	           		</div>
	            </div>            
	        </div>
	       </form>
	        <div class="clear"></div>
	    	<div class="mart10">
	        	<table width="100%" border="0"  cellspacing="0" cellpadding="0" class="bheTable">
	                	<tr>
	                    	<th width="35px" ><input  type="checkbox"/></th>
	                        <th>系统名称</th>
	                        <th>管理员账号</th>
	                        <th>appId</th>
	                        <th>key</th>
	                        <th>状态</th>
	                        <th>时间</th>
	                        <th>操作</th>
	                    </tr>
	                    <c:forEach var="system" items="${systemList.list}">
	                   		 <tr>
	                    	<td width="35px"><input  type="checkbox"/></td>
	                        <td>${system.systemName }</td>
	                        <td>${system.username }</td>
	                        <td>${system.appId }</td>
	                        <td>${system.appKey }</td>
	                         <c:if test="${system.status == 0}"><td>待审核</td></c:if>
	                         <c:if test="${system.status == 1}"><td>正常</td></c:if>
	                         <c:if test="${system.status == 2}"><td>冻结</td></c:if>
	                         <c:if test="${system.status == 3}"><td>未通过</td></c:if>
	                        <td>${system.createTime }</td>   
	                        <td><a href="javascript:void(0)" onclick="linkHref('${system.uuid}')">详情</a></td>
	                   	 </tr>
	                   </c:forEach>
	          </table>
	          	<div class="pagination right">
				    <a href="#" class="first" data-action="first">&laquo;</a>
				    <a href="#" class="previous" data-action="previous">&lsaquo;</a>
				    <input type="text" readonly="readonly" data-max-page="${systemList.maxPage}" />
				    <a href="#" class="next" data-action="next">&rsaquo;</a>
				    <a href="#" class="last" data-action="last">&raquo;</a>
				</div>
	        </div>
	</div>
    	
    
    </div>
</body>
	<script type="text/javascript" src="res/views/default/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="res/views/default/js/system/system.js"></script>
	<script type="text/javascript" src="res/views/default/js/basic.js"></script>
	<script type="text/javascript" src="res/views/default/js/jqpagination/js/jquery.jqpagination.min.js"></script> 
	<script type="text/javascript">
	//加载产品列表
	$('.pagination').jqPagination({
		current_page : '${pageIndex}',
		max_page : '${systemList.maxPage}',
	    paged: function(page) {
	    	var status = $('.selestatiu').val();
	    	var content = $('.txtsearch').val();
	    	alert(content)
			window.location.href = "getSystemList?status=" + status + "&content=" + content + "&pageIndex="+ page + "&pageSize=15";
		    }
	});
	
</script>