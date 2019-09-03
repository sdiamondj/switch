package cn.edu.ncu.service;

import cn.edu.ncu.dao.OrderDao;
import cn.edu.ncu.entity.Order;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

/**
 * @Description TODO
 * @Author shendongjian
 * @CreateTime 2019/7/22 19:18
 */
@Service
public class OrderService {
    @Autowired
    private OrderDao orderDao;

    public List<Order> getAllOrderByUserId(@Param("user_id")String user_id){
        return orderDao.getAllOrderByUserId(user_id);
    }

    public int createOrder(@Param("user_id")String user_id,
                           @Param("battery_id")String battery_id){
            return orderDao.createOrder(user_id,UUID.randomUUID().toString().replaceAll("-",""),
                    battery_id);
    }

    public List<Order> getOrderByUserIdAndState(@Param("user_id")String user_id,
                                                @Param("order_state")int order_state){
        return orderDao.getOrderByUserIdAndState(user_id,order_state);
    }

    public Integer finishOrder(@Param("order_id")String order_id,
                               @Param("order_state")int order_state,
                               @Param("order_price")int order_price){
        return orderDao.finishOrder(order_id,order_state,order_price);
    }

    public Order getOrderByUserIdAndStateAndBatteryId(@Param("user_id")String user_id,
                                                      @Param("order_state")int order_state,
                                                      @Param("battery_id")String battery_id){
        return orderDao.getOrderByUserIdAndStateAndBatteryId(user_id, order_state, battery_id);
    }

}
