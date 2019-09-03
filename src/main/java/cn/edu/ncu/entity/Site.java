package cn.edu.ncu.entity;

import lombok.Data;

/**
 * @Description 换电站实体类
 * @Author shendongjian
 * @CreateTime 2019/7/9 17:43
 */
@Data
public class Site {
    /**
     * 换点站id
     */
    private String site_id;
    /**
     * 换电站名称
     */
    private String site_name;
    /**
     * 经度
     */
    private float site_x;
    /**
     * 纬度
     */
    private float site_y;
    /**
     * 换电箱数量
     */
    private int box_num;
}
