select bo.short_name 名字1,count(distinct bo.order_number) num1 from business_order bo
 join consumer_new con on (con.id=bo.consumer_id)
 join company com on (com.id=bo.company_id)
 where
  com.company_name="龙口胜通能源有限公司"
  and bo.created_at >"2018-12-10  00:00:00 " and bo.created_at <"2018-12-15  23:59:59" and bo.is_deleted=0
  group by con.consumer_name
  
  
  select bo.short_name,  count(distinct bo.order_number)业务单量  from business_order bo
join company com on (com.id=bo.company_id)
where bo.is_deleted=0 and bo.created_at >"2018-12-03  00:00:00 " and bo.created_at <"2018-12-08  23:59:59" 
and com.company_name ="龙口胜通能源有限公司";


select count(*) 外销单数 from out_sale_order oso
join company com on (com.id=oso.company_id)
where  oso.created_at >"2018-12-03  00:00:00 " and oso.created_at <"2018-12-08  23:59:59" and com.company_name="龙口胜通能源有限公司"
 and oso.is_deleted=0




select * from business_order bo
 join consumer con on (con.id=bo.consumer_id)
 join company com on (com.id=bo.company_id)
 where
  com.company_name="龙口胜通能源有限公司"
    and bo.created_at >"2018-12-03  00:00:00 " and bo.created_at <"2018-12-08  23:59:59" and bo.is_deleted=0
    
    
    select * from business_order where consumer_id='031862d03eb54a9ea313fb5f27f814a8'