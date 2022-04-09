package otp.sms.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.fasterxml.jackson.databind.ObjectMapper;
import otp.sms.dto.ServerLocation;
import otp.sms.service.Requestservice;
import otp.sms.service.ServerLocationservice;


@Controller
public class MapController {

	@Autowired
	ServerLocationservice serverLocationBo;
	@Autowired
	private Requestservice requestservice;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView getPages(HttpServletRequest request) {

		ModelAndView model = new ModelAndView("map");
		return model;

	}


	@RequestMapping(value = "/getLocationByIpAddress", method = RequestMethod.GET)
	
public @ResponseBody String getDomainInJsonFormat(@RequestParam String ipAddress,HttpServletRequest request) {
		String cl = requestservice.getClientIp(request);
		ObjectMapper mapper = new ObjectMapper();

		ServerLocation location = serverLocationBo.getLocation(cl);

		String result = "";

		try {
			result = mapper.writeValueAsString(location);
		} catch (Exception e) {

			e.printStackTrace();
		}

		return result;

	}

}
