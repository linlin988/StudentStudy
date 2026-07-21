package com.tang.studentstudy.Entity;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("private_message")
//私人信箱实体类
public class PrivateMessage {
    @TableId(type=IdType.AUTO)
    public long id;
    public long sender_id;
    public long receiver_id;
    public String content;
    public Integer is_read;//0表示未读，1表示已读
    @TableField(fill=FieldFill.INSERT_UPDATE)
    public LocalDateTime send_time;
    @TableLogic
    public Integer deleted;
}
