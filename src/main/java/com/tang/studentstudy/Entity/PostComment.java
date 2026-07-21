package com.tang.studentstudy.Entity;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("post_comment")
//帖子评论表
public class PostComment {
    @TableId(type=IdType.AUTO)
    public long id;
    public long post_id;
    public long user_id;
    public long parent_id;//父评论，可以实现在评论下评论的二级评论
    public String content;
    @TableLogic
    public Integer deleted;
    @TableField(fill=FieldFill.INSERT)
    public LocalDateTime create_time;
}
