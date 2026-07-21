package com.tang.studentstudy.Entity;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@TableName("practice_record")
//该实体类对应的是作答记录的表
public class PracticeRecord {
    @TableId(type=IdType.AUTO)
    public long id;
    public long user_id;
    public long bank_id;//题库id
    public Integer total_count;
    public Integer correct_count;
    @TableField("accuacy")
    public BigDecimal accuracy;//正确率
    @TableField(fill=FieldFill.INSERT)
    public LocalDateTime create_time;
    @TableField(fill=FieldFill.INSERT_UPDATE)
    public LocalDateTime start_time;
    @TableField(fill=FieldFill.DEFAULT)
    public LocalDateTime end_time;
}
