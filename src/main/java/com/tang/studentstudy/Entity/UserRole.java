package com.tang.studentstudy.Entity;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("sys_user_role")
//这个类就是用来实现一个账户的多个角色扮演，如既是普通用户又是管理员的身份
public class UserRole {
    @TableId(type=IdType.AUTO)
    public long id;
    public long user_id;//绑定要分配权限的用户的id
    public long role_id;//绑定用户分配权限的角色
    @TableField(fill=FieldFill.INSERT)
    public LocalDateTime create_time;
}
