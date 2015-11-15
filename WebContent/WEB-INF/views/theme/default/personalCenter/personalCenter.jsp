<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@ taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<link href="res/views/default/css/basic.css" rel="stylesheet" />
<link href="res/views/default/css/index.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="res/views/default/js/sobox/popbox-style.css">
<body>
		<div class="clear"></div>
		<div class="header">
    		<div class="margincenter">     		
	        	<div class="headertop">
	            	<div class="headertopleft left">通用工单系统：${userinfo.realName }</div>
	                <div class="headertopright right"><a href="logout" class="exita">退出登录</a> </div>&nbsp;&nbsp;&nbsp;
	            	<div class="headertopright right"><a href="toPersonalCenter" class="js_personalCenter header">个人中心&nbsp;&nbsp;&nbsp;</a></div>
	            	<div class="headertopright right"><a href="toHome" class="header">返回首页&nbsp;&nbsp;&nbsp;</a></div>
	            </div>
    		</div>
        </div>
		<div class="wrap">
		
			<div class="margincenter">
			<div class="main">
				<div class="systemdiv">
					<ul class="systemUl">
						<li class="spesystemli"><a href="toPersonalCenter">基本资料修改</a></li>
						<li><a href="toUpdatePwdMsg">修改密码</a></li>
						<li><a href="toFindPwd">找回密码</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<div class="margincenter">
		<form action="updateUserInfo" method="post">
			<input type="hidden" value="${userinfo.uuid }" name="uuid"/>
			<div><span class="spandetail">账号：</span>${userinfo.username }</div>
			<div><span class="spandetail">工号：</span>${userinfo.workerNo }</div>
			<div><span class="spandetail">姓名：</span><input type="text" name="realName" class="txtvalue" value="${user.realName }"/></div>
			<div><span class="spandetail">性别：</span>
			<input type="radio" name="sex"
				<c:if test="${user.sex == '1'}">
					checked
				</c:if>
			 value="1"/>男
			<input type="radio" name="sex" 
				<c:if test="${user.sex == '0'}">
				checked
			</c:if>
			value="0"/>女
			</div>
			<div><span class="spandetail">手机：</span><input type="text" value="${user.phone }" class="txtvalue" name = "phone"/></div>
			<div><span class="spandetail">邮箱：</span><input type="text" value="${user.email}" class="txtvalue" name = "email"/></div> 
			<div><span class="spandetail">部门：</span>${departmentinfo.data.name }</div>
			<div><span class="spandetail">职位：</span>${roleinfo.roleName }</div> 
			<div><input type="submit" class="btnorder marl100" value="保存修改"/></div>
		</form> 
	</div>
	<div class="so-phone-popbox so-popbox" style="display: none">
		<div class="h2-sopop">
			<span class="s-sopop-title"></span> <span
				class="s-close s-sopop-close">[关闭]</span>
		</div>
		<div >
			<p class="so-popbox-cont">
				<span class="spandetail">手机号:</span><input type="text" class="js-phoneNo txtvalue"/> <a href="#" class="js-sendValidateNo">发送验证码</a><br>
				<span class="spandetail">验证码:</span><input type="text" class="js-validateNo txtvalue"/>
			</p>
			<p class="p-so-popBtn js-findcustomer-img">
				<input type="button" class="js-updatePhone btnorder" data-uuid="${userinfo.uuid }" value="确定" />
			</p>
		</div>
	</div>
	<div class="so-email-popbox so-popbox" style="display: none">
		<div class="h2-sopop">
			<span class="s-sopop-title"></span> <span
				class="s-close s-sopop-close">[关闭]</span>
		</div>
		<div >
			<p class="so-popbox-cont">
				<span class="spandetail">邮箱:</span><input type="text" class="js-email txtvalue"/> <a href="#" class="js-sendEmail">发送验证邮件</a><br>
			</p>
			<p class="p-so-popBtn js-findcustomer-img">
				<input type="button" class="js-updatePhone btnorder"  data-uuid="${userinfo.uuid }" value="确定" />
			</p>
		</div>
	</div>
	</body>
	<script type="text/javascript" src="res/views/default/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="res/views/default/js/personalCenter/findPwd.js"></script>
	<script type="text/javascript" src="res/views/default/js/basic.js"></script>
	<script type="text/javascript" src="res/views/default/js/sobox/jquery.sobox.js"></script>
 	<script type="text/javascript">
 	//绑定手机
	$('.js-addPhone').click(function() {
		$.sobox.pop({
			popTarget : 'div.so-phone-popbox',
			wrapTarget : false,
			maskClick : false,
			title : "绑定手机",
		});
	})
	
	//发送短信验证码
	$(".js-sendValidateNo").click(function(){
		var phone = $(".js-phoneNo").val();
		var data = {};
		data.phone = phone;
		$.post('sendValidateNo', data, function(data){
			console.info(data);
		})
	});
 
 //修改 绑定手机
 $(".js-updatePhone").click(function(){
	 var phone = $(".js-phoneNo").val();
	 var validateNo = $(".js-validateNo").val();
	 var uuid = $(this).attr("data-uuid");
	 var data = {};
	 data.phone = phone;
	 data.validateNo = validateNo;
	 data.uuid = uuid;
	 
	 $.post("updatePhone", data, function(data){
		 if(data.state == '1') {
			 window.location.reload();
		 } else {
			 alert("验证码错误");
		 }
	 });
 })
 //绑定邮箱
 $('.js-addEmail').click(function() {
		$.sobox.pop({
			popTarget : 'div.so-email-popbox',
			wrapTarget : false,
			maskClick : false,
			title : "绑定邮箱",
		});
	})
 //发送邮件
	$(".js-sendEmail").click(function(){
		var email = $(".js-email").val();
		var data = {};
		data.phone = phone;
		$.post('sendEmail', data, function(data){
			console.info(data);
		})
	});
	</script>

