var departmentId = $('.js_departmentId').val();
var systemIndex = $('.js_systemIndex').val();
$('.js_applyReply').click(
		function() {

			var data = {};
			data.departmentId = departmentId;
			var url = "getUser";
			$.post(url, data, function(data) {
				if (data.state == "1") {
					var html = "";
					var list = data.list;
					for (var i = 0; i < list.length; i++) {
						html += "<option value=" + list[i].uuid + ">"
								+ list[i].realName + "</option>";
					}
					$(".selectUser").append(html);
				}

			}, "json");
			$.sobox.pop({
				popTarget : 'div.so-distribution-popbox',
				wrapTarget : false,
				maskClick : false,
				title : "申请流转",
			});
		});
$('.ticketDistribution').click(
		function() {
			
			var data = {};
			data.departmentId = departmentId;
			var url = "getUser";
			$.post(url, data, function(data) {
				if (data.state == "1") {
					var html = "";
					var list = data.list;
					for (var i = 0; i < list.length; i++) {
						html += "<option value=" + list[i].uuid + ">"
						+ list[i].realName + "</option>";
					}
				}
				$(".selectUser").append(html);
				
			}, "json");
			$.sobox.pop({
				popTarget : 'div.so-ticketDistribution-popbox',
				wrapTarget : false,
				maskClick : false,
				title : "工单分配",
			});
		});
$('.ticketToOther').click(
		function() {
			
			var data = {};
			data.systemIndex = systemIndex;
			var url = "selectDeptAdminList";
			$.post(url, data, function(data) {
				if (data.state == "1") {
					var html = "";
					var list = data.list;
					for (var i = 0; i < list.length; i++) {
						html += "<option value=" + list[i].uuid + ">" + list[i].deptName + "----"
						+ list[i].realName + "</option>";
					}
				}
				$(".selectAdmin").append(html);
				
			}, "json");
			$.sobox.pop({
				popTarget : 'div.so-ticketToOther-popbox',
				wrapTarget : false,
				maskClick : false,
				title : "工单流转到其他部门",
			});
		});
/* 开始 */
// 将下拉框的值赋给文本框
$(".js_select_content").change(function() {
	if ($(this).val() != "请选择") {
		$(".js_reply").val($(this).val());
	}
});

/* 结束 */

function addReply(systemIndex) {
	var userId = $('.js_userId').val();
	var ticketId = $('.js_ticketId').val();
	var replyContent = $('.js_reply').val();
	var status = 0;
	var data = {};
	data.userId = userId;
	data.ticketId = ticketId;
	data.replyContent = replyContent;
	data.status = status;
	if (systemIndex != null && systemIndex != '') {
		data.systemIndex = systemIndex;
	}

	$.ajax({
		type : "post",
		url : "addTicketReply",
		data : data,
		dataType : "json",
		success : function(state) {
			console.info(state)
			if (state == 1) {
				window.location.reload();
			} else {
				alert("回复失败!");
			}
		},
	});
}
$(".js_closeTicket").click(function() {
	var data = {};
	data.uuid = $(this).attr("data-uuid");
	data.systemIndex = $(this).attr("data-systemIndex");
	var url = "closeTicket";
	$.post(url, data, function(data) {
		if (data.state == '1') {
			alert('关闭成功!')
		} else {
			alert("关闭失败!")
		}
		window.location.reload();
	});
});