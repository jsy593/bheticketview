function reset(){
	$(".js_errorUserName").text("");
}	

var result = 0; 
	//验证用户名
	function validateUserName(userName){
		$(".js_errorUserName").text("");
		if(userName == ""){
			$(".js_errorUserName").text("用户名不能为空");
			result++;
		}
	}

	//验证密码
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
			$(".js_errorNewPwd").text(text);
			result++;
		} else {
			$(".js_errorNewPwd").text("");
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
			$(".js_errorConfirmPwd").text(text);
			result++;
		} else {
			$(".js_errorConfirmPwd").text("");
		}
	}
 	
		//邮箱，电话的验证
		function validateEmailAndPhone(){
			$(".js_errorPhone").text("");
			$(".js_errorEmail").text("");
					var phone = $.trim($(".js_phone").val());
					if(phone != ""){
						var mRegx=/^0?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/ig;
						if(!mRegx.test(phone)){
							unErroPhone("请输入正确的手机号!");
						}else{
							unErroPhone();
						}
					} else{
						unErroPhone("手机号不能为空!");
						
					}
					var email = $.trim($(".js_email").val());
					if(email != ""){
						var emailRegx=/^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/;
						if(!emailRegx.test(email)){
							unErroEmail("请输入正确的邮箱!");
						}else{
							unErroEmail();
						}
					}else{
						unErroEmail("邮箱不能为空!");
						
					}
		}
	
	
	//Phone错误提示
	var unErroPhone = function(text){
	if(text!=undefined){
		result++;
		$(".js_errorPhone").text(text);
		
	}else{
		$("#js_errorPhone").text();
	}
	}
	//Email错误提示
	var unErroEmail = function(text){
	if(text!=undefined){
		result++;
		$(".js_errorEmail").text(text);
	}else{
		$(".js_errorEmail").text();
	}
	}
		
	 
	//注册
	function regist(){
		result = 0;
		validateUserName($.trim( $(".js_username").val()));
		validateNewPwd($.trim( $(".js_password").val()));
		validateConfirmPwd($.trim( $(".js_confirmpwd").val()));
		validateEmailAndPhone();
		if(result == 0){
			if($.trim( $(".js_password").val())== $.trim( $(".js_confirmpwd").val())){
				//基本信息
				var userinfo = {};
				userinfo.username = $(".js_username").val();
				userinfo.password = $(".js_password").val();
				userinfo.email = $(".js_email").val();
				userinfo.phone = $(".js_phone").val();
				userinfo.realName = $(".js_realName").val();
				userinfo.sex = $("#sex input[name='sex']:checked").val();
				userinfo.remark = $(".js_remark").val();
				$.ajax({
					type : "post",
					url : "regist",
					data : userinfo,
					dataType : 'json',
					success : function(state) {
						if (state == 8) {
							$(".js_errorUserName").text("用户名已存在!");
						} else if(state == 2){
							alert("提交失败!");
						}else if(state == 1){
							alert("提交成功，请及时查看邮箱是否审核成功!");
							window.location.reload(true);
						}
						
					}

				});
			}else{
				alert("两次输入的密码不一致!");	
				$("#js-user-newPwd").val("");//清空输入框
				$("#js-user-confirmPwd").val("");//清空输入框
			}
			
		}
		
	}
