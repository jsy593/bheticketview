<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@ taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>知识库管理</title>
<link href="res/views/default/css/basic.css" rel="stylesheet" />
<link href="res/views/default/css/index.css" rel="stylesheet" />
</head>
<body>
 	<input type="hidden" value="${roleinfo.code }" class="js_role"/>
 	<input type="hidden" value="${departmentinfo.uuid }" class="js_departmentId"/>
	<div class="wrap">
		<div class="margincenter">
			<div class="mainDetail">
				<div>
						<p>
						<span class="spandetail">问题分类：</span>  
						 
						<select class="js_questionTypeId selestatiu" name="questionTypeId" >
							<option value="-1">请选择</option>
							<c:forEach var="questionType" items="${questionTypeList.list }">
								<option value="${questionType.uuid }">${questionType.typeName }</option>
							</c:forEach> 
						</select>
						</p><br/>
						<p>
						<span class=" spandetail">问题：</span>
						<input type="text" name="question" class="js_question txtvalue" />
					</p><br/>
					<p>
						<span class=" spandetail">答案：</span>
						<textarea rows="10" cols="30" name="answer" class="js_answer"></textarea>
					</p><br/> 
					<p>
						<span class=" spandetail">排序：</span>
						<input type="text" name="question" class="js_rank txtvalue" />
					</p><br/> 
					<!-- <p>
						<span class=" spandetail">附件：</span>
						<input type="tel" class="js_add txtvalue" />
					</p><br/> -->
					</div>
					<div class="btndiv">
						<input type="button" class="btnorder" value="确定" onclick="addKnowledgeBase()"/> 
						<input type="reset" class="btnorder"  value="取消" />
					</div>
	
				</div>
		</div>
		</div>

 
</body>
</html>
	<script type="text/javascript" src="res/views/default/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="res/views/default/js/knowledgeBase/addKnowledgeBase.js"></script>
	<script type="text/javascript" src="res/views/default/js/basic.js"></script>
