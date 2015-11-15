<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="res/views/default/css/basic.css" rel="stylesheet" />
<link href="res/views/default/css/index.css" rel="stylesheet" />
<title>Insert title here</title>
</head>
<body>
<!-- FIXME -->
	<input type="hidden" value="123" class="js_userId"/>
	<input type="hidden" value="${ticket.uuid }" class="js_ticketId"/>
	<div class="clear"></div>
	 <!-- 开始 -->
	<div class="wrap">
        <div class="mainDetail">
            <div><span class="spandetail">标题：</span>${ticket.question }</div>
            <div><span class="spandetail">详情：</span>${ticket.content }</div>
            <c:if test="${ticket.status == 0 }"><div><span class="spandetail">状态：</span>等待处理</div></c:if>
            <c:if test="${ticket.status == 1 }"><div><span class="spandetail">状态：</span>正在处理</div></c:if>
            <c:if test="${ticket.status == 2 }"><div><span class="spandetail">状态：</span>等待用户反馈</div></c:if>
            <c:if test="${ticket.status == 3 }"><div><span class="spandetail">状态：</span>问题关闭</div></c:if>
            <c:if test="${ticket.status == 4 }"><div><span class="spandetail">状态：</span>已删除</div></c:if>
            <c:if test="${ticket.status == 5 }"><div><span class="spandetail">状态：</span>流转中</div></c:if>
            <div><span class="spandetail">问题分类：</span>${ticket.typeName }</div>
            <div><span class="spandetail">时间：</span>${ticket.createTime }</div>
            <div>
            	<ul class="taskUl">
                	<li>
                    	<div class="taskDiv">
                            <div class="taskto">
                            <ul>
                                <c:forEach var="re" items="${reply}">
                                <li>
                                	回复时间:${re.createTime } </br>
	                             	<c:if test="${re.workerNo != null}">客服:${re.replyContent }</c:if>
	                                <c:if test="${re.workerNo == null}">我:${re.replyContent } </c:if>
	                            </li><br>
                                </c:forEach>  
                            </ul>           
                            </div>
            			</div>                    
                    </li>
                 </ul>
 		   </div>
 	 </div>
  </div>
  <!-- 结束 -->
  
  <!-- 开始 -->
			<div class="taskto">
				<div class="mart10">
					<c:if test="${ticket.status != 3 && ticket.status != 4}">
						<textarea  rows = "10" cols ="30" class="js_reply marr10" value="${replyContent }"/></textarea><br/>
	              		<input type="button" class="js_reply btnorder" onclick="addReply(${systemIndex})" value="继续提问" />
						<input type="button" class="js_closeTicket btnorder" data-systemIndex="${systemIndex}" data-uuid="${ticket.uuid }"  value="关闭工单" />
					</c:if>
					<c:if test="${ticket.status == 3 || ticket.status == 4}">
					工单已关闭
					</c:if>
				</div>
			</div>
	  <!-- 结束 -->
</div>
</body>
</html>
 <script type="text/javascript" src="res/views/default/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="res/views/default/js/sobox/jquery.sobox.js"></script>
	<script type="text/javascript" src="res/views/default/js/ticket/applyTicketMove.js"></script>