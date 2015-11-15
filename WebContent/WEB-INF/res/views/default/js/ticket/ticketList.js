$(".js_allotType").change(function(){
	var allotType = $(".js_allotType").val();
	var data ={};
	data.allotType = allotType;
	$.ajax({
		type : "post",
		url : "updateAllotType",
		data : data,
		dataType : "json",
		success : function(state){
			if(state != 1){
				alert("系统错误!");
			}else{
				alert("修改成功!");
			}
			
		}
	});
	
});
