package cn.edu.ncu.controller;

import cn.edu.ncu.entity.Order;
import cn.edu.ncu.entity.User;
import cn.edu.ncu.service.OrderService;
import cn.edu.ncu.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import javax.servlet.http.HttpSession;
import java.util.List;


/**
 * @Description TODO
 * @Author shendongjian
 * @CreateTime 2019/7/22 13:46
 */
@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private OrderService orderService;

    @RequestMapping("/register")
    public String register(@RequestParam("user_phone")String user_phone,
                           @RequestParam("user_password")String user_password){
        int success = userService.register(user_phone,user_password);
        if(success == 0){
            return "redirect:/init/register";
        }else{
            return "redirect:/init/login";
        }
    }

    @RequestMapping("/login")
    public String login(@RequestParam("user_phone")String user_phone,
                        @RequestParam("user_password")String user_password,
                        HttpSession session){
        User user = userService.login(user_phone,user_password);
        if(user != null){
            session.setAttribute("user",user);
            return "redirect:/init/index";
        }else{
            return "redirect:/init/login";
        }
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session){
        session.removeAttribute("user");
        return "redirect:/init/login";
    }

    @RequestMapping("/order")
    public String order(HttpSession session, Model model){
        User user = (User)session.getAttribute("user");
        List<Order> list = orderService.getAllOrderByUserId(user.getUser_id());
        for(Order order : list){
            String borrow_time = order.getBorrow_time();
            String return_time = order.getReturn_time();
            if(borrow_time != null){
                order.setBorrow_time(borrow_time.substring(0,borrow_time.indexOf(" ")));
            }
            if(return_time != null){
                order.setReturn_time(return_time.substring(0,return_time.indexOf(" ")));
            }
        }
        model.addAttribute("order",list);
        return "myself";
    }
}
