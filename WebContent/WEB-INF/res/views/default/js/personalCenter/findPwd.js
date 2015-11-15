
$(".js_sendCode").click(function(){
	var phone = $(".js_phone").val();
	var data = {};
	data.phone = phone;
	$.ajax({
		type : "post",
		url : "sendCode",
		data: data,
		dataType : "json",
		success : function(result){
			if("1" == result.state){
				$(".js_code_error").text("已发送");
			}else if("2" == result.state){
				$(".js_code_error").text("发送失败");
			}else{
				$(".js_phone_error").text("该号码未注册");
			}
		}
		
	});
});
$(".js_checkCode").click(function(){
	var data = {};
	var code = $(".js_code").val();
	if(code != ""){
		data.code = code;
		$.ajax({
			type : "post",
			url : "checkCode",
			data: data,
			dataType : "json",
			success : function(result){
				if("1" == result.state){
					$(".js_updatePwdDiv").show();
					$(".js_toFindPwd").hide();
				}else{
					$(".js_code_error").val("验证码错误!");
				}
			}
		
		});
	}
});
$(".js_phone").focus(function(){
	$(".js_phone_error").text("");
});
$(".js_code").focus(function(){
	$(".js_code_error").text("");
});

var result = 0; 
$(function(){
	$(".js_updatePwdDiv").hide();
	$(".js-updatePwd").click(function(){
		result = 0;
		var newPwd =$.trim( $("#js-user-newPwd").val());
		var confirmPwd = $.trim($("#js-user-confirmPwd").val());
		validateNewPwd(newPwd);
		validateConfirmPwd(confirmPwd);
		if(result == 0){
			if(newPwd == confirmPwd){
				$.post("findPwd", {"newPassword":$("#js-user-newPwd").val()},
					function(data){
						if(data == 1){
							alert("修改成功!");
							window.location.href ="toLogin";
						}else{
							alert("修改失败!");
						}
					},"json");
			}else{
				alert("两次输入的密码不一致!");	
				$("#js-user-newPwd").val("");//清空输入框
				$("#js-user-confirmPwd").val("");//清空输入框
			}
		}
	});
});
//验证新密码
function validateNewPwd(pwd) {
	if (pwd == "") {
		pwdErrorMsg("密码不能为空");
		result++;
	} else {
		var reg = /^(?![^a-zA-Z]+$)(?!\D+$).{6,16}$/;
		if (!reg.test(pwd)) {
			pwdErrorMsg("密码是数字和字母的组合，长度为6-16位");
			result++;
		} else {
			pwdErrorMsg();
		}
	}
}var pwdErrorMsg = function(text) {
	if (text != undefined) {
		$(".errorNewPwd").text(text);
		result++;
	} else {
		$(".errorNewPwd").text("");
	}
}
//验证确认的密码
function validateConfirmPwd(pwd) {
	if (pwd == "") {
		ConfirmpwdErrorMsg("密码不能为空");
		result++;
	} else {
		var reg = /^(?![^a-zA-Z]+$)(?!\D+$).{6,16}$/;
		if (!reg.test(pwd)) {
			ConfirmpwdErrorMsg("密码是数字和字母的组合，长度为6-16位");
			result++;
		} else {
			ConfirmpwdErrorMsg();
		}
	}
}
var ConfirmpwdErrorMsg = function(text) {
	if (text != undefined) {
		$(".errorConfirmPwd").text(text);
		result++;
	} else {
		$(".errorConfirmPwd").text("");
	}
}




