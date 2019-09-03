package cn.edu.ncu.controller;

import cn.edu.ncu.entity.Site;
import cn.edu.ncu.service.SiteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

/**
 * @Description TODO
 * @Author shendongjian
 * @CreateTime 2019/7/8 11:27
 */
@Controller
@RequestMapping("/init")
public class InitController {
    @Autowired
    private SiteService siteService;

    @RequestMapping("/index")
    public String index(Model model){
        List<Site> list = siteService.getAllSite();
        model.addAttribute("site",list);
        return "index";
    }

    @RequestMapping("/login")
    public String login(){
        return "login";
    }

    @RequestMapping("/register")
    public String register(){
        return "register";
    }
}
