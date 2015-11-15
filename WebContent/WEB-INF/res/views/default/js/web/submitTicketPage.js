$(function() {
	var systemIndex = $(".systemIndex").val();
	if (systemIndex == null || systemIndex == '') {
		alert('该系统暂无使用权限 或 密钥错误！')
	}
	// 获取大分类 getQuestionType
	init(systemIndex);
	function init(systemIndex) {
		getQuestionType(systemIndex);
	}
	function getQuestionType(systemIndex) {
		var data = {};
		data.systemIndex = systemIndex;
		data.parentId = '0';
		var url = "getQuestionType";
		$.post(url, data, function(data) {
			console.info(data)
			var html = '';
			if (data.state == '1') {
				var list = data.list;
				for (var i = 0; i < list.length; i++) {
					html += "<option value=" + list[i].uuid + ">"
							+ list[i].typeName + "</option>"
				}
			}
			$(".bigQuestionType").append(html);
		}, 'json')
	}

	// 获取小分类
	$(".bigQuestionType").change(function() {
			var data = {};
			data.systemIndex = systemIndex;
			data.parentId = $(this).val();
			var url = "getQuestionType";
			$.post(url,data,function(data) {
				console.info(data)
				$(".smallQuestionType").empty();
				var html = "";
				if (data.state == '1') {
					var list = data.list;
					for (var i = 0; i < list.length; i++) {
						html += "<span class=spanwid><input name=small class=small value="
								+ list[i].uuid
								+ "  type='radio'/>"
								+ list[i].typeName
								+ "</span>"
					}
				} else {
					html+="暂无分类"
				}
				$(".smallQuestionType").append(html);
			}, 'json')
		});
	
	$(".submit").click(function(){
	var questionType = $('.small:checked').val();
	var title = $(".title").val();
	var question = $(".question").val();
	var email = $(".email").val();
	var phone = $(".phone").val();
	
	var data = {};
	data.questionTypeId = questionType;
	data.question = title;
	data.content = question;
	data.email = email;
	data.phone = phone;
	data.systemIndex = systemIndex;
	data.outerUserId = "123";
	data.status = "0";
	
	var url ="addTicket";
	
	$.post(url, data, function(data){
		if(data.state == '1'){
			alert("提交成功!");
		} else {
			alert("提交失败!");
		}
	})
	})
	
});