package cn.edu.ncu.entity;

import lombok.Data;

/**
 * @Description 换电箱类
 * @Author shendongjian
 * @CreateTime 2019/7/19 17:35
 */
@Data
public class Box {
    /**
     * 换电箱id
     */
    private String box_id;
    /**
     * 换电箱状态0-可出租 1-已出租 2-充电中 3-故障
     */
    private int box_state;
    /**
     * 换电箱编号
     */
    private int box_number;
    /**
     * 换电箱所属站点id
     */
    private String site_id;
}
