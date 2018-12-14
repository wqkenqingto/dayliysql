


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
	
	##业务单,运单
select count(distinct bo.order_number)业务单量,count(waybill_id)运单量 from waybill wb 
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
select count(*) from consumer;

#业务量
select sum(actual_quantity)业务量 from business_order;	
#外采量
#外销量

#客户-业务量分析
select bo.consumer_name,count(distinct order_number) from business_order bo
join consumer con on (con.id=bo.consumer_id)
group by consumer_id

#承运商-运单量分析
select cc.carrier_name, count( distinct waybill_number) from waybill wb 
	left join delivery_order dorder on (wb.delivery_order_id=dorder.id)
	left join delivery_order_carriers doc on(dorder.id=doc.`deliveryorder_id`)
	left join cooperative_carrier cc on (cc.id=doc.cooperativecarrier_id)
 	group by  carrier_name;


 	#承运商-运费合计
 	select carrier,sum(freight_value) from income_statistic group by carrier
 	
 	#业务类别占比
 	#销售单量
 	select  count(*) from business_order 
 	where status ="finished"
 	#外销单
 	select count(*)from out_sale_order where status="finished";
 	
 	
 	
 	#业务单总量、外销单量、占比、环比增量；卸货地/客户区域分析
 	#销售单价 销售总额
 	select consumer_name,unit_price,total_price from business_order bo 
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
 	

 	
 	