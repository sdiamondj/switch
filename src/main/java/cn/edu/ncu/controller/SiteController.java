package cn.edu.ncu.controller;

import cn.edu.ncu.entity.Box;
import cn.edu.ncu.entity.Site;
import cn.edu.ncu.service.BoxService;
import cn.edu.ncu.service.SiteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

/**
 * @Description TODO
 * @Author shendongjian
 * @CreateTime 2019/7/22 14:55
 */
@Controller
@RequestMapping("/site")
public class SiteController {
    @Autowired
    private SiteService siteService;
    @Autowired
    private BoxService boxService;

    @RequestMapping(value = "/detail/{site_id}",method = RequestMethod.GET)
    public String getSiteDetail(@PathVariable("site_id")String site_id, Model model){
        Site site = siteService.getSiteBySiteId(site_id);
        if(site == null){
            return "redirect:/init/index";
        }else{
            List<Box> list = boxService.getBoxBySiteId(site_id);
            model.addAttribute("site",site);
            model.addAttribute("box",list);
            List<Box> a = boxService.getBoxBySiteIdAndBoxState(site_id,0);
            model.addAttribute("can",a.size());
            model.addAttribute("cannot",site.getBox_num()-a.size());
            return "site";
        }
    }
}
