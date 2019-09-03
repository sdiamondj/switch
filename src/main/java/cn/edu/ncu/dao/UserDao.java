package cn.edu.ncu.dao;

import cn.edu.ncu.entity.Order;
import cn.edu.ncu.entity.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @Description TODO
 * @Author shendongjian
 * @CreateTime 2019/7/19 17:22
 */
@Mapper
@Repository
public interface UserDao {
    User login(@Param("user_phone")String user_phone, @Param("user_password")String user_password);

    Integer register(@Param("user_phone")String user_phone, @Param("user_password")String user_password,
                  @Param("user_id") String user_id);

    User selectUserByPhone(@Param("user_phone")String user_phone);

    Integer updateUserIsDoing(@Param("user_id")String user_id,@Param("isDoing")String isDoing);

}
