package com.bhe.controller.admin.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bhe.controller.BaseController;
import com.bhe.util.CommonUtil;
import com.bhe.util.HttpUtil;
import com.bhe.util.MD5Util;

/**
 * 用户
 * 
 * @author 易川
 * @datetime 2015年9月12日上午10:31:41
 */
@Controller
public class UserController extends BaseController {

	HttpUtil util = new HttpUtil();

	/**
	 * yc 登陆
	 * 
	 * @param data
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> login(@RequestParam Map<String, String> data, HttpSession session) {
		Map<String, Object> result = super.getResult("/login", data);
		
		session.setAttribute("userinfo", result.get("userInfo"));
		session.setAttribute("roleinfo", result.get("roleInfo"));
		session.setAttribute("departmentinfo", result.get("departmentInfo"));
		
		return result;
	}

	/**
	 * yc 注销
	 * 
	 * @param data
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/logout")
	public String logout(HttpSession session) {
		session.setAttribute("userinfo", null);
		session.setAttribute("roleinfo", null);
		session.setAttribute("departmentinfo", null);

		return "redirect:/toLogin";
	}

	/**
	 * yc 跳转到登陆页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toLogin")
	public String toLogin() {
		return "/default/index";
	}

	/**
	 * jsy 跳转管理员列表页面
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/getAdminList")
	public String getAdminList(@RequestParam Map<String, String> data, Model model, String titleNo) {
		List<Map<String, Object>> listmap = null;
		int state = -1;
		
		if (!CommonUtil.isEmpty(data.get("content"))) {
			model.addAttribute("content", data.get("content"));
		}
		
		if (!CommonUtil.isEmpty(data.get("status"))) {
			model.addAttribute("status", data.get("status"));
		}
		
		model.addAttribute("titleNo", titleNo);
		
		data.remove("titleNo");
		
		if (CommonUtil.isEmpty(data.get("pageIndex"))) {
			data.put("pageIndex", "1");
		}
		
		
		if (CommonUtil.isEmpty(data.get("pageSize"))) {
			data.put("pageSize", "15");
		}
		
		if (!CommonUtil.isEmpty(data.get("status"))) {
			Integer status = Integer.parseInt(data.get("status").toString());
			if (status == -1) {
				data.remove("status");
			}
		}
		
		Map<String, Object> result = super.getResult("/selectAdminList", data);
		
		state = Integer.parseInt(result.get("state").toString());
		listmap = (List<Map<String, Object>>) result.get("list");

		// 根据state值判断返回页面和
		if (state == 0 || state == -1) {
			return errorPage();
		} else if (state == 1) {
			if (!CommonUtil.isEmpty(listmap)) {
				for (Map<String, Object> map : listmap) {
					timeToDate(map);
					sexToStr(map);
				}
			}
		}
		
		model.addAttribute("pageIndex", data.get("pageIndex"));
		model.addAttribute("adminList", result);
		
		return ".user.admin";
	}

	/**
	 * yc 员工列表
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/getPeopleManageList")
	public String getPeopleManageList(@RequestParam Map<String, String> data, Model model, String titleNo) {
		List<Map<String, Object>> listmap = null;
		int state = -1;
		
		if (!CommonUtil.isEmpty(data.get("content"))) {
			model.addAttribute("content", data.get("content"));
		}
		
		if (!CommonUtil.isEmpty(data.get("status"))) {
			model.addAttribute("status", data.get("status"));
		}
		
		model.addAttribute("titleNo", titleNo);
		
		data.remove("titleNo");
		data.remove("base");
		data.remove("fullPath");
		
		if (CommonUtil.isEmpty(data.get("pageIndex"))) {
			data.put("pageIndex", "1");
		}
		
		if (CommonUtil.isEmpty(data.get("pageSize"))) {
			data.put("pageSize", "15");
		}
		
		Map<String, Object> result = super.getResult("/selectStaffList", data);
		
		state = Integer.parseInt(result.get("state").toString());
		listmap = (List<Map<String, Object>>) result.get("list");

		// 根据state值判断返回页面和
		if (state == 0) {
			return errorPage();
		} else if (state == 1) {
			if (!CommonUtil.isEmpty(listmap)) {
				for (Map<String, Object> map : listmap) {
					timeToDate(map);
					sexToStr(map);
				}
			}
		}
		
		model.addAttribute("pageIndex", data.get("pageIndex"));
		model.addAttribute("userList", result);
		
		return ".user.staff";
	}

	/**
	 * jsy 跳转用户详情
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/getAdminDetails")
	public String getAdminDetails(@RequestParam Map<String, String> data, Model model, String titleNo) {
		Map<String, Object> map = null;
		int state = -1;
		
		model.addAttribute("titleNo", titleNo);
		data.remove("titleNo");

		Map<String, Object> result = super.getResult("/selectUserOne", data);
		
		state = Integer.parseInt(result.get("state").toString());
		map = (Map<String, Object>) result.get("data");

		// 根据state值判断返回页面和
		if (state == 0) {
			return errorPage();
		} else if (state == 1) {
			if (!CommonUtil.isEmpty(map)) {
				timeToDate(map);
				sexToStr(map);
			}
		}
		
		model.addAttribute("user", map);
		
		return ".user.adminDetails";
	}

	/**
	 * jsy 跳转用户详情
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/getStaffDetails")
	public String getStaffDetails(@RequestParam Map<String, String> data, Model model, String titleNo) {
		Map<String, Object> map = null;
		int state = -1;
		
		model.addAttribute("titleNo", titleNo);
		data.remove("titleNo");

		Map<String, Object> result = super.getResult("/selectUserOne", data);
	
		state = Integer.parseInt(result.get("state").toString());
		map = (Map<String, Object>) result.get("data");

		// 根据state值判断返回页面和
		if (state == 0 || state == -1) {
			return errorPage();
		} else if (state == 1) {
			if (!CommonUtil.isEmpty(map)) {
				timeToDate(map);
				sexToStr(map);
			}
		}
		
		model.addAttribute("user", map);
		
		return ".user.staffDetails";
	}

	/**
	 * 
	 * jsy 审核用户
	 * 
	 * @param data
	 * @param model
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/changeUserStatus", method = RequestMethod.POST)
	@ResponseBody
	public String checkUser(@RequestParam Map<String, String> data, Model model) {
		int state = -1;

		Map<String, Object> result = super.getResult("/checkUser", data);
		
		state = Integer.parseInt(result.get("state").toString());

		String str = String.valueOf(state);
		
		return str;
	}

	/**
	 * 
	 * jsy 注册
	 * 
	 * @param data
	 * @param model
	 */
	@RequestMapping(value = "/regist", method = RequestMethod.POST)
	@ResponseBody
	public String regist(@RequestParam Map<String, String> data, Model model) {
		int state = -1;

		Map<String, Object> result = super.getResult("/regist", data);
		
		state = Integer.parseInt(result.get("state").toString());

		// 根据state值判断返回页面和
		if (state == 0 || state == -1) {
			return errorPage();
		}
		
		String str = String.valueOf(state);
		
		return str;
	}

	/**
	 * 进入主页
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toHome")
	public String toHome() {
		return "..home";
	}

	/**
	 * jsy 跳转注册页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toRegist")
	public String toRegist() {
		return "/default/user/regist";
	}

	/**
	 * jsy 跳转添加部门页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toAddDept", method = RequestMethod.POST)
	public String toAddDpt() {
		return "/AddDepartmentPage";
	}

	/**
	 * yc 获取用户
	 * 
	 * @param data
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/getUser", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getUser(@RequestParam Map<String, String> data, Model model) {
		Map<String, Object> result = super.getResult("/selectUserBydept", data);

		return result;
	}

	/**
	 * yc 添加员工
	 * 
	 * @param data
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/addUser", method = RequestMethod.POST)
	public String addUser(@RequestParam Map<String, String> data) {
		int state = -1;
		
		data.put("code", "staff");
		
		Map<String, Object> result = super.getResult("/selectUser", data);

		state = Integer.parseInt(result.get("state").toString());
		
		// 根据state值判断返回页面和
		if (state == 0 || state == -1) {
			return errorPage();
		}
				
		return "redirect:getPeopleManageList?titleNo=4&departmentId=" + data.get("departmentId").toString();
	}

	/**
	 * 个人中心页面 jsy
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/toPersonalCenter")
	public String personalCenter(Model model, HttpSession session) {
		Map<String, String> dataMap = new HashMap<String, String>();
		
		if (CommonUtil.isEmpty(session.getAttribute("userinfo"))) {
			return "redirect:/toLogin";
		}
		
		Map<String, Object> user = (Map<String, Object>) session.getAttribute("userinfo");
		dataMap.put("uuid", user.get("uuid").toString());

		Map<String, Object> result = super.getResult("/getUserInfo", dataMap);
		
		model.addAttribute("user", result.get("data"));

		return "/default/personalCenter/personalCenter";
	}

	/**
	 * 找回密码页面 jsy
	 */
	@RequestMapping(value = "/toFindPwd")
	public String findPwd(Model model) {
		return "/default/personalCenter/findPwd";
	}

	/**
	 * 修改密码页面 jsy
	 */
	@RequestMapping(value = "/toUpdatePwdMsg")
	public String updatePage(Model model,HttpSession session) {
		if (CommonUtil.isEmpty(session.getAttribute("userinfo"))) {
			return "redirect:/toLogin";
		}
		
		return "/default/personalCenter/updatePwd";
	}

	// 判断// 判断密码
	// 加密
	// 返回
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/checkPwd", method = RequestMethod.POST)
	@ResponseBody
	public String checkPwd(@RequestParam String oldPassword, HttpSession session) {
		Map<String, String> map = new HashMap<String, String>();
		
		Map<String, Object> userInfo = (Map<String, Object>) session.getAttribute("userinfo");
		
		if (!CommonUtil.isEmpty(userInfo.get("uuid"))) {
			map.put("uuid", userInfo.get("uuid").toString());
		}
		
		String password = MD5Util.string2MD5(oldPassword);
		map.put("password", password);
		
		Map<String, Object> result = super.getResult("/selectUserOne", map);

		return result.get("state").toString();

	}

	// 修改

	@SuppressWarnings("unchecked")
	/**
	 * 修改密码 jsy
	 */
	@RequestMapping(value = "/updatePwd", method = RequestMethod.POST)
	@ResponseBody
	public String updatePasswordById(@RequestParam String newPassword, HttpSession session) {
		Map<String, String> map = new HashMap<String, String>();
		
		Map<String, Object> userInfo = (Map<String, Object>) session.getAttribute("userinfo");
		
		newPassword = MD5Util.string2MD5(newPassword);
		map.put("password", newPassword);
		map.put("uuid", userInfo.get("uuid").toString());
		map.put("status", userInfo.get("status").toString());
		
		Map<String, Object> result = super.getResult("/updateUser", map);

		return result.get("state").toString();

	}
	
	/**
	 * 找回密码之修改密码  jsy
	 */
	@RequestMapping(value = "/findPwd", method = RequestMethod.POST)
	@ResponseBody
	public String updatePwd(@RequestParam String newPassword, HttpSession session) {
		Map<String, String> map = new HashMap<String, String>();
		
		newPassword = MD5Util.string2MD5(newPassword);
		String uuid = session.getAttribute("uuid").toString();
		
		map.put("uuid", uuid);
		map.put("status", "1");
		map.put("password", newPassword);
		
		Map<String, Object> result = super.getResult("/updateUser", map);
		
		return result.get("state").toString();
		
	}

	/**
	 *发送验证码
	 *jsy
	 */
	@RequestMapping(value="/sendCode",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> sendCode(@RequestParam Map<String, String> data, HttpSession session){
		Map<String, Object> result = super.getResult("/sendCode", data);
		
		if (!CommonUtil.isEmpty(result.get("code"))){
			String code = MD5Util.string2MD5(result.get("code").toString());
			session.setAttribute("code", code);
			session.setAttribute("uuid", result.get("uuid"));
		}
		
		return result;
	}
	
	
	/**
	 * 检查验证码
	 * 
	 * @author jsy
	 * @param roleMap
	 * @return 
	 */
	@RequestMapping(value = "/checkCode", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> checkCode(@RequestParam Map<String, String> data,HttpSession session) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		String code = session.getAttribute("code").toString();
		String sendCode = data.get("code").toString();
		
		if (!CommonUtil.isEmpty(sendCode)){
			sendCode = MD5Util.string2MD5(sendCode);
			
			if (code.equals(sendCode)){
				resultMap.put("state", "1");
			} else {
				resultMap.put("state", "2");
			}
		}
		
		return resultMap;
		
	}
	/**
	 * 修改个人信息 yc
	 */
	@RequestMapping(value = "/updateUserInfo", method = RequestMethod.POST)
	public String updateUserInfo(@RequestParam Map<String, String> dataMap, HttpSession session) {
		dataMap.put("status", "1");
		
		Map<String, Object> result = super.getResult("/updateUser", dataMap);
		
		return "redirect:toPersonalCenter";

	}

	/**
	 * 生成 发送验证码yc
	 */
	@RequestMapping(value = "/sendValidateNo", method = RequestMethod.POST)
	@ResponseBody
	public String sendValidateNo(@RequestParam Map<String, String> dataMap, HttpSession session) {
		Long validateLong = (long) (Math.random() * 9000 + 1000);
		String valudataCode = validateLong.toString();
		dataMap.put("code", valudataCode);
		
		session.setAttribute("validateCode", valudataCode);
		
		Map<String, Object> result = super.getResult("/sendCode", dataMap);
		return valudataCode;
	}

	/**
	 * 修改绑定手机yc
	 */
	@RequestMapping(value = "/updatePhone", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updatePhone(@RequestParam Map<String, String> dataMap, HttpSession session) {
		String valudataCode = (String) session.getAttribute("validateCode");
		
		if (!CommonUtil.isEmpty(dataMap.get("validateNo")) && dataMap.get("validateNo").equals(valudataCode)) {
			dataMap.put("status", "1");
			dataMap.remove("validateNo");
			
			Map<String, Object> result = super.getResult("/updateUser", dataMap);
			
			return result;
		}

		return new HashMap<String, Object>();
	}

	/**
	 * 生成 发送邮箱验证yc
	 */
	@RequestMapping(value = "/sendEmail", method = RequestMethod.POST)
	@ResponseBody
	public String sendEmail(@RequestParam Map<String, String> dataMap, HttpSession session) {
		Long validateLong = (long) (Math.random() * 9000 + 1000);
		String valudataCode = validateLong.toString();
		
		session.setAttribute("validateCode", valudataCode);

		return valudataCode;
	}

	/**
	 * 验证邮箱并修改yc
	 */
	@RequestMapping(value = "/updateEmail", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateEmail(@RequestParam Map<String, String> dataMap, HttpSession session) {
		String valudataCode = (String) session.getAttribute("validateCode");
		
		if (!CommonUtil.isEmpty(dataMap.get("validateNo")) && dataMap.get("validateNo").equals(valudataCode)) {
			dataMap.put("status", "1");
			dataMap.remove("validateNo");
			
			Map<String, Object> result = super.getResult("/updateUser", dataMap);
			
			return result;
		}

		return new HashMap<String, Object>();
	}

	
}
