function addKnowledgeBase(){
	var question = $(".js_question").val();
	var answer = $(".js_answer").val();
	var questionTypeId = $(".js_questionTypeId").val();
	var rank = $(".js_rank").val();
	var departmentId = $(".js_departmentId").val();
	var status = "";
	if($(".js_role").val() == 'departmentAdmin'){
		status += 1;
	}
	if($(".js_role").val() == 'staff'){
		status += 2;
	}
	var data = {};
	if($.trim(question) !="" && $.trim(question) != undefined ){
		data.question = question;
	}
	if(answer !="" && answer != undefined){
		data.answer = answer;
	}
	if(questionTypeId !="" && questionTypeId !=undefined){
		data.questionTypeId = questionTypeId;
	}
	if(rank !="" && rank !=undefined){
		data.rank = rank;
	}
	if(departmentId !="" && departmentId !=undefined){
		data.departmentId = departmentId;
	}
	data.status= status;
	$.ajax({
		type : "post",
		url : "addKnowledgeBase",
		data : data,
		success : function(state) {
			if(state == 1){
				alert("添加成功!");
				window.location.href='getKnowledgeBaseList?titleNo=1';
			}else{
				alert("添加失败!");
			}
		}
	});
}