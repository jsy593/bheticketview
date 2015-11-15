<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="res/views/default/js/treetable/vsStyle/jquery.treeTable.css">
<link rel="stylesheet" type="text/css" href="res/views/default/js/sobox/popbox-style.css">
<link href="res/views/default/js/jqpagination/css/jqpagination.css" rel="stylesheet" />
<body>
<input type="hidden" class="systemIndex" value="${systemIndex }"/>
<input type="hidden" class="systemAdminId" value="${userinfo.uuid }"/>
<div class="clear"></div>
	<div class="wrap">
		<div class="margincenter">
	    	<div class="systemList">
	    	
	    	
	    	
	    	
	    	</div>
	    	<div class="right"  style="width:79%; min-height:800px;">
	    		<div class="right"><button class="addDept btnorder">添加部门</button></div>
	    		<div class="clear"></div>
	    		<div class="mart5">	    		
		        	<table width="100%" border="0"  class="art_table bheTable" id="treeTable" cellspacing="0" cellpadding="0">
		                	<tr >
		                        <th>部门名称</th>
		                        <th>部门管理员</th>
		                        <th>时间</th>
		                        <th>状态</th>
		                        <th>操作</th> 
		                    </tr>
		             <c:forEach items="${data.list }" var="list">
		                     <tr hasChild="true" id="${list.uuid }">
		                        <td style="text-align: left;">${list.name }</td>
		                        <td>${list.adminUser }</td>
		                        <td>${list.createTime }</td>
		                        <td>
		                        	<c:if test="${list.status == '1' }"><font color="green">启用</font></c:if>
		                        	<c:if test="${list.status == '0' }"><font color="red">停用</font></c:if>
		                        </td>
		                        <td>
		                        	<a href="getDepartmentDetail?uuid=${list.uuid }&titleNo=1&systemIndex=${systemIndex }">详情</a>
		                        	<a href="#" class="addQuestionType" data-uuid="${list.uuid }">添加分类</a>
		                        	<c:if test="${list.status == '1' }"><font color="red"><a href="#" class="stop" data-uuid="${list.uuid }">关闭部门</a></font></c:if>
		                        	<c:if test="${list.status == '0' }"><font color="green"><a href="#" class="start" data-uuid="${list.uuid }">开启部门</a></font></c:if>
		                        	
		                        </td>
		                    </tr>
		              </c:forEach>              
		                
		          </table>
		           <div class="pagination right">
					    <a href="#" class="first" data-action="first">&laquo;</a>
					    <a href="#" class="previous" data-action="previous">&lsaquo;</a>
					    <input type="text" readonly="readonly" data-max-page="${data.maxPage}" />
					    <a href="#" class="next" data-action="next">&rsaquo;</a>
					    <a href="#" class="last" data-action="last">&raquo;</a>
					</div>
	    		</div>
			<div class="so-dept-popbox so-popbox" style="display: none">
				<div class="h2-sopop">
					<span class="s-sopop-title"></span> <span
						class="s-close s-sopop-close">[关闭]</span>
				</div>
				<div >
					<p class="so-popbox-cont"></p>
					<p class="p-so-popBtn js-findcustomer-img">
						<input type="button" class="s-close" value="确定" />
					</p>
				</div>
			</div>
			<div class="so-addDept-popbox so-popbox" style="display: none">
				<div class="h2-sopop">
					<span class="s-sopop-title"></span> <span
						class="s-close s-sopop-close">[关闭]</span>
				</div>
				<div  class="so-popbox-cont">
					<form action="addDept" method="post">
						<input type="hidden" class="systemIndex" value="${systemIndex }" name="systemIndex"/>
						<p>
							<span class="spandetail">部门名称：</span>
							<input type="text" class="txtvalue js-deptName" name="deptName"/>
						</p>
						<p>
							<span class="spandetail">管理员姓名：</span>
							<input type="text" class="txtvalue js-adminName" name="adminName"/>
						</p>
						<p>
							<span class="spandetail">登录名：</span>
							<input type="text" class="txtvalue js-code" name="code"/>
						</p>
						<p>
							<span class="spandetail">密码：</span>
							<input type="text" class="txtvalue js-password" name="password"/>
						</p>
						<p class="p-so-popBtn js-findcustomer-img">
							<input type="submit" class="addThis btnorder" value="确定" />
						</p>
					</form>
				</div>
			</div>
	    </div>
		</div>
   </div>
    <script type="text/javascript" src="res/views/default/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="res/views/default/js/date.js"></script>
    <script type="text/javascript" src="res/views/default/js/sobox/jquery.sobox.js"></script>
    <script type="text/javascript" src="res/views/default/js/treetable/jquery.treeTable.js"></script>
    <script type="text/javascript" src="res/views/default/js/department/departmentManager.js"></script>
    <script type="text/javascript" src="res/views/default/js/jqpagination/js/jquery.jqpagination.min.js"></script> 
    <script type="text/javascript">
	//加载产品列表
	$('.pagination').jqPagination({
		current_page : '${pageIndex}',
		max_page : '${data.maxPage}',
	    paged: function(page) {
	    	var status = $(".js_status").val();
	    	var content = $(".js_search_text").val();
			window.location.href = "toDepartmentManager?systemIndex=${systemIndex}&pageIndex=" + page + "&pageSize=15";
		    }
	});
</script>
</body>