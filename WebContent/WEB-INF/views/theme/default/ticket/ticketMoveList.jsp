<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link href="res/views/default/css/basic.css" rel="stylesheet" />
<link href="res/views/default/css/index.css" rel="stylesheet" />
<link href="res/views/default/js/jqpagination/css/jqpagination.css" rel="stylesheet" />
<script src="res/views/default/js/jquery-1.8.3.min.js"></script>
<script src="res/views/default/js/basic.js"></script>
	
	<div class="wrap" style="margin-top:50px;">
    	<div class="margincenter">
        	<table width="100%" border="0"  cellspacing="0" cellpadding="0" class="bheTable">
                	<tr>
                        <th>发起人</th>
                        <th>接收人</th>
                        <th>理由</th>
                        <th>类型（小）</th>
                        <th>时间</th>
                        <th>状态</th>
                        <th>操作</th>
                    </tr>
                    <input type="hidden"  value="${list }"/>
              <c:forEach items="${data.list }" var="list" >
                    <tr>
                        <td>${list.fromUser }</td>
                        <td>${list.toUser}</td>                     
                        <td>${list.reason}</td>
                        <td>${list.questionName }</td>   
                        <td>${list.createTime}</td>
                        <td>
                        	<c:if test="${list.status == '0' }">
								<span class="spandetail"><font color="black">未处理</font></span>
			                </c:if>
                        	<c:if test="${list.status == '1' }">
								<span class="spandetail"><font color="green">已通过</font></span>
			                </c:if>
			                <c:if test="${list.status == '2' }">
								<span class="spandetail"><font color="red">已驳回</font></span>
			                </c:if>
			                <c:if test="${list.status == '3' }">
								<span class="spandetail"><font color="orange">已重新分配</font></span>
			                </c:if> 
                        </td>
                        <td><a href="getTicketMoveOne?uuid=${list.uuid }&titleNo=3">详情</a></td>
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
<script type="text/javascript" src="res/views/default/js/jqpagination/js/jquery.jqpagination.min.js"></script> 
    <script type="text/javascript">
	//加载产品列表
	$('.pagination').jqPagination({
		current_page : '${pageIndex}',
		max_page : '${data.maxPage}',
	    paged: function(page) {
	    	var status = $(".js_status").val();
	    	var content = $(".js_search_text").val();
			window.location.href = "getTicketMoveList?audtId=${userinfo.uuid}&pageIndex=" + page + "&pageSize=15";
		    }
	});
</script>
