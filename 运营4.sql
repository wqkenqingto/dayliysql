#基础业务概览(业务单、采购单、运单筛选维度均为BPM下的平台运单)
	select  delivery.采购单量,  boo.业务单量,waybbb.运单数,obw.外采单数,osr.外销单数,boo.周活跃客户数,conn.客户总数  from
	(
	#外销
select count(distinct bo.order_number)业务单量,count(distinct bo.consumer_id) 周活跃客户数  from business_order bo
join company com on (com.id=bo.company_id)
where bo.is_deleted=0 and bo.created_at >"2018-12-03  00:00:00 " and bo.created_at <"2018-12-08  23:59:59"
and com.company_name ="龙口胜通能源有限公司"
)as boo,
(
select count(distinct consumer.id) 客户总数 from consumer
join business_order bo on (bo.consumer_id=consumer.id)
join company com on (com.id=bo.company_id)
where
 consumer.created_at <"2018-12-08 23:59:59" and com.company_name ="龙口胜通能源有限公司"
)	as conn,
(
select count(*) 外销单数 from out_sale_order oso
join company com on (com.id=oso.company_id)
where  oso.created_at >"2018-12-03  00:00:00 " and oso.created_at <"2018-12-08  23:59:59"
 )	as osr,
 (
 select count(*)运单数 from waybill  wb
 join section_trip st on(st.waybill_id=wb.id)
 join business_order bo on(bo.id=st.business_order_id)
 join company com on (com.id=bo.company_id)
 where wb.start_time>="2018-12-03  00:00:00"  and wb.start_time <="2018-12-08 23:59:59"  and wb.is_deleted=0 and com.company_name="龙口胜通能源有限公司"
 )as waybbb,
 (
 select count(*) 采购单量 from waybill wb
 	left join delivery_order dorder on (wb.delivery_order_id=dorder.id)
 	left join delivery_order_carriers doc on(dorder.id=doc.`deliveryorder_id`)
 	left join cooperative_carrier cc on (cc.id=doc.cooperativecarrier_id)
 	left join company com on (com.id=dorder.trader_id)
 	left join section_trip st on (st.waybill_id=wb.id)
 	left join business_order bo on(bo.id=st.business_order_id)
 	where
 	st.created_at >"2018-12-03  00:00:00 " and st.created_at <"2018-12-08  23:59:59"
 	and st.section_type="pickup"  and com.company_name="龙口胜通能源有限公司"

 )as delivery,
 (
 select count(*) 外采单数 from out_buy_waybill obw
 join company com on(com.id=obw.company_id)
 where start_time >"2018-12-03  00:00:00 " and start_time <"2018-12-08  23:59:59"
 )as obw;
 
 ##采购量,业务量,外采量
 select dordern.采购量,boo.业务量,obw.外采量,oso.外销量 from
 (
select sum(active_tonnage)采购量  from waybill wb
	left join delivery_order dorder on (wb.delivery_order_id=dorder.id)
	left join delivery_order_carriers doc on(dorder.id=doc.`deliveryorder_id`)
	left join cooperative_carrier cc on (cc.id=doc.cooperativecarrier_id)
	left join company com on (com.id=dorder.trader_id)
	left join section_trip st on (st.waybill_id=wb.id)
	left join business_order bo on(bo.id=st.business_order_id)
	where
	 com.company_name="龙口胜通能源有限公司"
	  and work_end_time >"2018-12-03  00:00:00 " and work_end_time <"2018-12-08  23:59:59"
	 and st.section_type="pickup"

 )as dordern,
 (
 select sum(actual_quantity)业务量 from business_order
where created_at >"2018-12-03  00:00:00 " and created_at <"2018-12-08  23:59:59"

) as boo,
(
select sum(actual_quantity)外采量 from out_buy_waybill
where start_time >"2018-12-03  00:00:00 " and start_time <"2018-12-08  23:59:59"
)as obw,
(
select sum(actual_quantity) 外销量 from out_sale_order
where created_at >"2018-12-03  00:00:00 " and created_at <"2018-12-08  23:59:59"
)as oso




##采购量,业务量,外采量
 select dordern.采购量,boo.业务量,obw.外采量,oso.外销量 from
 (
select sum(active_tonnage)采购量  from waybill wb
	left join delivery_order dorder on (wb.delivery_order_id=dorder.id)
	left join delivery_order_carriers doc on(dorder.id=doc.`deliveryorder_id`)
	left join cooperative_carrier cc on (cc.id=doc.cooperativecarrier_id)
	left join company com on (com.id=dorder.trader_id)
	left join section_trip st on (st.waybill_id=wb.id)
	left join business_order bo on(bo.id=st.business_order_id)
	where
	 com.company_name="龙口胜通能源有限公司"
	  and work_end_time >"2018-12-10  00:00:00 " and work_end_time <"2018-12-15  23:59:59"
	 and st.section_type="pickup"

 )as dordern,
 (
 select sum(actual_quantity)业务量 from business_order
where created_at >"2018-12-10  00:00:00 " and created_at <"2018-12-15  23:59:59"

) as boo,
(
select sum(actual_quantity)外采量 from out_buy_waybill
where 
start_time >"2018-12-10  00:00:00 " and start_time <"2018-12-15  23:59:59"
)as obw,
(
select sum(actual_quantity) 外销量 from out_sale_order
where created_at >"2018-12-10  00:00:00 " and created_at <"2018-12-15  23:59:59"
)as oso;




#2.客户价值维度下的对比分析：以客户为维度
#客户-业务量分析
select res1.名字1,res1.num1,res2.num2 from (
select bo.consumer_name 名字1,count(distinct order_number) num1 from business_order bo
join consumer con on (con.id=bo.consumer_id)
join company com on (com.id=bo.company_id)
where
 com.company_name="龙口胜通能源有限公司"
 and bo.created_at >"2018-12-10  00:00:00 " and bo.created_at <"2018-12-15  23:59:59"
group by consumer_id
 )  res1
 JOIN 
 (
select bo.consumer_name 名字1,count(distinct order_number) num2 from business_order bo
join consumer con on (con.id=bo.consumer_id)
join company com on (com.id=bo.company_id)
where
 com.company_name="龙口胜通能源有限公司"
 and bo.created_at >"2018-12-10  00:00:00 " and bo.created_at <"2018-12-15  23:59:59"
group by consumer_id
) 
res2
on res1.名字1=res2.名字1



#2.客户价值维度下的对比分析：以客户为维度
 #客户-业务量分析
 select res1.名字1,res1.num1,res2.num2 from (
 select bo.consumer_name 名字1,count(distinct order_number) num1 from business_order bo
 join consumer con on (con.id=bo.consumer_id)
 join company com on (com.id=bo.company_id)
 where
  com.company_name="龙口胜通能源有限公司"
  and bo.created_at >"2018-12-10  00:00:00 " and bo.created_at <"2018-12-15  23:59:59"
 group by consumer_id
  )  res1
  JOIN
  (
 select bo.consumer_name 名字1,count(distinct order_number) num2 from business_order bo
 join consumer con on (con.id=bo.consumer_id)
 join company com on (com.id=bo.company_id)
 where
  com.company_name="龙口胜通能源有限公司"
  and bo.created_at >"2018-12-03  00:00:00 " and bo.created_at <"2018-12-08  23:59:59"
 group by consumer_id
 )
 res2
 on res1.名字1=res2.名字1
 
 
 select carrier,sum(freight_value) from income_statistic iss
 join company com on (com.id=iss.company_id)
where
 com.company_name="龙口胜通能源有限公司" 
 and 
 iss.work_end_time >"2018-12-10  00:00:00 " and iss.work_end_time <"2018-12-15  23:59:59"
 group by carrier
 
 
 
 
 #4.业务类别情况占比
 	select  border.销售单量 ,outorder.外销单量,(border.销售单量+outorder.外销单量) as 总单量,outorder.外销单量/(border.销售单量+outorder.外销单量) 外销占比 from
 	#销售单量
 	(
 	select  count(*)销售单量 from business_order
 	where status ="finished"
 	) as border,
 	#外销单
 	(
 	select count(*) 外销单量 from out_sale_order where status="finished"
 	) as outorder


  #4.业务类别情况占比
      	select  border.销售单量 ,outorder.外销单量,(border.销售单量+outorder.外销单量) as 总单量,outorder.外销单量/(border.销售单量+outorder.外销单量) 外销占比 from
      	#销售单量
      	(
      	select  count(*)销售单量 from business_order bo
      	join company com on (com.id=bo.company_id)
      	where status ="finished"
      	and
      	 com.company_name="龙口胜通能源有限公司" 
      	 and
      	bo.created_at >"2018-12-10  00:00:00 " and bo.created_at <"2018-12-15  23:59:59"
      	) as border,
      	#外销单
      	(
      	select count(*) 外销单量 from out_sale_order  oso
      	join company com on (com.id=oso.company_id)
      	where 
      	status="finished"
      	and
      	 com.company_name="龙口胜通能源有限公司"
      	and 
    oso.created_at >"2018-12-10  00:00:00 " and oso.created_at <"2018-12-15  23:59:59"
      	) as outorder;
      	
      	
      #	单价 销售总额
 	select consumer_name,min(unit_price),max(unit_price) from business_order bo
 		    join company com on (com.id=bo.company_id)
 		where     com.company_name="龙口胜通能源有限公司"  
	 and bo.created_at >"2018-12-03 00:00:00 " and bo.created_at <"2018-12-08  23:59:59"
 	group by consumer_name;
 	
 	
 		#销售总额
 	select con.consumer_name ,total_price  from business_order  bo
 			join consumer_new con on (con.id=bo.consumer_id)
 		    join company com on (com.id=bo.company_id)
 		   
 		where     com.company_name="龙口胜通能源有限公司"  
 		and bo.created_at >"2018-12-03  00:00:00 " and bo.created_at <"2018-12-08  23:59:59"
 		
 	 	#液厂名称/采购量  这里是为0的情况
 	select  f.fluid_name ,sum(check_value)  from waybill wb
join section_trip st on (st.waybill_id=wb.id)
join delivery_order dorder on (wb.delivery_order_id=dorder.id)
join company com on (com.id=dorder.trader_id)
join fluid f on (f.id=dorder.fluid_id)
 	join weight_note wn on  (wn.section_trip_id=st.id)
 	where 
 	 com.company_name="龙口胜通能源有限公司" and 
 	 	dorder.active_time >"2018-12-03  00:00:00 "  and dorder.active_time <"2018-12-08  23:59:59" and
 	wn.is_checked ='pass' and wn.check_value>0.0 and wb.is_deleted=0 and st.section_type='pickup' and st.is_deleted=0 	and wb.type="online"
 	group by fluid_name;
 	


	#液厂采购总额
 	select f.fluid_name ,sum(unit_sum_price) from procurement_statistic ps
 	join  waybill wb on (wb.id=replace(ps.waybill_id,"-",""))
 	join fluid f on(f.id=ps.fluid_id)
	join company com on(com.id=ps.company_id)
	where     
	com.company_name="龙口胜通能源有限公司"  and
	wb.start_time >"2018-12-03  00:00:00 " 	and wb.start_time <"2018-12-08  23:59:59"
 	group by f.fluid_name
 	;


	#time
 	#公司采购总额
 	select com.company_name, sum(unit_sum_price) from procurement_statistic ps
 	join company com  on (ps.company_id=com.id)
 	group by  com.company_name;