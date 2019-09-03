package cn.edu.ncu.entity;

import lombok.Data;

/**
 * @Description 电池实体类
 * @Author shendongjian
 * @CreateTime 2019/7/29 11:06
 */
@Data
public class Battery {
    /**
     * 电池id
     */
    private String battery_id;
    /**
     * 电池状态 0-可用 1-不可用
     */
    private int battery_state;
    /**
     *
     */
    private String box_id;
}
