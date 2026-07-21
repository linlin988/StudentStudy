package com.tang.studentstudy.Entity;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("wrong_question")
//这个实体类是错题本
public class WrongQuestion {
    @TableId(type=IdType.AUTO)
    public long id;
    public long user_id;
    public long question_id;
    public long bank_id;
    public Integer wrong_count;
    @TableField(fill=FieldFill.INSERT)
    public LocalDateTime create_time;
    @TableField(fill=FieldFill.UPDATE)
    public LocalDateTime last_wrong_time;
}
