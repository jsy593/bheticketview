<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="res/views/default/css/basic.css"> 
<link rel="stylesheet" href="res/views/default/css/index.css"> 
<title>无标题文档</title>
	<body>
		<div class="wrap">
	    <input type="hidden" value="${data.systemIndex }" class="systemIndex"/>
	    	<div>
	        	<span class="spandetail"><i>*</i>分类：</span>
	            <select class="bigQuestionType">
	            	<option value="-1">请选择</option>
	            </select>
	    	</div>
	        <div class="left">
	        	<span class="spandetail left" style="width:120px;"><i>*</i>选择常见问题：</span>
	            <div class="divwid left smallQuestionType">
	            </div>
	    	</div>
	        <div class="clear"></div>
	        <div class="mar5">
	        	<span class="spandetail left"><i>*</i>标题：</span>
	            <input type="text" class="title" placeholder="标题" />
	        </div>
	        <div class='clear'></div>
	        <div class="mar5">
	        	<span class="spandetail left"><i>*</i>问题描述：</span>
	            <textarea class="txtaradetail question" placeholder="问题描述" ></textarea>
	        </div>
	        <div class="clear"></div>
	        <div class="mar5">
	        	<span class="spandetail left"><i>*</i>手机号：</span>
	        	<input type="text" class="txtorder phone" />
	        </div>
	        <div class="clear"></div>
	        <div class="mar5">
	        	<span class="spandetail left"><i>*</i>邮箱：</span>
	        	<input type="text" class="txtorder email" />
	        </div>
	        <div class="clear"></div>
<!-- 	        <div class="mar5"> -->
<!-- 	        	<span class="spandetail left">上传附件：</span> -->
<!-- 	        	<input type="file"  value="上传附件" class="fileorder"/> -->
<!-- 	            <div>可上传<i>3个附件</i>每个附件大小不得超过2M.附件支持的格式有："jpg","bmp","png","gif","txt","rar","zip","doc","docx","ini","conf","eml"</div> -->
<!-- 	        </div> -->
	        
	        <div>
	        	<span class="spandetail left">&nbsp;</span>
	        	<input type="button" class="btnlogin submit" value="提交" />
	        </div>
	        
	    
	    </div>
	    <script type="text/javascript" src="res/views/default/js/jquery-1.8.3.min.js"></script>
	    <script src="res/views/default/js/web/submitTicketPage.js"></script>
	</body>
</html>