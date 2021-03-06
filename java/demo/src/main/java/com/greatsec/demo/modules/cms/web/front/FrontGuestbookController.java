
package com.greatsec.demo.modules.cms.web.front;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.greatsec.demo.common.config.Global;
import com.greatsec.demo.common.persistence.Page;
import com.greatsec.demo.common.servlet.ValidateCodeServlet;
import com.greatsec.demo.common.web.BaseController;
import com.greatsec.demo.modules.cms.entity.Guestbook;
import com.greatsec.demo.modules.cms.entity.Site;
import com.greatsec.demo.modules.cms.service.GuestbookService;
import com.greatsec.demo.modules.cms.utils.CmsUtils;

/**
 * 留言板Controller
 * @author bmwm.cn
 * @version 2013-3-15
 */
@Controller
@RequestMapping(value = "${frontPath}")
public class FrontGuestbookController extends BaseController{
	
	@Autowired
	private GuestbookService guestbookService;

	/**
	 * 留言板
	 */
	@RequestMapping(value = "guestbook", method=RequestMethod.GET)
	public String guestbook(@RequestParam(required=false, defaultValue="1") Integer pageNo,
			@RequestParam(required=false, defaultValue="30") Integer pageSize, Model model) {
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
		Page<Guestbook> page = new Page<Guestbook>(pageNo, pageSize);
		Guestbook guestbook = new Guestbook();
		guestbook.setDelFlag(Guestbook.DEL_FLAG_NORMAL);
		page = guestbookService.find(page, guestbook);
		model.addAttribute("page", page);
		return "modules/cms/front/themes/"+site.getTheme()+"/frontGuestbook";
	}
	
	/**
	 * 留言板-保存留言信息
	 */
	@RequestMapping(value = "guestbook", method=RequestMethod.POST)
	public String guestbookSave(Guestbook guestbook, String validateCode, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		if (StringUtils.isNotBlank(validateCode)){
			if (ValidateCodeServlet.validate(request, validateCode)){
				guestbook.setIp(request.getRemoteAddr());
				guestbook.setCreateDate(new Date());
				guestbook.setDelFlag(Guestbook.DEL_FLAG_AUDIT);
				guestbookService.save(guestbook);
				addMessage(redirectAttributes, "提交成功，请等待管理员审核。");
			}else{
				addMessage(redirectAttributes, "验证码不正确。");
			}
		}else{
			addMessage(redirectAttributes, "验证码不能为空。");
		}
		return "redirect:"+Global.getFrontPath()+"/guestbook";
	}
	
}
