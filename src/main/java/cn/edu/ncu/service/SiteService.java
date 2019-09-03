package cn.edu.ncu.service;

import cn.edu.ncu.dao.SiteDao;
import cn.edu.ncu.entity.Site;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Description TODO
 * @Author shendongjian
 * @CreateTime 2019/7/9 19:37
 */
@Service
public class SiteService {
    @Autowired
    private SiteDao siteDao;

    public List<Site> getAllSite(){
        return siteDao.getAllSite();
    }

    public Site getSiteBySiteId(@Param("site_id")String site_id){
        return siteDao.getSiteBySiteId(site_id);
    }
}
