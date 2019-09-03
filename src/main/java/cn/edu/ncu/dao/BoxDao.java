package cn.edu.ncu.dao;


import cn.edu.ncu.entity.Box;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @Description TODO
 * @Author shendongjian
 * @CreateTime 2019/7/22 17:05
 */
@Repository
@Mapper
public interface BoxDao {
    List<Box> getBoxBySiteId(@Param("site_id")String site_id);

    Box getBoxByBoxId(@Param("box_id")String box_id);

    List<Box> getBoxBySiteIdAndBoxState(@Param("site_id")String site_id,@Param("box_state")int box_state);

    Integer insertBox(@Param("box_id")String box_id,@Param("site_id")String site_id,@Param("box_number")int box_number);

    Integer updateBoxState(@Param("box_id")String box_id,@Param("box_state")int box_state);
}
