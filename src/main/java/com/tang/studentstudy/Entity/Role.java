package com.tang.studentstudy.Entity;
import lombok.Data;
import com.baomidou.mybatisplus.annotation.*;

import java.time.LocalDateTime;

@Data
@TableName("sys_role")
//这个实体类对应的是用户权限管理(三层权限：超级管理员，管理员，普通用户)
public class Role {
    @TableId(type = IdType.AUTO)
    public long id;
    public String role_name;//用户角色名：超级管理员、管理员、普通用户
    public String role_code;//角色状态码，权限校验的标准，0是超级管理员，1是管理员，2是普通用户
    public String description;//角色权限范围描述
    @TableField(fill=FieldFill.INSERT)
    public LocalDateTime create_time;

}
