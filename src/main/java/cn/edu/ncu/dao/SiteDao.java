package cn.edu.ncu.dao;

import cn.edu.ncu.entity.Site;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @Description TODO
 * @Author shendongjian
 * @CreateTime 2019/7/9 19:36
 */
@Mapper
@Repository
public interface SiteDao {
    List<Site> getAllSite();

    Site getSiteBySiteId(@Param("site_id")String site_id);
}
