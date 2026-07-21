package com.tang.studentstudy.Entity;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("post_like")
//帖子点赞表
public class PostLike {
    @TableId(type=IdType.AUTO)
    public long id;
    public long post_id;
    public long user_id;
    @TableField(fill=FieldFill.INSERT)
    public LocalDateTime create_time;
}
