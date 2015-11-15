<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<body>
	<div class="clear"></div>
	<div class="wrap">
		<div class="margincenter">
			<div class="mainDetail">
				<div>
					<span class="spandetail">部门名称：</span>${data.name }</div>
					<input type="hidden" class="departmentId" value="${data.uuid }"/>
					<input type="hidden" class="systemIndex" value="${data.systemIndex }"/>
				<div></div>
				
				<div>
					<div>
						<span class="spandetail">部门管理员：</span> 
						<select class="deptUser">
							<option>请选择</option>
						</select>
					</div>
				</div>
	
				</div>
				<br>
				
				<div class="clear"></div>
				<div class="btndiv">
					<input type="button" class="btnorder stop" value="停用" /> 
					<input type="button" class="btnorder start" value="启用" />
				</div>
	
	
				<div class="mart10 addmanager js-manager">
					<p>
						<span class="spandetail">登录名：</span>
						<input type="text" class="txtvalue" />
					</p>
					<p>
						<span class="spandetail">密码：</span>
						<input type="password" class="txtvalue" />
					</p>
					<p>
						<span class="spandetail">电话：</span>
						<input type="tel" class="txtvalue" />
					</p>
					<p>
						<span class="spandetail">邮箱：</span>
						<input type="email" class="txtvalue" />
					</p>
					<p>
						<span class="spandetail">备注：</span>
						<input type="text" class="txtvalue" />
					</p>
					<div class="btndiv">
						<input type="button" class="btnorder" value="确定" /> 
						<input type="button" class="btnorder js-managerexit" value="取消" />
					</div>
				</div>
			</div>
		</div>

	<script src="res/views/default/js/jquery-1.8.3.min.js"></script>
	<script src="res/views/default/js/department/departmentDetail.js"></script>
</body>