package cn.edu.ncu.dao;

import cn.edu.ncu.entity.Battery;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @Description TODO
 * @Author shendongjian
 * @CreateTime 2019/7/29 11:08
 */
@Repository
@Mapper
public interface BatteryDao {
    List<Battery> getAllBattery();

    Integer insertBattery(@Param("battery_id")String battery_id,@Param("box_id")String box_id);

    Battery getBatteryByBoxId(@Param("box_id")String box_id);

    Integer updateBoxId(@Param("battery_id")String battery_id,
                        String box_id);

    Battery getBatteryByBatteryId(@Param("battery_id")String battery_id);
}
