package com;

import cn.edu.ncu.entity.Site;
import cn.edu.ncu.service.BatteryService;
import cn.edu.ncu.service.BoxService;
import cn.edu.ncu.service.SiteService;
import lombok.AllArgsConstructor;
import lombok.Data;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * @Description TODO
 * @Author shendongjian
 * @CreateTime 2019/9/2 14:27
 */
public class MyTest extends SwitchApplicationTests {

    @Resource
    private BoxService boxService;
    @Resource
    private BatteryService batteryService;

    @Test
    public void go(){
        List<MySite> list = new ArrayList<>();
//        list.add(new MySite("2fb294bb2258ffd5bd7ecdad39851383",80));
//        list.add(new MySite("ad6e0e8993bd7462d5860e0faf07e7a4",100));
//        list.add(new MySite("9b88728bf76143c7b984ed9de3ef2429",50));
//        list.add(new MySite("90bd00e227174eb4a447630e7222668f",50));
//        list.add(new MySite("c9e446cee2684bcaba11a85d623e99ad",40));
//        list.add(new MySite("b5c42b2aa3b44b80b5d2067343a7db8b",100));
//        list.add(new MySite("bc00ccb9a7a5448ba1baefdadf037ebd",60));
//        list.add(new MySite("1590a939a2b243b6b1e6957eff0e7319",50));
//        list.add(new MySite("f820320a4dd34187b715189178eb38f6",100));
        for(MySite mySite:list){
            for(int i = 1; i <= mySite.site_num; i++){
                String box_id = getUUID();
                boxService.insertBox(box_id,mySite.site_id,i);
                String battery_id = getUUID();
                batteryService.insertBattery(battery_id,box_id);
            }
        }
    }

    private String getUUID(){
        return UUID.randomUUID().toString().replaceAll("-","");
    }
}

@Data
@AllArgsConstructor
class MySite{
    String site_id;
    int site_num;
}
