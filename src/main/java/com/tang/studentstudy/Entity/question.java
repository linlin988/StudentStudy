package com.tang.studentstudy.Entity;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("question")
//这个实体类是题库中的问题
public class question {
    @TableId(type=IdType.AUTO)
    public long id;
    public long bank_id;//该题目所属的题库的id
    public Integer question_type;//题目类型：单选，多选，判断....
    public String question_content;//题目内容
    public String option;//选项内容
    public String conrrect_answer;//正确答案
    public String analysis;//答案分析
    @TableField(fill=FieldFill.INSERT)
    public LocalDateTime create_time;
    @TableField(fill=FieldFill.INSERT_UPDATE)
    public LocalDateTime update_time;
    @TableLogic
    public Integer deleted;
}
