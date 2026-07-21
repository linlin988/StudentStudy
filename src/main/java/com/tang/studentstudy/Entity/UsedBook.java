package com.tang.studentstudy.Entity;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Data
@TableName("usedbook")
//该实体类是二手书商品
public class UsedBook {
    @TableId(type=IdType.AUTO)
    public long id;
    public long seller_id;
    public String book_name;
    public String categroy;//按学科的书籍分类
    public String grade;//适用年级
    public Integer quantity;//库存数量
    public BigDecimal price;
    public String description;
    public String images;//商品图片
    public Integer status;//上架状态，1表示上架了，0表示还没上架
    @TableField(fill=FieldFill.INSERT)
    public LocalDateTime create_time;
    @TableField(fill=FieldFill.INSERT_UPDATE)
    public LocalDateTime updata_time;
    @TableLogic
    public Integer deleted;
}
