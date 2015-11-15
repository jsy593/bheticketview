package com.bhe.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bhe.controller.BaseController;
import com.bhe.util.CommonUtil;
import com.bhe.util.HttpUtil;
import com.bhe.util.JsonUtil;

/**
 * 用户
 * 
 * @author 易川
 * @datetime 2015年9月12日上午10:31:41
 */
@Controller
public class TicketController extends BaseController {

	HttpUtil util = new HttpUtil();

	/**
	 * yc 跳转到工单流转list
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/getTicketMoveList")
	public String getTicketMoveList(Model model, @RequestParam Map<String, String> dataMap, HttpSession session,
			String titleNo) {
		model.addAttribute("titleNo", titleNo);
		dataMap.remove("titleNo");

		if (CommonUtil.isEmpty(dataMap.get("pageIndex"))) {
			dataMap.put("pageIndex", "1");
		}

		if (CommonUtil.isEmpty(dataMap.get("pageSize"))) {
			dataMap.put("pageSize", "15");
		}

		Map<String, Object> user = (Map<String, Object>) session.getAttribute("userinfo");

		dataMap.put("systemIndex", user.get("systemIndex").toString());

		Map<String, Object> result = super.getResult("/selectTicketMoveList", dataMap);

		string2Data(result);

		model.addAttribute("data", result);
		model.addAttribute("pageIndex", dataMap.get("pageIndex"));

		return ".ticket.ticketMoveList";
	}

	/**
	 * 
	 * jsy 跳转到工单list
	 * 
	 * @param model
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/getTicketList")
	public String getTicketList(@RequestParam Map<String, String> data, String titleNo, Model model, HttpSession session) {
		int state = -1;

		model.addAttribute("titleNo", titleNo);

		data.remove("titleNo");
		data.remove("base");
		data.remove("fullPath");

		if (!CommonUtil.isEmpty(data.get("content"))) {
			model.addAttribute("content", data.get("content"));
		}

		if (!CommonUtil.isEmpty(data.get("status"))) {
			model.addAttribute("status", data.get("status"));
		}

		if (CommonUtil.isEmpty(data.get("pageIndex"))) {
			data.put("pageIndex", "1");
		}

		if (CommonUtil.isEmpty(data.get("pageSize"))) {
			data.put("pageSize", "15");
		}


		Map<String, Object> userInfo = (Map<String, Object>) session.getAttribute("userinfo");

		if ("-2".equals(data.get("status"))) {
			data.remove("status");
		} else {
			data.put("ownerId", userInfo.get("uuid").toString());
		}
		data.put("systemIndex", userInfo.get("systemIndex").toString());
		data.put("departmentId", userInfo.get("departmentId").toString());

		if (!CommonUtil.isEmpty(data.get("status"))) {
			Integer status = Integer.parseInt(data.get("status").toString());
			if (status == -1) {
				data.remove("status");
			}
		}
		Map<String, Object> result = super.getResult("/selectTicketList", data);
		state = Integer.parseInt(result.get("state").toString());

		// 根据state值判断返回页面和
		if (state == 0 || state == -1) {
			return errorPage();
		} else if (state == 1) {
			string2Data(result);
		}

		model.addAttribute("ticket", result);

		if (!CommonUtil.isEmpty(result.get("deptMap"))) {
			Map<String, Object> deptMap = (Map<String, Object>) result.get("deptMap");
			if (!CommonUtil.isEmpty(deptMap.get("data"))) {
				Map<String, Object> dataMap = (Map<String, Object>) deptMap.get("data");
				model.addAttribute("allotType", dataMap.get("allotType"));
			}
		}

		model.addAttribute("pageIndex", data.get("pageIndex"));

		return ".ticket.ticketList";
	}

	/**
	 * yc 跳转到工单流转One
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/getTicketMoveOne")
	public String getTicketMoveOne(Model model, @RequestParam String uuid, HttpSession session, String titleNo) {
		Map<String, String> paramsMap = new HashMap<String, String>();

		model.addAttribute("titleNo", titleNo);

		Map<String, Object> userInfo = (Map<String, Object>) session.getAttribute("userinfo");

		paramsMap.put("uuid", uuid);
		paramsMap.put("systemIndex", userInfo.get("systemIndex").toString());

		Map<String, Object> result = super.getResult("/selectTicketMoveOne", paramsMap);

		string2Data(result);

		model.addAttribute("data", result.get("data"));

		return ".ticket.ticketMoveDetails";
	}

	/**
	 * yc 审核流转
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "passTicketMove")
	@ResponseBody
	public Map<String, Object> passTicketMove(Model model, @RequestParam Map<String, String> dataMap,
			HttpSession session) {
		Map<String, Object> userInfo = (Map<String, Object>) session.getAttribute("userinfo");

		dataMap.put("status", "1");
		dataMap.put("systemIndex", userInfo.get("systemIndex").toString());

		Map<String, Object> result = super.getResult("/checkTicketMove", dataMap);

		return result;
	}

	/**
	 * yc 流转驳回
	 * 
	 * @return
	 */
	@SuppressWarnings({ "unused", "unchecked" })
	@RequestMapping(value = "rejectTicketMove")
	public String rejectTicketMove(Model model, @RequestParam Map<String, String> dataMap, HttpSession session) {
		Map<String, Object> userInfo = (Map<String, Object>) session.getAttribute("userinfo");

		dataMap.put("status", "2");
		dataMap.put("systemIndex", userInfo.get("systemIndex").toString());

		Map<String, Object> result = super.getResult("/rejectTicketMove", dataMap);

		return "redirect:getTicketMoveOne?uuid=" + dataMap.get("uuid");
	}

	/**
	 * yc 流转分配
	 * 
	 * @return
	 */
	@SuppressWarnings({ "unused", "unchecked" })
	@RequestMapping(value = "distributionTicketMove")
	public String distributionTicketMove(Model model, @RequestParam Map<String, String> dataMap, HttpSession session) {
		Map<String, Object> userInfo = (Map<String, Object>) session.getAttribute("userinfo");

		dataMap.put("status", "3");
		dataMap.put("systemIndex", userInfo.get("systemIndex").toString());

		Map<String, Object> result = super.getResult("/distributionTicketMove", dataMap);

		return "redirect:getTicketMoveOne?uuid=" + dataMap.get("uuid");
	}

	/**
	 * yc 工单分配
	 * 
	 * @return
	 */
	@SuppressWarnings({ "unused", "unchecked" })
	@RequestMapping(value = "ticketDistribution")
	public String ticketDistribution(Model model, @RequestParam Map<String, String> dataMap, HttpSession session) {
		Map<String, Object> userInfo = (Map<String, Object>) session.getAttribute("userinfo");

		dataMap.put("systemIndex", userInfo.get("systemIndex").toString());

		Map<String, Object> result = super.getResult("/ticketDistribution", dataMap);

		return "redirect:getTicketList?titleNo=0";
	}

	/**
	 * 
	 * jsy 跳转到工单详情
	 * 
	 * @param model
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/getTicketDetails")
	public String getTicketDetails(@RequestParam String uuid, Model model, HttpSession session, String titleNo) {
		Map<String, String> data = new HashMap<String, String>();
		Map<String, String> dataMap = new HashMap<String, String>();
		int state = -1;

		model.addAttribute("titleNo", titleNo);

		data.put("uuid", uuid);

		Map<String, Object> userInfo = (Map<String, Object>) session.getAttribute("userinfo");

		data.put("systemIndex", userInfo.get("systemIndex").toString());
		data.put("userId", userInfo.get("uuid").toString());
		
		dataMap.put("uuid", uuid);
		dataMap.put("systemIndex", userInfo.get("systemIndex").toString());
		Map<String, Object> result1 = super.getResult("/updateTicket", dataMap);
		Map<String, Object> result = super.getResult("/selectTicketOne", data);

		state = Integer.parseInt(result.get("state").toString());

		// 根据state值判断返回页面和
		if (state == 0 || state == -1) {
			return errorPage();
		} else if (state == 1) {
			string2Data(result);
		}

		model.addAttribute("ticket", result.get("data"));
		model.addAttribute("reply", result.get("list"));
		model.addAttribute("quickReply", result.get("quickReplyList"));

		return ".ticket.ticketDetails";
	}

	/**
	 * 
	 * jsy 申请流转
	 * 
	 * @param model
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/applyTicketMove")
	public String applyTicketMove(@RequestParam Map<String, String> data, Model model, HttpSession session) {
		int state = -1;

		data.put("status", "0");

		Map<String, Object> userInfo = (Map<String, Object>) session.getAttribute("userinfo");

		data.put("systemIndex", userInfo.get("systemIndex").toString());

		Map<String, Object> result = super.getResult("/insertTicketMove", data);

		state = Integer.parseInt(result.get("state").toString());

		// 根据state值判断返回页面和
		if (state == 0 || state == -1) {
			return errorPage();
		} else if (state == 1) {
			string2Data(result);
			return "redirect:getTicketDetails?uuid=" + data.get("ticketId").toString();
		}

		return errorPage();
	}

	/**
	 * 
	 * jsy 回复
	 * 
	 * @param model
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/addTicketReply")
	@ResponseBody
	public String addTicketReply(@RequestParam Map<String, String> data, Model model, HttpSession session) {
		int state = -1;

		if (!CommonUtil.isEmpty(data.get("replyContent"))) {
			model.addAttribute("replyContent", data.get("replyContent"));
		}

		if (CommonUtil.isEmpty(data.get("systemIndex"))) {
			Map<String, Object> userInfo = (Map<String, Object>) session.getAttribute("userinfo");
			data.put("systemIndex", userInfo.get("systemIndex").toString());
		}

		Map<String, Object> result = super.getResult("/insertTicketReply", data);

		state = Integer.parseInt(result.get("state").toString());

		// 根据state值判断返回页面和
		if (state == 0 || state == -1) {
			return errorPage();
		}

		return state + "";
	}

	/**
	 * 
	 * jsy 选择工单分配方式
	 * 
	 * @param model
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/updateAllotType")
	@ResponseBody
	public String updateAllotType(@RequestParam Map<String, String> data, Model model, HttpSession session) {
		int state = -1;

		if (!CommonUtil.isEmpty(data.get("allotType"))) {
			model.addAttribute("allotType", data.get("allotType"));
		}

		if (CommonUtil.isEmpty(data.get("departmentId"))) {
			Map<String, Object> userInfo = (Map<String, Object>) session.getAttribute("userinfo");
			data.put("uuid", userInfo.get("departmentId").toString());
		}

		Map<String, Object> result = super.getResult("/updateAllotType", data);

		state = Integer.parseInt(result.get("state").toString());

		// 根据state值判断返回页面和
		if (state == 0 || state == -1) {
			return errorPage();
		}

		return state + "";
	}
}
