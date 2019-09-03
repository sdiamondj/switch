package cn.edu.ncu.service;

import cn.edu.ncu.dao.BoxDao;
import cn.edu.ncu.entity.Box;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Description TODO
 * @Author shendongjian
 * @CreateTime 2019/7/22 17:06
 */
@Service
public class BoxService {
    @Autowired
    private BoxDao boxDao;

    public List<Box> getBoxBySiteIdAndBoxState(@Param("site_id")String site_id,@Param("box_state")int box_state){
        return boxDao.getBoxBySiteIdAndBoxState(site_id, box_state);
    }

    public Integer insertBox(@Param("box_id")String box_id,@Param("site_id")String site_id,@Param("box_number")int box_number){
        return boxDao.insertBox(box_id,site_id,box_number);
    }

    public List<Box> getBoxBySiteId(@Param("site_id")String site_id){
        return boxDao.getBoxBySiteId(site_id);
    }

    public Box getBoxByBoxId(@Param("box_id")String box_id){
        return  boxDao.getBoxByBoxId(box_id);
    }

    public Integer updateBoxState(@Param("box_id")String box_id,@Param("box_state")int box_state){
        return boxDao.updateBoxState(box_id,box_state);
    }
}
