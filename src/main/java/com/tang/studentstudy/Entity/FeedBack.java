package com.tang.studentstudy.Entity;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("feedback")
//公共信箱，意见反馈实体类
public class FeedBack {
    @TableId(type=IdType.AUTO)
    public long id;
    public long user_id;
    public String content;
    public String reply_content;
    public Integer status;//处理状态，0表示未处理，1表示已处理
    @TableField(fill=FieldFill.INSERT)
    public LocalDateTime create_time;
    @TableField(fill=FieldFill.INSERT_UPDATE)
    public LocalDateTime reply_time;
}
