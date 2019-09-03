package cn.edu.ncu.service;

import cn.edu.ncu.dao.BatteryDao;
import cn.edu.ncu.entity.Battery;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Description TODO
 * @Author shendongjian
 * @CreateTime 2019/7/29 11:10
 */
@Service
public class BatteryService {
    @Autowired
    private BatteryDao batteryDao;

    public Integer insertBattery(@Param("battery_id")String battery_id,@Param("box_id")String box_id){
        return batteryDao.insertBattery(battery_id, box_id);
    }

    public Battery getBatteryByBatteryId(@Param("battery_id")String battery_id){
        return batteryDao.getBatteryByBatteryId(battery_id);
    }

    public Battery getBatteryByBoxId(@Param("box_id")String box_id){
        return batteryDao.getBatteryByBoxId(box_id);
    }

    public Integer updateBoxId(@Param("battery_id")String battery_id,
                               String box_id){
        return batteryDao.updateBoxId(battery_id,box_id);
    }
}
