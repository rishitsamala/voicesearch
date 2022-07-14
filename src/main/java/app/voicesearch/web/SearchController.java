package app.voicesearch.web;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import app.voicesearch.model.SearchForm;

@SessionAttributes(SearchController.FORM)
@Controller
public class SearchController {

	private static final Logger log = LoggerFactory.getLogger(SearchController.class);

	protected static final String FORM = "searchForm";

	@RequestMapping(value = { "/", "/login" }, method = RequestMethod.GET)
	public ModelAndView login(@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "logout", required = false) String logout, HttpServletRequest request) {
		ModelAndView model = new ModelAndView("login");
		if (error != null) {
			model.addObject("error", "Invalid username and password!");
		} else if (logout != null) {
			log.info("logging out: " + getLoginUser());
			HttpSession session = request.getSession(false);
			SecurityContextHolder.clearContext();
			session = request.getSession(false);
			if (session != null) {
				session.invalidate();
			}
			for (Cookie cookie : request.getCookies()) {
				cookie.setMaxAge(0);
			}
			model.addObject("logoutMsg", "You've been logged out successfully.");
		}
		return model;
	}

	@RequestMapping("/app")
	public ModelAndView dashboard() {
//		String username = getLoginUser();
//		log.info("Logged in user: " + username);
		return new ModelAndView("dashboard");
	}

	@RequestMapping("/app/vehicleSearch")
	public ModelAndView vehicleSearch(ModelAndView model) {
		SearchForm form = new SearchForm();
		form.setExpYear(2018);

		model.addObject(FORM, form);
		model.addObject("page", "vehicleSearch");
		model.setViewName("vehicleSearch");
		return model;
	}
	
	@RequestMapping("/app/personSearch")
	public ModelAndView personSearch(ModelAndView model) {
		SearchForm form = new SearchForm();

		model.addObject(FORM, form);
		model.addObject("page", "personSearch");
		model.setViewName("personSearch");
		return model;
	}

	@RequestMapping(value = "/app/vehicleSearch/submit", method = RequestMethod.POST)
	public ModelAndView vehicleSubmit(ModelAndView model, @ModelAttribute(FORM) @Valid SearchForm form, BindingResult result) {
		if(StringUtils.isBlank(form.getPlateNumber()) && StringUtils.isBlank(form.getVinNumber())) {
			result.addError(new ObjectError("regNumber","Registration Number cannot be empty!"));
			result.addError(new ObjectError("vinNumber","VIN Number cannot be empty!"));
			model.addObject("page", "vehicleSearch");
		} else {
			form.setHit(true);
		}
		model.addObject(FORM, form);
		model.setViewName("vehicleSearch");
		return model;
	}
	
	@RequestMapping(value = "/app/personSearch/submit", method = RequestMethod.POST)
	public ModelAndView personSubmit(ModelAndView model, @ModelAttribute(FORM) @Valid SearchForm form, BindingResult result) {
		if(StringUtils.isBlank(form.getFname()) && StringUtils.isBlank(form.getLname())) {
			result.addError(new ObjectError("fname","First Name cannot be empty!"));
			result.addError(new ObjectError("lname","Last Namecannot be empty!"));
			model.addObject("page", "personSearch");
		} else {
			form.setHit(true);
		}
		model.addObject(FORM, form);
		model.setViewName("personSearch");
		return model;
	}

	private String getLoginUser() {
		String user = "UNKNOWN";
		if ((SecurityContextHolder.getContext().getAuthentication() != null)
				&& (SecurityContextHolder.getContext().getAuthentication().getPrincipal() instanceof UserDetails)) {
			user = ((UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUsername();
			user = StringUtils.upperCase(user);
		}
		return user;
	}
}
