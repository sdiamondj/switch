package cn.edu.ncu.entity;

import lombok.Data;

/**
 * @Description 订单实体类
 * @Author shendongjian
 * @CreateTime 2019/7/19 17:17
 */
@Data
public class Order {
    /**
     * 订单id
     */
    private String order_id;
    /**
     * 用户id
     */
    private String user_id;
    /**
     * 电池id
     */
    private String battery_id;
    /**
     * 订单状态 0-创建 1-已借用 2-已归还
     */
    private int order_state;
    /**
     * 电池借出时间
     */
    private String borrow_time;
    /**
     * 电池归还时间
     */
    private String return_time;
    /**
     * 支付金额
     */
    private Integer order_price;
}
