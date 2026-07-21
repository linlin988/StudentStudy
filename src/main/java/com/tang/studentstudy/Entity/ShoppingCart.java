package com.tang.studentstudy.Entity;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("shopping_cart")
//购物车实体类
public class ShoppingCart {
    @TableId(type=IdType.AUTO)
    public long id;
    public long user_id;
    public long book_id;
    public Integer quantity;
    @TableField(fill=FieldFill.INSERT)
    public LocalDateTime create_time;
}
