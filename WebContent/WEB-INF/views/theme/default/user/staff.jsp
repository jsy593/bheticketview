<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<link href="res/views/default/css/basic.css" rel="stylesheet" />
<link href="res/views/default/css/index.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="res/views/default/js/sobox/popbox-style.css">
<link href="res/views/default/js/jqpagination/css/jqpagination.css" rel="stylesheet" />
<div class="clear"></div>
<body>
	<div class="wrap">
		<div class="margincenter">
			<form action="${base}/getPeopleManageList?titleNo=4" method="post">
			<div>
		    	<div class="searchdiv left">
		    		<input type="hidden" value="${userinfo.departmentId }" name="departmentId">
		        	<div class="marr30 left">
		        	状态：<select class="js_status selestatiu" name="status">
			        		<option value="-1">状态</option>
			        		<option <c:if test="${status == 0}">selected</c:if> value="0">未审核</option>
			        		<option <c:if test="${status == 1}">selected</c:if> value="1">正常</option>
			        		<option <c:if test="${status == 2}">selected</c:if> value="2">审核未通过</option>
<%-- 			        		<option <c:if test="${status == 3}">selected</c:if> value="3">删除</option> --%>
			        		<option <c:if test="${status == 4}">selected</c:if> value="4">冻结</option>
		        		</select>
		            </div>
		            
		            <div class="left">
		                <input  type="text" name="content" class="js_search_text txtsearch" value="${content }"  placeholder="请输入查询条件"/>
		                <input type="submit" value="搜索" class="js_search btnorder" />
		            </div>
		        </div>
		            <div class="right">
				        <input type="button" class="addUser btnorder" value="添加职员"/>
		            </div>
			</div>

	        </form>
	    	<div class="clear"></div>
	        <div>
	        	<table width="100%" border="0"  cellspacing="0" cellpadding="0" class="bheTable">
	                	<tr>
	                    	<th width="35px" ><input  type="checkbox"/></th>
	                        <th>姓名</th>
	                        <th>账号</th>
	                        <th>性别</th>
	                        <th>手机号</th>
	                        <th>时间</th>
	                        <th>状态</th>
	                        <th>操作</th>
	                    </tr>
	                    	
	       		<c:forEach var="user" items="${userList.list}"> 
	                    <tr>
	                    	<td width="35px"><input  type="checkbox"/></td>
	                        <td>${user.realName}</td>
	                        <td>${user.username}</td>
	                        <td>${user.sex}</td>
	                        <td>${user.phone}</td>
	                        <td>${user.createTime}</td>
	                        <td>
	                        	<c:if test="${user.status == '0'}">待审核</c:if>
	                        	<c:if test="${user.status == '1'}">正常</c:if>
	                        	<c:if test="${user.status == '2'}">审核未通过</c:if>
	                        	<c:if test="${user.status == '3'}">删除</c:if>
	                        	<c:if test="${user.status == '4'}">冻结</c:if>
	                        </td>
	                        <td><a href="getStaffDetails?uuid=${user.uuid}&titleNo=4" >详情</a></td>
	                    </tr>
	       		
	       		</c:forEach>
	                            
	                
	          </table>
	         <div class="pagination right">
				    <a href="#" class="first" data-action="first">&laquo;</a>
				    <a href="#" class="previous" data-action="previous">&lsaquo;</a>
				    <input type="text" readonly="readonly" data-max-page="${userList.maxPage}" />
				    <a href="#" class="next" data-action="next">&rsaquo;</a>
				    <a href="#" class="last" data-action="last">&raquo;</a>
				</div>
	        
	        </div>
	    	<div class="so-addUser-popbox so-popbox" style="display: none">
				<div class="h2-sopop">
					<span class="s-sopop-title"></span> <span
						class="s-close s-sopop-close">[关闭]</span>
				</div>
				<div  class="so-popbox-cont">
					<form action="addUser" method="post">
						<input type="hidden"  value="${userinfo.systemIndex }" name="systemIndex"/>
						<input type="hidden"  value="${userinfo.departmentId }" name="departmentId"/>
						
						<p>
							<span class="spandetail">姓名：</span>
							<input type="text" class="txtvalue" name="realName"/>
						</p>
						<p>
							<span class="spandetail">账号：</span>
							<input type="text" class="txtvalu" name="username"/>
						</p>
						<p>
							<span class="spandetail">密码：</span>
							<input type="text" class="txtvalue" name="password"/>
						</p>
						<p class="p-so-popBtn js-findcustomer-img">
							<input type="submit" class="addThis" value="确定" />
						</p>
					</form>
				</div>

			</div>
		</div>
    
    </div>
</body>
	<script type="text/javascript" src="res/views/default/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="res/views/default/js/sobox/jquery.sobox.js"></script>
	<script type="text/javascript" src="res/views/default/js/user/staff.js"></script>
	<script type="text/javascript" src="res/views/default/js/basic.js"></script>
	<script type="text/javascript" src="res/views/default/js/jqpagination/js/jquery.jqpagination.min.js"></script> 
    <script type="text/javascript">
	//加载产品列表
	$('.pagination').jqPagination({
		current_page : '${pageIndex}',
		max_page : '${userList.maxPage}',
	    paged: function(page) {
	    	var status = $(".js_status").val();
	    	var content = $(".js_search_text").val();
			window.location.href = "toPeopleManage?departmentId=${userinfo.departmentId}&status="+status+"&content="+content+"&pageIndex=" + page + "&pageSize=15";
		    }
	});
</script>
