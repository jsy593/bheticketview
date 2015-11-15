// JavaScript Document
$(document).ready(function(){
							   //给标题加上背景色以及鼠标移动到某一行的事加上背景色
							   $(".bheTable tr:first-child").css("background-color","#f3f7fb");
							   $(".bheTable tr:not(:first-child)").hover(function(){
															 $(this).css("background-color","#f3f7fb");
															 },function(){
																 $(this).css("background-color","#fff");
															 });
															 
								//理由弹框							 
								$(".js-nopass").click(function(){
									$(".reasondiv").show();
								});
								$(".js-cancel").click(function(){
									$(".reasondiv").hide();
								});
								
								//问题分类弹出层
								$(".js-addproblem").click(function(){
									$(".js-problem").show();
								});
								$(".js-problemexit").click(function(){
									$(".js-problem").hide();
								});
								
								//部门管理员弹出层
								$(".js-addmanager").click(function(){
									$(".js-manager").show();
								});
								$(".js-managerexit").click(function(){
									$(".js-manager").hide();
								});
								
								
								
								
								
							  
							   
							   
							   });