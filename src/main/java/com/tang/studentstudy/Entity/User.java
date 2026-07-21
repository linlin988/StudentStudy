package com.tang.studentstudy.Entity;
import java.time.LocalDateTime;
import lombok.Data;
import com.baomidou.mybatisplus.annotation.*;
@Data
@TableName("sys_user")
public class User {
    @TableId(type=IdType.AUTO)
    public long id;
    public String username;
    public String password;
    public String phone;
    public String gender;
    public int age;
    public String avater;//头像
    public int avater_status;//头像状态0和1
    public String qq;
    public String wechat;
    public Integer status;//管理用户账号能否使用的状态（0是封禁，1是可用）
    @TableLogic
    private Integer deleted;//逻辑删除，deleted=1时逻辑删除
    @TableField(fill=FieldFill.INSERT_UPDATE)
    public LocalDateTime update_time;//update_time这样的属性是在创建和更新时都要改的，所以用的是INSERT_UPDATE
    @TableField(fill=FieldFill.INSERT)
    public LocalDateTime create_time;//create_time是在创建的时候改的，所以用的是INSERT

}
