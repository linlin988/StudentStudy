package com.tang.studentstudy.Entity;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("practice_question_detail")
//该表是记录用户练习时每道题作答的详情
public class PracticeQuestionDetail {
    @TableId(type=IdType.AUTO)
    public long id;
    public long record_id;
    public long question_id;
    public String user_answer;
    public Integer is_correct;//1是正确，0是错误
    @TableField(fill=FieldFill.INSERT)
    public LocalDateTime create_time;
}
