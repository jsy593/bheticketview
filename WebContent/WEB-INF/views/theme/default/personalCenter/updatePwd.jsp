<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@ taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 

<link href="res/views/default/js/jqpagination/css/jqpagination.css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>修改密码</title>
<link href="res/views/default/css/basic.css" rel="stylesheet" />
<link href="res/views/default/css/index.css" rel="stylesheet" />
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
						<li><a href="toPersonalCenter">基本资料修改</a></li>
						<li class="spesystemli"><a href="toUpdatePwdMsg">修改密码</a></li>
						<li><a href="toFindPwd">找回密码</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
		<div class="margincenter">
			<div class="clear"></div>
			<div class="mainDetail">
		<p><span class="spandetail">旧密码:</span><input type="password" name="oldPassword" id="js-user-oldPwd" class="txtsearch "/></p><br/>
		<p><span class="spandetail">新密码:</span><input type="password" name="newPassword" id="js-user-newPwd" class="txtsearch "/><span class="errorNewPwd"></span></p><br/>
		<p><span class="spandetail">确认密码:</span><input type="password" name="affirmPassword" id="js-user-confirmPwd" class="txtsearch"/><span class="errorConfirmPwd"></span></p><br/>
		<p><input type="button" value="提交" class=" btnorder js-updatePwd marl100" /></p>				
	</div>

</div>
</body>
	<script type="text/javascript" src="res/views/default/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="res/views/default/js/personalCenter/updatePwd.js"></script>
	<script type="text/javascript" src="res/views/default/js/basic.js"></script>
