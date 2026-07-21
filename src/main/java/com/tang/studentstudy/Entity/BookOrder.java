package com.tang.studentstudy.Entity;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@TableName("book_order")
//订单的实体类，用来存储二手书交易信息的
public class BookOrder {
    @TableId(type=IdType.AUTO)
    public long id;
    public String order_no;//订单编号
    public long buyer_id;
    public long seller_id;
    public long book_id;
    public Integer quantity;
    public BigDecimal total_price;
    public Integer order_status;//为1时表示订单成功完成，为0表示没有完成
    @TableField(fill=FieldFill.INSERT)
    public LocalDateTime creat_time;
    @TableField(fill=FieldFill.INSERT_UPDATE)
    public LocalDateTime confirm_time;
}
