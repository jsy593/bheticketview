$(function() {
	var systemIndex = $(".systemIndex").val();
	var departmentId;
	var systemAdminId = $(".systemAdminId").val();
	// 得到系统列表
	init(systemAdminId);
	function init(uuid) {
		var data = {};
		data.uuid = uuid;
		console.info(11)
		$.post("getSystemManager", data, function(data) {
			var html = "";
			if (data.state == '1') {
				var list = data.list;
				for(var i=0; i<list.length ; i++){
					html+="<ul>";
					html+="<li><a href='toDepartmentManager?titleNo=1&systemIndex="+list[i].systemIndex+"'>"+ list[i].systemName +"</a></li>";
					html+="</ul>";
				}
			}
			$(".systemList").append(html);
		});
	}
	var option = {
		theme : 'vsStyle',
		expandLevel : 1,
		beforeExpand : function($treeTable, id) {

			// 判断id是否已经有了孩子节点，如果有了就不再加载，这样就可以起到缓存的作用
			if ($('.' + id, $treeTable).length) {
				return;
			}

			// 获取数据
			var thisData = {};
			thisData.departmentId = id;
			thisData.parentId = 0;
			thisData.systemIndex = systemIndex;

			var url = "getQuestionType";
			$.post(url,thisData,function(data) {
								var html = '';
								var list = data.list;
								if (data.state == "1") {
									for (var i = 0; i < list.length; i++) {
										html += '<tr id=' + list[i].uuid+ ' pId="' + id + '">';
										html += '<td>问题分类	</td>';
										html += '<td>' + list[i].typeName+ '</td>';
										html += '<td>'+ (new Date(list[i].createTime)).format("yyyy-MM-dd hh:mm")+ '</td>';
										html += '<td></td>';
										html += '<td><a href="#" id='+ list[i].uuid+ ' class="delQuestionType"" >删除</a></td>';
										html += '</tr>';
									}
								}
								$treeTable.addChilds(html);
							}, "json");
		},
		onSelect : function($treeTable, id) {
			window.console && console.log('onSelect:' + id);
		}
	}
	$('#treeTable').treeTable(option);

	$(document).on("click", ".delQuestionType", function() {
		var uuid = $(this).attr("id");
		var data = {}
		data.uuid = uuid;
		var url = "updateDeptToQuestionType";
		data.departmentId = 0;
		$.post(url, data, function(data) {
			if (data.state == 1) {
				$("#" + uuid).remove();
			}
		}, "json");
	});

	$(".addQuestionType")
			.click(
					function() {
						departmentId = $(this).attr("data-uuid");
						$(".so-popbox-cont").empty();
						// 获取未分配的 问题分类
						var html = '';
						var thisData = {};
						thisData.departmentId = 0;
						thisData.parentId = 0;
						thisData.systemIndex = systemIndex;

						var url = "getQuestionType";
						$.ajaxSetup({
							async : false
						});
						$.post(url,thisData,function(data) {
							var list = data.list;
							if (data.state == "1") {
								for (var i = 0; i < list.length; i++) {
									html += "<input type=checkbox class=questionType id = "
											+ list[i].uuid
											+ " value="
											+ list[i].uuid
											+ ">"
											+ list[i].typeName
											+ " ";
								}
							}
						}, "json");
						$(".so-popbox-cont").append(html);
						$.sobox.pop({
							popTarget : 'div.so-dept-popbox',
							wrapTarget : false,
							maskClick : false,
							title : "选择分类",
						});

					});
	// 变更部门与问题分类对应关系
	$(document).on("click", ".questionType", function() {
		var uuid = $(this).val();
		var data = {}
		data.uuid = uuid;
		var url = "updateDeptToQuestionType";
		if ($(this).prop("checked")) {
			data.departmentId = departmentId;
		} else {
			data.departmentId = 0;
		}
		$.post(url, data, function(data) {
			if (data.state == 1) {
			}
		}, "json");
	})

	// 停用&& 启用
	$(".stop").click(function() {
		changeState(0, $(this).attr('data-uuid'));
	});
	$(".start").click(function() {
		changeState(1, $(this).attr('data-uuid'));
	});
	function changeState(status, uuid) {
		var data = {};
		data.status = status;
		data.uuid = uuid;
		var url = "updateDept";
		$.post(url, data, function(data) {
			if (data.state == '1') {
				window.location.reload();
			}
		}, "json");
	}

	// 添加部门
	$('.addDept').click(function() {
		if($(".systemIndex").val() == "-1" || $(".systemIndex").val() == ""){
			alert("请选择系统!")
			return false;
		}
		$.sobox.pop({
			popTarget : 'div.so-addDept-popbox',
			wrapTarget : false,
			maskClick : false,
			title : "添加部门",
		});
	})

	// $('.addThis').click(function(){
	// var deptName = $('.js-deptName').val();
	// var adminName = $('.js-adminName').val();
	// var code = $('.js-code').val();
	// var password = $('.js-password').val();
	//		
	// var data = {};
	// data.deptName = deptName;
	// data.adminName = adminName;
	// data.code = code;
	// data.password = password;
	// data.systemId = systemId;
	// $.post("addDept", data, function(){
	// window.location.reload();
	// })
	// });
	$(".s-close").click(function(){
		window.location.reload();
	});
});
