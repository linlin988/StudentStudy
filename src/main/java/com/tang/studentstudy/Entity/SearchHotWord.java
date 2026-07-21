package com.tang.studentstudy.Entity;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("search_hotword")
//搜索栏的实体类
public class SearchHotWord {
    @TableId(type=IdType.AUTO)
    public long id;
    public String keyword;
    public Integer search_type;//搜索的类型：帖子、用户、二手书
    public Integer search_count;//搜索数量
    public LocalDateTime stat_date;//统计日期
}
