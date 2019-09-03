package cn.edu.ncu.entity;

import lombok.Data;

/**
 * @Description 用户实体类
 * @Author shendongjian
 * @CreateTime 2019/7/19 17:12
 */
@Data
public class User {
    /**
     * 用户id
     */
    private String user_id;
    /**
     * 用户手机号
     */
    private String user_phone;
    /**
     * 用户密码
     */
    private String user_password;
    /**
     * 是否有进行中的订单 0-否 1-是  默认 0
     */
    private String isDoing;
}
