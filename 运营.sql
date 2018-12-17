


select  from waybill wb 
	left join delivery_order dorder on (wb.delivery_order_id=dorder.id) #提货单
	left join delivery_order_carriers doc on(dorder.id=doc.`deliveryorder_id`) #提货单与承运公司匹配
	left join cooperative_carrier cc on (cc.id=doc.cooperativecarrier_id) #承运公司
	left join company com on (com.id=dorder.trader_id) #贸易公司
	left join section_trip st on (st.waybill_id=wb.id) #分段
	left join business_order bo on(bo.id=st.business_order_id) #业务单
	left join delivery_point_new dpn on(replace(bo.station_id,"-","")=dpn.id ) #站点
	left join weight_note wn on (wn.section_trip_id=st.id) #磅单;
	

select active_tonnage from procurement_statistic  #采购量吨

select check_quantity from sale_statistic #业务单吨




select * from waybill where waybill_number='TE1810110002'
	
	select count(waybill_id)运单量,count(oso.id),oso.* from waybill wb 
	left join section_trip st on (st.waybill_id=wb.id) 
	left join out_sale_order oso on (oso.waybill_number=wb.waybill_number)
	
	
	select * from waybill where waybill_number="TSE1810210018"


	select * from waybill where waybill_number like "%TSE%"

##1.基础贸易信息分析：以时间为维度下，基础业务数据概览	
	##业务单,运单
select  count(distinct bo.order_number)业务单量,count(waybill_id)运单量 from waybill wb 
	left join section_trip st on (st.waybill_id=wb.id) 
	left join business_order bo on(bo.id=st.business_order_id) #业务单 
		where 
	bo.status="finished" and wb.is_deleted=0 
	
	##业务单,运单,周活跃
select count(distinct bo.order_number)业务单量,count(waybill_id)运单量,count(distinct bo.consumer_id) 周活跃客户数 from waybill wb 
	left join section_trip st on (st.waybill_id=wb.id) 
	left join business_order bo on(bo.id=st.business_order_id) #业务单 
		where 
	bo.status="finished" and wb.is_deleted=0	
	
	

#客户数
select count(*) 客户总数 from consumer;

#业务量
select sum(actual_quantity)业务量 from business_order;	
#外采量
select count(*)from out_buy_waybill 
#外销量
select count(*) from out_sale_order

#2.客户价值维度下的对比分析：以客户为维度
#客户-业务量分析
select bo.consumer_name,count(distinct order_number) from business_order bo
join consumer con on (con.id=bo.consumer_id)
group by consumer_id

#3.托运分析：以承运商和时间为维度
#承运商-运单量分析
select cc.carrier_name, count( distinct waybill_number) from waybill wb 
	left join delivery_order dorder on (wb.delivery_order_id=dorder.id)
	left join delivery_order_carriers doc on(dorder.id=doc.`deliveryorder_id`)
	left join cooperative_carrier cc on (cc.id=doc.cooperativecarrier_id)
 	group by  carrier_name;


 	#承运商-运费合计
 	select carrier,sum(freight_value) from income_statistic group by carrier
 	
 	#业务类别占比
 	
 	#4.业务类别情况占比
 	#销售单量
 	select  count(*) from business_order 
 	where status ="finished"
 	#外销单
 	select count(*)from out_sale_order where status="finished";
 	#销售单量+外销单量=总业务单量
 	
 	#外销单占比 外销单/总业务单量
 	
 
 	#业务单总量、外销单量、占比、环比增量；卸货地/客户区域分析
 	#销售单价 销售总额
 	select consumer_name,min(unit_price),max(unit_price) from business_order bo 
 	group by consumer_name;
 	
 	#销售总额
 	select com.company_name ,total_price from business_order  bo
 	join company com on (com.id=bo.company_id)
 	
 	#液厂-采购分析
 	select * from delivery_order dorder join 
 	fluid   on (fluid.id=dorder.fluid_id)
 	
 	
 	 	#液厂名称/采购量  这里是为0的情况
 	select waybill_number,st.status  from waybill wb 
 	join section_trip st on (st.waybill_id=wb.id)
 	join weight_note wn on  (wn.section_trip_id=st.id)
 	where 
 	wn.is_checked ='pass' and wn.check_value=0.0 and wb.is_deleted=0 and st.section_type='pickup' and st.is_deleted=0 	and wb.type="platform";
 
 	
 	#液厂采购总额
 	select sum(unit_sum_price) from procurement_statistic ps
 	join  waybill wb on (wb.id=replace(ps.waybill_id,"-",""));
 	#time	
 	#公司采购总额
 	select com.company_name, sum(unit_sum_price) from procurement_statistic ps
 	join company com  on (ps.company_id=com.id)
 	group by  com.company_name
 	
 	
 	
 	#7.利润分析
 	
 	
 	
 	select waybill_id from section_trip where id='e819229e8f5249608b7f55e0d6f2f892'
 	select is_checked from weight_note  where check_value =0.0 group by is_checked
 	select * from weight_note where is_checked ='pass' and check_value=0.0
 	select is_deleted from waybill where id='b66c882ddedd432bb53cb0f93814dbf7'
 	

 	###物流运营报告
 	##1
 	select count(type) ,type from waybill 
 	where is_deleted=0
 	group by type
	##2
	
	##3托运客户分析：（时间维度下发生的运单数总和，运单数为平台和线下的总和）
		
	select count(wb.id)  from waybill wb join 
	logistic_statistic ls on (replace(ls.waybill_id,"-","")=wb.id)
	group by company_id
	 
	 ##4物流运输成本费用合计
	 
	 
	 
	select * from company where id='9484885e877242e48da28dbc318a93e4'
	#基础业务概览(业务单、采购单、运单筛选维度均为BPM下的平台运单)
	select wbb.业务单量,wbb.运单量,obw.外销单数,boo.业务量,wbb.周活跃客户数,conn.客户总数  from 
	(
	##业务单,运单,周活跃
select count(distinct bo.order_number)业务单量,count(waybill_id)运单量,count(distinct bo.consumer_id) 周活跃客户数 from waybill wb 
	left join section_trip st on (st.waybill_id=wb.id) 
	left join business_order bo on(bo.id=st.business_order_id) #业务单 
		where 
	bo.status="finished" and wb.is_deleted=0	
	) as wbb,(
	#外销
select sum(actual_quantity)业务量 from business_order)as boo,
(select count(*) 客户总数 from consumer)
	as conn,
(select count(*) 外销单数 from out_buy_waybill
 )	as obw
 
 
 
  ##采购量,业务量,外采量
 select dordern.计划采购量,boo.业务量,obw.外采量,oso.外销量 from
 (select sum(`plan_tonnage`) 计划采购量 from waybill wb 
 join delivery_order dorder on(wb.delivery_order_id=dorder.id)
 )as dordern,
 (
 select sum(actual_quantity)业务量 from waybill wb
join section_trip st on (st.waybill_id=wb.id)
join business_order bo on(bo.id=st.business_order_id)
) as boo,
(
select sum(actual_quantity)外采量 from out_buy_waybill
)as obw,
(
select sum(actual_quantity) 外销量 from out_sale_order
)as oso

 select sum(active_tonnage) from section_trip
 where 
 created_at >"2018-12-10 00:00:00 " and created_at <"2018-12-15  23:59:59"  
	and section_type="pickup" 
 
 
 
##采购量,业务量,外采量
 select dordern.采购量,boo.业务量,obw.外采量,oso.外销量 from
 (
 select sum(active_tonnage)采购量 from section_trip
 where 
 created_at >"2018-12-03  00:00:00 " and created_at <"2018-12-08  23:59:59"  
	and section_type="pickup" 

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


#2.客户价值维度下的对比分析：以客户为维度
#客户-业务量分析
select bo.consumer_name,count(distinct order_number) from business_order bo
join consumer con on (con.id=bo.consumer_id)
where
bo.created_at >"2018-12-03  00:00:00 " and bo.created_at <"2018-12-08  23:59:59"  
group by consumer_id


select count(distinct consumer.id) 客户总数 from consumer  
join business_order bo on (bo.consumer_id=consumer.id)
join company com on (com.id=bo.company_id)
where
 consumer.created_at <"2018-12-08 23:59:59" and com.company_name ="龙口胜通能源有限公司"

select * from company where company_name like "%龙口%"


select count(*) 外销单数 from out_sale_order oso
join company com on (com.id=oso.company_id)
where  oso.created_at >"2018-12-03  00:00:00 " and oso.created_at <"2018-12-08  23:59:59"


 select count(*)运单数 from waybill  wb
 join section_trip st on(st.waybill_id=wb.id)
 join business_order bo on(bo.id=st.business_order_id)
 join company com on (com.id=bo.company_id)
 where wb.start_time>="2018-12-03  00:00:00"  and wb.start_time <="2018-12-15 23:59:59"  and wb.is_deleted=0 and com.company_name="龙口胜通能源有限公司"
 
 
 select count(*) 采购单量 from section_trip  st
  	join business_order bo on(bo.id=st.business_order_id)
 	join company com on (com.id=bo.company_id)
 	
	where 
	st.created_at >"2018-12-03  00:00:00 " and st.created_at <"2018-12-08  23:59:59"  
	and st.section_type="unload"  and com.company_name="龙口胜通能源有限公司"
	
	
	
	
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
 select count(*) 采购单量 from section_trip  st
  	join business_order bo on(bo.id=st.business_order_id)
 	join company com on (com.id=bo.company_id)
 	
	where 
	st.created_at >"2018-12-03  00:00:00 " and st.created_at <"2018-12-08  23:59:59"  
	and st.section_type="unload"  and com.company_name="龙口胜通能源有限公司"
 
 )as delivery,
 (
 select count(*) 外采单数 from out_buy_waybill obw
 join company com on(com.id=obw.company_id)
 where start_time >"2018-12-03  00:00:00 " and start_time <"2018-12-08  23:59:59"  
 )as obw
 
 
 
 
 #基础业务概览(业务单、采购单、运单筛选维度均为BPM下的平台运单)
	select  delivery.采购单量,  boo.业务单量,waybbb.运单数,obw.外采单数,osr.外销单数,boo.周活跃客户数,conn.客户总数  from
	(
	#外销
select count(distinct bo.order_number)业务单量,count(distinct bo.consumer_id) 周活跃客户数  from business_order bo
join company com on (com.id=bo.company_id)
where bo.is_deleted=0 and bo.created_at >"2018-12-10  00:00:00 " and bo.created_at <"2018-12-15  23:59:59"
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
where  oso.created_at >"2018-12-10  00:00:00 " and oso.created_at <"2018-12-15  23:59:59"
 )	as osr,
 (
 select count(*)运单数 from waybill  wb
 join section_trip st on(st.waybill_id=wb.id)
 join business_order bo on(bo.id=st.business_order_id)
 join company com on (com.id=bo.company_id)
 where wb.start_time>="2018-12-10  00:00:00"  and wb.start_time <="2018-12-08 23:59:59"  and wb.is_deleted=0 and com.company_name="龙口胜通能源有限公司"
 )as waybbb,
 (
 select count(*) 采购单量 from section_trip  st
  	join business_order bo on(bo.id=st.business_order_id)
 	join company com on (com.id=bo.company_id)

	where
	st.created_at >"2018-12-10  00:00:00 " and st.created_at <"2018-12-15  23:59:59"
	and st.section_type="unload"  and com.company_name="龙口胜通能源有限公司"

 )as delivery,
 (
 select count(*) 外采单数 from out_buy_waybill obw
 join company com on(com.id=obw.company_id)
 where start_time >"2018-12-10  00:00:00 " and start_time <"2018-12-15  23:59:59"
 )as obw



  select sum(`plan_tonnage`) 计划采购量 from waybill wb
join business_order bo on(bo.id=st.business_order_id)
join company com on (com.id=bo.company_id)
  join delivery_order dorder on(wb.delivery_order_id=dorder.id)
