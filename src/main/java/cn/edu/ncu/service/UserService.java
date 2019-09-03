package cn.edu.ncu.service;

import cn.edu.ncu.dao.UserDao;
import cn.edu.ncu.entity.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.UUID;

/**
 * @Description TODO
 * @Author shendongjian
 * @CreateTime 2019/7/22 13:48
 */
@Service
public class UserService {

    @Autowired
    private UserDao userDao;

    public User login(@Param("user_phone")String user_phone,
                      @Param("user_password")String user_password){
        return userDao.login(user_phone,user_password);
    }

    public Integer register(@Param("user_phone")String user_phone,
                         @Param("user_password")String user_password){
        if(userDao.selectUserByPhone(user_phone) != null){
            return null;
        }
        String user_id = UUID.randomUUID().toString().replaceAll("-","");
        return userDao.register(user_phone,user_password,user_id);
    }

    public Integer updateUserIsDoing(@Param("user_id")String user_id,
                               @Param("isDoing")String isDoing){
        return userDao.updateUserIsDoing(user_id,isDoing);
    }
}
