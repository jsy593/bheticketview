<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@ taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<link href="res/views/default/css/basic.css" rel="stylesheet" />
<link href="res/views/default/css/index.css" rel="stylesheet" />
<link href="res/views/default/js/jqpagination/css/jqpagination.css" rel="stylesheet" />
<body>
	<div class="wrap">
		<div class="margincenter">
	    	<div class="searchdiv">
	    	<form action="${base}/getKnowledgeBaseList?titleNo=1" method="post">
	        	<div class="left">
	        		<div class="marr30 left">
	        			状态：<select class="selestatiu js_status" name="status">
								<option value="-1">状态</option>
								<option <c:if test="${status == 1}">selected</c:if> value="1">正常</option>
	        					<option <c:if test="${status == 2}">selected</c:if> value="2">未审核</option>
	        					<option <c:if test="${status == 3}">selected</c:if> value="3">失效</option>
<%-- 	        					<option <c:if test="${status == 4}">selected</c:if> value="4">删除</option> --%>
	
						</select>
					</div>
	                <div class="left">
	                	<input  type="text"  name="content" value="${content }" class="txtsearch js_search_text"  placeholder="请输入查询条件"/><input type="submit" value="搜索" class="btnorder" />
	           		</div>
	            </div>  
	            </form> 
	        	<div class="right">
	            	<input type="button" value="新增知识库" class="js_addSystem btnorder" onclick="toAddKnowledgeBase('${userinfo.departmentId}')"/>
	            </div>
	        </div>
	                 
	        
	        <div class="clear"></div>
	    	<div class="mart10">
	        	<table width="100%" border="0"  cellspacing="0" cellpadding="0" class="bheTable">
	                	<tr>
	                    	<th width="35px" ><input  type="checkbox"/></th>
	                    	
	                        <th>排序值</th>
	                        <th>问题</th>
	                        <th>回答</th>
	                        <th>状态</th>
	                        <th>时间</th>
	                        <th>操作</th>
	                    </tr>
	                    <c:forEach var="knowledgeBase" items="${knowledgeBaseList.list}">
	                   		 <tr>
	                    	<td width="35px"><input  type="checkbox"/></td>
	                        <td>${knowledgeBase.rank }</td>
	                        <td>${knowledgeBase.question }</td>
	                        <td>${knowledgeBase.answer }</td>
	                         <c:if test="${knowledgeBase.status == 1}"><td>正常</td></c:if>
	                         <c:if test="${knowledgeBase.status == 2}"><td>待审核</td></c:if>
	                         <c:if test="${knowledgeBase.status == 3}"><td>失效</td></c:if>
	                         <c:if test="${knowledgeBase.status == 4}"><td>删除</td></c:if>
	                        <td>${knowledgeBase.createTime }</td>   
	                        <td><a href="javascript:void(0)" onclick="linkHref('${knowledgeBase.uuid}')">详情</a></td>
	                   	 </tr>
	                   </c:forEach>
	          </table>
	           <div class="pagination right">
				    <a href="#" class="first" data-action="first">&laquo;</a>
				    <a href="#" class="previous" data-action="previous">&lsaquo;</a>
				    <input type="text" readonly="readonly" data-max-page="${knowledgeBaseList.maxPage}" />
				    <a href="#" class="next" data-action="next">&rsaquo;</a>
				    <a href="#" class="last" data-action="last">&raquo;</a>
				</div>
	        </div>
		</div>
    	
    
    </div>
</body>
	<script type="text/javascript" src="res/views/default/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="res/views/default/js/knowledgeBase/knowledgeBase.js"></script>
	<script type="text/javascript" src="res/views/default/js/basic.js"></script>
	 <script type="text/javascript" src="res/views/default/js/jqpagination/js/jquery.jqpagination.min.js"></script> 
    <script type="text/javascript">
	//加载产品列表
	$('.pagination').jqPagination({
		current_page : '${pageIndex}',
		max_page : '${knowledgeBaseList.maxPage}',
	    paged: function(page) {
	    	var status = $(".js_status").val();
	    	var content = $(".js_search_text").val();
			window.location.href = "getKnowledgeBaseList?status=" + status + "&content=" + content + "&pageIndex=" + page + "&pageSize=15";
		    }
	});
</script>
