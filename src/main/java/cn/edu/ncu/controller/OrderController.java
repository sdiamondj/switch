package cn.edu.ncu.controller;

import cn.edu.ncu.vo.ReturnBatteryVO;
import cn.edu.ncu.entity.Battery;
import cn.edu.ncu.entity.Box;
import cn.edu.ncu.entity.Order;
import cn.edu.ncu.entity.User;
import cn.edu.ncu.service.BatteryService;
import cn.edu.ncu.service.BoxService;
import cn.edu.ncu.service.OrderService;
import cn.edu.ncu.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


/**
 * @Description TODO
 * @Author shendongjian
 * @CreateTime 2019/7/22 19:35
 */
@Controller
@RequestMapping("/order")
public class OrderController {
    @Autowired
    private OrderService orderService;
    @Autowired
    private BoxService boxService;
    @Autowired
    private UserService userService;
    @Autowired
    private BatteryService batteryService;


    @RequestMapping(value = "/borrow/{box_id}")
    public String borrow(@PathVariable("box_id")String box_id,
                         Model model){
        Box box = boxService.getBoxByBoxId(box_id);
        if(box.getBox_state()!= 0){
            String site_id = box.getSite_id();
            return "redirect:/site/detail/"+site_id;
        }else{
            Battery battery = batteryService.getBatteryByBoxId(box_id);
            model.addAttribute("box",box);
            model.addAttribute("battery",battery);
            return "confirmBorrow";
        }
    }

    @RequestMapping(value = "/return/{box_id}")
    public String returnI(@PathVariable("box_id")String box_id,
                          Model model,
                          HttpSession session) throws Exception{
        Box box = boxService.getBoxByBoxId(box_id);
        if(box.getBox_state()!= 1){
            String site_id = box.getSite_id();
            return "redirect:/site/detail/"+site_id;
        }else{
            User user = (User)session.getAttribute("user");
            model.addAttribute("box",box);
            List<Order> orders = orderService.getOrderByUserIdAndState(user.getUser_id(),1);
            List<Battery> batteries = new ArrayList<>();
            for(Order order : orders){
                batteries.add(batteryService.getBatteryByBatteryId(order.getBattery_id()));
            }
            List<ReturnBatteryVO> returnBatteryVOS = new ArrayList<>();
            for(int i = 0; i < orders.size(); i++){
                ReturnBatteryVO returnBatteryVO = new ReturnBatteryVO();
                returnBatteryVO.setBattery_id(batteries.get(i).getBattery_id());
                returnBatteryVO.setBox_id(box_id);
                returnBatteryVO.setBorrow_time(orders.get(i).getBorrow_time());
                DateFormat dateFormat = DateFormat.getDateInstance();
                returnBatteryVO.setReturn_time(dateFormat.format(new Date()));
                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
                Date date1 = simpleDateFormat.parse(returnBatteryVO.getBorrow_time());
                Date date2 = simpleDateFormat.parse(returnBatteryVO.getReturn_time());
                long daysBetween=(date2.getTime()-date1.getTime()+1000000)/(60*60*24*1000)+1;
                returnBatteryVO.setBorrow_day(daysBetween);
                returnBatteryVOS.add(returnBatteryVO);
            }
            model.addAttribute("returnBatteryVOS",returnBatteryVOS);
            return "chooseReturn";
        }
    }

    @RequestMapping("/confirmReturn")
    @Transactional
    public String confirmReturn(@RequestParam("box_id")String box_id,
                                @RequestParam("battery_id")String battery_id,
                                @RequestParam("order_price")int order_price,
                                HttpSession session){
        Integer a = boxService.updateBoxState(box_id,0);
        Integer b = batteryService.updateBoxId(battery_id,box_id);
        User user = (User)session.getAttribute("user");
        String order_id = orderService.getOrderByUserIdAndStateAndBatteryId(user.getUser_id(),1,battery_id).getOrder_id();
        Integer c = orderService.finishOrder(order_id,2,order_price);
        if(a == 0 || b == 0 || c == 0){
            Box box = boxService.getBoxByBoxId(box_id);
            return "redirect:/site/detail/"+box.getSite_id();
        }else{
            List<Order> list = orderService.getOrderByUserIdAndState(user.getUser_id(),1);
            if(list == null || list.size() < 1){
                userService.updateUserIsDoing(user.getUser_id(),"0");
                user.setIsDoing("0");
            }
            return "redirect:/user/order";
        }
    }

    @RequestMapping("/createNewOrder")
    public String createNewOrder(@RequestParam("battery_id")String battery_id,
                                 HttpSession session,
                                 @RequestParam("site_id")String site_id,
                                 @RequestParam("box_id")String box_id){
        User user = (User)session.getAttribute("user");
        if(orderService.createOrder(user.getUser_id(),battery_id) > 0){
            userService.updateUserIsDoing(user.getUser_id(),"1");
            batteryService.updateBoxId(battery_id,null);
            boxService.updateBoxState(box_id,1);
            user.setIsDoing("1");
            return "redirect:/user/order";
        }else{
            return "redirect:/site/detail/"+site_id;
        }
    }

}
