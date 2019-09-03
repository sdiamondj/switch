package cn.edu.ncu.dao;

import cn.edu.ncu.entity.Order;
import com.sun.org.apache.xpath.internal.operations.Or;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

/**
 * @Description TODO
 * @Author shendongjian
 * @CreateTime 2019/7/19 17:23
 */
@Mapper
@Repository
public interface OrderDao {

    List<Order> getAllOrderByUserId(@Param("user_id")String user_id);

    Integer createOrder(@Param("user_id")String user_id,
                        @Param("order_id")String order_id,
                        @Param("battery_id")String battery_id);

    List<Order> getOrderByUserIdAndState(@Param("user_id")String user_id,
                                         @Param("order_state")int order_state);

    Integer finishOrder(@Param("order_id")String order_id,
                        @Param("order_state")int order_state,
                        @Param("order_price")int order_price);

    Order getOrderByUserIdAndStateAndBatteryId(@Param("user_id")String user_id,
                                               @Param("order_state")int order_state,
                                               @Param("battery_id")String battery_id);
}
