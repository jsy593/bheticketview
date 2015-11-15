<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="res/views/default/js/sobox/popbox-style.css">
<link href="res/views/default/css/basic.css" rel="stylesheet" />
<link href="res/views/default/css/index.css" rel="stylesheet" />
<body>
	<input type="hidden" value="${userinfo.departmentId }" class="departmentId"/>
	<input type="hidden" value="${userinfo.uuid }" class="userId"/>
	<div class="clear"></div>
	<div class="wrap">
		<div class="margincenter">
	    	<div class="mainDetail">
	    		<input type="hidden" class = "uuid" value="${data.uuid }"/>
	            <div><span class="spandetail">发起人：</span>${data.fromUser }</div>
	            <div><span class="spandetail">接收人：</span>${data.toUser }</div>
	            <div><span class="spandetail">问题：</span>${data.question }</div>
	            <div><span class="spandetail">详情：</span>${data.reason }</div>
	            <div><span class="spandetail">时间：</span>${data.createTime }</div>
	            <div><span class="spandetail">紧急程度：</span>${data.level }</div>
	            <div><span class="spandetail">紧急理由：</span>${data.tickeReason }</div>
	            <c:if test="${data.status == '2' }">
	         	   <div><span class="spandetail">驳回理由：</span>${data.refuseReason }</div> 
	            </c:if>
	            <div class="btndiv">
	            	<c:if test="${data.status == '0' }">
		                <input type="button" class="btnorder pass" value="通过" />
		                <input type="button" class="btnorder reject" value="驳回" />
		                <input type="button" class="btnorder distribution" value="分配" />
	                </c:if>
	                <c:if test="${data.status == '1' }">
						<span class="spandetail"><font color="green">已通过</font></span>
	                </c:if>
	                <c:if test="${data.status == '2' }">
						<span class="spandetail"><font color="red">已驳回</font></span>
	                </c:if>
	                <c:if test="${data.status == '3' }">
						<span class="spandetail"><font color="orange">已重新分配</font></span>
	                </c:if>
	            </div>
	        </div>
	    </div>
	    <div class="so-reject-popbox so-popbox" style="display: none">
			<div class="h2-sopop">
				<span class="s-sopop-title"></span> <span
					class="s-close s-sopop-close">[关闭]</span>
			</div>
			<div  class="so-popbox-cont">
				<form action="rejectTicketMove" method="post">
					<input type="hidden"  value="${data.uuid }" name="uuid"/>
					<p>
						<span class="spandetail">驳回理由：</span>
						<textarea rows="" cols="" name="refuseReason" required></textarea>
					</p>
					<p class="p-so-popBtn js-findcustomer-img">
						<input type="submit" value="确定" />
					</p>
				</form>
			</div>
		</div>
	    <div class="so-distribution-popbox so-popbox" style="display: none">
			<div class="h2-sopop">
				<span class="s-sopop-title"></span> <span
					class="s-close s-sopop-close">[关闭]</span>
			</div>
			<div  class="so-popbox-cont">
				<form action="distributionTicketMove" method="post">
					<input type="hidden"  value="${data.uuid }" name="uuid"/>
					<input type="hidden"  value="${data.ticketId }" name="ticketId"/>
					<p>
						<span class="spandetail">处理人员：</span>
						<select required class="selectUser" name="ownerId">
							<option value="">请选择</option>
						</select>
					</p>
					<p class="p-so-popBtn js-findcustomer-img">
						<input type="submit" value="确定" />
					</p>
				</form>
			</div>
		</div>
	</div>
    <script type="text/javascript" src="res/views/default/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="res/views/default/js/sobox/jquery.sobox.js"></script>
	<script type="text/javascript" src="res/views/default/js/ticket/ticketMoveDetails.js"></script>
</body>