package com.tang.studentstudy.Entity;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("ai_konwledge_base")
//ai智能问答助手的知识库
public class AiKonwledgeBase {
    @TableId(type=IdType.AUTO)
    public long id;
    public String doc_title;
    public String content_chunk;//文本切片内容，RAG检索的关键字段
    public String embedding;//预留字段，存储文本的向量值，用来更高级的向量相似度检索
    @TableField(fill=FieldFill.INSERT)
    public LocalDateTime create_time;
    @TableField(fill=FieldFill.INSERT_UPDATE)
    public LocalDateTime updata_time;
    @TableLogic
    public Integer deleted;
}
