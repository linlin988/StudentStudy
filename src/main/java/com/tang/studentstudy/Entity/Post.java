package com.tang.studentstudy.Entity;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("post")
//社区帖子实体类
public class Post {
    @TableId(type=IdType.AUTO)
    public long id;
    public long user_id;
    public String title;
    public String content;
    public String images;
    public Integer like_count;
    public Integer comment_count;
    public Integer status;//1表示帖子正常状态，0表示帖子被管理员下架了
    @TableField(fill=FieldFill.INSERT)
    public LocalDateTime crate_time;
    @TableField(fill=FieldFill.INSERT_UPDATE)
    public LocalDateTime updata_time;
    @TableLogic
    public Integer deleted;
}
