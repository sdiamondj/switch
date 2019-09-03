package cn.edu.ncu.vo;

import lombok.Data;

/**
 * @Description TODO
 * @Author shendongjian
 * @CreateTime 2019/8/28 9:59
 */
@Data
public class ReturnBatteryVO {
    /**
     * 电池id
     */
    private String battery_id;
    /**
     * 电池借出时间
     */
    private String borrow_time;
    /**
     * 电池归还时间
     */
    private String return_time;
    /**
     *
     */
    private String box_id;

    private long borrow_day;
}
