package com.tang.studentstudy.Entity;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("question_bank")
//该实体类是智能问答系统模块中的题库表
public class questionbank {
    @TableId(type=IdType.AUTO)
    public long id;
    public String bank_name;//题库名称
    public String description;//题库描述
    public long creat_user_id;//创建题库人id
    public long question_count;//题库题目总数
    @TableLogic
    public Integer deleted;//逻辑删除
    @TableField(fill=FieldFill.INSERT)
    public LocalDateTime create_time;
    @TableField(fill=FieldFill.INSERT_UPDATE)
    public LocalDateTime updata_time;
}
