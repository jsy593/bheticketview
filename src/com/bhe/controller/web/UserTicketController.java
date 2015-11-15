package com.bhe.controller.web;

import java.util.List;
import java.util.Map;


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
public class UserTicketController extends BaseController {

	HttpUtil util = new HttpUtil();

	/**
	 * yc 跳转到工单提交页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toTicketPage")
	public String toTicketPage(Model model, @RequestParam Map<String, String> dataMap) {
		Map<String, Object> result = super.getResult("/selectSystemOne", dataMap);
		
		model.addAttribute("data", result.get("data"));

		return "/default/web/submitTicketPage";
	}

	/**
	 * yc 跳转到工单提交页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toTicketList")
	public String toTicketList(Model model, @RequestParam Map<String, String> dataMap) {
		
		if(CommonUtil.isEmpty(dataMap.get("pageIndex"))){
			dataMap.put("pageIndex", "1");
		}
		
		if(CommonUtil.isEmpty(dataMap.get("pageSize"))){
			dataMap.put("pageSize", "15");
		}
		
		Map<String, Object> result = super.getResult("/selectCustomerTicketList", dataMap);
		
		model.addAttribute("pageIndex", dataMap.get("pageIndex"));
		model.addAttribute("data", result);

		return "/default/web/ticketList";
	}

	/**
	 * yc 工单提交
	 * 
	 * @return
	 */
	@RequestMapping(value = "/addTicket")
	@ResponseBody
	public Map<String, Object> addTicket(Model model, @RequestParam Map<String, String> dataMap) {
		Map<String, Object> result = super.getResult("/insertTicket", dataMap);

		return result;
	}

	/**
	 * 
	 * yc 跳转到工单详情
	 * 
	 * @param model
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/getUserTicketDetails")
	public String getUserTicketDetails(@RequestParam Map<String, String> data, Model model) {
		int state = -1;
		
		Map<String, Object> result = super.getResult("/selectTicketOne", data);
		
		state = Integer.parseInt(result.get("state").toString());

		// 根据state值判断返回页面和
		if (state == 0 || state == -1) {
			return errorPage();
		} else if (state == 1) {
			string2Data(result);
		}
		model.addAttribute("systemIndex", data.get("systemIndex"));
		model.addAttribute("ticket", result.get("data"));
		model.addAttribute("reply", result.get("list"));
		
		return "default/web/ticketDetails";
	}

	/**
	 * 
	 * yc 关闭工单
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/closeTicket")
	@ResponseBody
	public Map<String, Object> closeTicket(@RequestParam Map<String, String> data, Model model) {
		Map<String, Object> result = super.getResult("/closeTicket", data);

		return result;
	}

}