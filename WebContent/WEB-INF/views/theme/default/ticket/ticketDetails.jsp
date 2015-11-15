<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="res/views/default/css/basic.css" rel="stylesheet" />
<link href="res/views/default/css/index.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="res/views/default/js/sobox/popbox-style.css">
<title>Insert title here</title>
</head>
<body>
	<div class="margincenter">
	
		<input type="hidden" value="${userinfo.uuid }" class="js_userId"/>
		<input type="hidden" value="${ticket.uuid }" class="js_ticketId"/>
		<input type="hidden" value="${userinfo.systemIndex }" class="js_systemIndex"/>
		<div class="clear"></div>
		<c:if test="${roleinfo.code == 'departmentAdmin' }">
			<input type="button" class="btnorder ticketDistribution" value="工单分配" />
			<input type="button" class="btnorder ticketToOther" value="流转到其他部门管理者" />
		</c:if>
	</div>
	 <!-- 开始 -->
	<div class="wrap">
		<div class="margincenter">
	        <div class="mainDetail">
	            <div><span class="spandetail">标题：</span>${ticket.question }</div>
	            <div><span class="spandetail">详情：</span>${ticket.content }</div>
	            <c:if test="${ticket.status == 0 }"><div><span class="spandetail">状态：</span>等待处理</div></c:if>
	            <c:if test="${ticket.status == 1 }"><div><span class="spandetail">状态：</span>正在处理</div></c:if>
	            <c:if test="${ticket.status == 2 }"><div><span class="spandetail">状态：</span>等待用户反馈</div></c:if>
	            <c:if test="${ticket.status == 3 }"><div><span class="spandetail">状态：</span>问题关闭</div></c:if>
	            <c:if test="${ticket.status == 4 }"><div><span class="spandetail">状态：</span>已删除</div></c:if>
	            <c:if test="${ticket.status == 5 }"><div><span class="spandetail">状态：</span>流转中</div></c:if>
	            <div><span class="spandetail">时间：</span>${ticket.createTime }</div>
	            <div><span class="spandetail">问题分类：</span>${ticket.typeName }</div>
	            <div>
	            	<ul class="taskUl">
	                	<li>
	                    	<div class="taskDiv">
	                            <div class="taskto">
	                                <c:forEach var="re" items="${reply}">
	                                <br/>
	                                <td>回复时间:${re.createTime } </td></br>
	                              	<c:if test="${re.workerNo != null}">
	                              		<td>工单号:${re.workerNo }</td><br/>
	                              		<td>自己:${re.replyContent }</td><br/>
	                              	</c:if>
	                              	<td><c:if test="${re.workerNo == null}">客户:${re.replyContent }</c:if></td><br/>
	                                </c:forEach>             
	                            </div>
	            			</div>                    
	                    </li>
	                 </ul>
	 		   </div>
	 	 </div>
	  </div>
	  <!-- 结束 -->
	  
	  <!-- 开始 -->
	  		<div class="margincenter">
	  		
					<div class="taskto">
						<div class="mart10">
							 <c:if test="${ticket.status == 0 || ticket.status == 1 || ticket.status == 2}"><!-- 未审核 -->
								<textarea  rows = "10" cols ="30" class="js_reply marr10" value="${replyContent }"/></textarea><br/>
		               			<input type="button" class="btnorder" onclick="addReply()" value="回复" />
		               			<c:if test="${roleinfo.code == 'staff' }">
									<input type="button" class="js_applyReply btnorder"  value="申请流转" />
								</c:if>
								<!-- <input type="button" class="btnorder" value="快捷回复" /> -->
								&nbsp;&nbsp;&nbsp;快捷回复:<select class = "js_select_content">
									<option >请选择</option>
								<c:forEach var="quickReply" items="${quickReply }">
									<option >${quickReply.content }</option>
								</c:forEach> 
								</select>
		          			 </c:if>
						</div>
					</div>
	  		</div>
		  <!-- 结束 -->
				
		<!-- 弹出框开始 -->		
		<div class="so-distribution-popbox so-popbox" style="display: none">
			<div class="h2-sopop">
				<span class="s-sopop-title"></span> <span
					class="s-close s-sopop-close">[关闭]</span>
			</div>
			
			<div  class="so-popbox-cont">
				<form action="applyTicketMove" method="post">
				<input type="hidden" value="${userinfo.departmentId }" class="js_departmentId" name="departmentId"/>
				<input type="hidden" value="${userinfo.uuid }" class="js_userId" name="fromUserId"/>
					<input type="hidden"  value="${ticket.uuid }" name="ticketId"/>
					<p>
						<span class="spandetail">处理人员：</span>
						<select required class="selectUser" name="toUserId">
							<option value="">请选择</option>
						</select>
					</p>
					流转原因:<input type="text" name="reason"/>
					<p class="p-so-popBtn js-findcustomer-img">
						<input type="submit" value="确定" />
					</p>
				</form>
			</div>
			
		</div>
		<!-- 弹出框结束 -->	
		<!-- 弹出框开始 -->		
		<div class="so-ticketDistribution-popbox so-popbox" style="display: none">
			<div class="h2-sopop">
				<span class="s-sopop-title"></span> <span
					class="s-close s-sopop-close">[关闭]</span>
			</div>
			
			<div  class="so-popbox-cont">
				<form action="ticketDistribution" method="post">
					<input type="hidden"  value="${ticket.uuid }" name="uuid"/>
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

		<!-- 弹出框结束 -->	
		<!-- 弹出框开始 -->		
		<div class="so-ticketToOther-popbox so-popbox" style="display: none">
			<div class="h2-sopop">
				<span class="s-sopop-title"></span> <span
					class="s-close s-sopop-close">[关闭]</span>
			</div>
			
			<div  class="so-popbox-cont">
				<form action="ticketDistribution" method="post">
					<input type="hidden"  value="${ticket.uuid }" name="uuid"/>
					<p>
						<span class="spandetail">处理人员：</span>
						<select required class="selectAdmin" name="ownerId">
						</select>
					</p>
					<p class="p-so-popBtn js-findcustomer-img">
						<input type="submit" value="确定" />
					</p>
				</form>
			</div>
			
		</div>
		</div>
	<!-- 弹出框结束 -->	


</body>

 <script type="text/javascript" src="res/views/default/js/jquery-1.8.3.min.js"></script>
 <script type="text/javascript" src="res/views/default/js/sobox/jquery.sobox.js"></script>
 <script type="text/javascript" src="res/views/default/js/ticket/applyTicketMove.js"></script>