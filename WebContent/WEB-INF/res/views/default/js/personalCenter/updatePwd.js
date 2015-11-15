	var result = 0; 
	$(function(){
		$(".js-updatePwd").click(function(){
			result = 0;
			$.post("checkPwd", {"oldPassword":$("#js-user-oldPwd").val()},
				function(data){
						if(data == 1){
							var newPwd =$.trim( $("#js-user-newPwd").val());
							var confirmPwd = $.trim($("#js-user-confirmPwd").val());
							validateNewPwd(newPwd);
							validateConfirmPwd(confirmPwd);
							if(result == 0){
								if(newPwd == confirmPwd){
									$.post("updatePwd", {"newPassword":$("#js-user-newPwd").val()},
										function(data){
											if(data == 1){
												alert("修改成功!");
												window.location.reload(true);
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
						}else{
							alert("原密码错误");
							$("#js-user-oldPwd").val("");//清空输入框
							$("#js-user-newPwd").val("");//清空输入框
							$("#js-user-confirmPwd").val("");//清空输入框
						}
				},"json");
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
	}
	var pwdErrorMsg = function(text) {
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
	