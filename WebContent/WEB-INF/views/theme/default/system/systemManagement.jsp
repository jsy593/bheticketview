<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="res/views/default/js/sobox/popbox-style.css">
<link href="res/views/default/js/jqpagination/css/jqpagination.css" rel="stylesheet" />
<body>
 <div class="clear"></div>
	<div class="wrap">
		<div class="margincenter">
	    	<div class="searchdiv">
	        	<div class="right">
	            	<input type="button" value="新增系统" class="btnorder addSystem" />
	            </div>
	        </div>
	        <div class="clear"></div>
	    	<div class="mart10">
	        	<table width="100%" border="0"  cellspacing="0" cellpadding="0" class="bheTable">
	                	<tr>
	<!--                     	<th width="35px" ><input  type="checkbox"/></th> -->
	                        <th>系统名称</th>
	                        <th>appId</th>
	                        <th>key</th>
	                        <th>状态</th>
	                        <th>时间</th>
	                        <th>操作</th>
	                    </tr>
	                    <c:forEach var="list" items="${data.list}">
	                   		 <tr>
	<!--                     	<td width="35px"><input  type="checkbox"/></td> -->
	                        <td>${list.systemName }</td>
	                        <td>${list.appId }</td>
	                        <td>${list.appKey }</td>
	                        <td>
	                        	<c:if test="${list.status == '0'}"><font color="blue">审核中</font></c:if>
	                        	<c:if test="${list.status == '1'}"><font color="green">正常</font></c:if>
	                        	<c:if test="${list.status == '2'}"><font color="orange">冻结</font></c:if>
	                        	<c:if test="${list.status == '3'}"><font color="red">未通过</font></c:if>
	                        </td>
	                        <td>${list.createTime }</td>                        
	                        <td>
	                        	<c:if test="${list.status == '1'}">
	                        		<font color="orange"><a href="javascript:void(0)" class="stop" data-uuid="${list.uuid }">冻结</a></font>
	                        	</c:if>
	                        	<c:if test="${list.status == '2'}">
	                        		<font color="green"><a href="javascript:void(0)" class="start" data-uuid="${list.uuid }">正常</a></font>
	                        	</c:if>
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
	    </div>
	    <div class="so-popbox" style="display: none">
				<div class="h2-sopop">
					<span class="s-sopop-title"></span> <span
						class="s-close s-sopop-close">[关闭]</span>
				</div>
				
			    <form action="addSystem" method="post" >
				
					<input type="hidden" value="${userinfo.uuid }" name = "userId"/>
					<div  class="so-popbox-cont">
						<p>
							<span class="spandetail">系统名称：</span>
							<input type="text" class="txtvalue js-sysName" name="systemName"/>
						</p>
					</div>					
						<p class="p-so-popBtn js-findcustomer-img">
							<input type="submit"value="确定" />
						</p>
					</div>
				</form>
		</div>
			

    <script src="res/views/default/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="res/views/default/js/sobox/jquery.sobox.js"></script>
    <script src="res/views/default/js/system/systemManagement.js"></script>
    <script type="text/javascript" src="res/views/default/js/jqpagination/js/jquery.jqpagination.min.js"></script> 
    <script type="text/javascript">
	//加载产品列表
	$('.pagination').jqPagination({
		current_page : '${pageIndex}',
		max_page : '${data.maxPage}',
	    paged: function(page) {
	    	var status = $(".js_status").val();
	    	var content = $(".js_search_text").val();
			window.location.href = "getSystemManagerList?userId=${userinfo.uuid}&pageIndex=" + page + "&pageSize=15";
		    }
	});
</script>
</body>