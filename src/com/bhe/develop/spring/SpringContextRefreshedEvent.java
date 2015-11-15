package com.bhe.develop.spring;

import java.io.UnsupportedEncodingException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;

import com.bhe.develop.web.CachePool;
import com.bhe.util.PropertiesUtil;


/**
 * spring 容器初始化完成事件
 * @author sslf
 * @datetime 2015年7月8日上午10:42:14
 */
public class SpringContextRefreshedEvent implements ApplicationListener<ContextRefreshedEvent> {

	private Log log = LogFactory.getLog(SpringContextRefreshedEvent.class);


	@Override
	public void onApplicationEvent(ContextRefreshedEvent event) {

		log.debug("spring加载完成事件开始执行");
		String path = SpringContextRefreshedEvent.class.getResource("/").getFile();

		try {
			path = java.net.URLDecoder.decode(path,"utf-8");  //转换字符编码
			log.debug("spring 成功执行完");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}  
		
		PropertiesUtil prop = new PropertiesUtil(path + "/base.properties");
		CachePool.baseProp = prop.getAllProperty();

	}


}