select * from  waybill limit 100;

select * from delivery_order limit 100;

select * delivery_order 


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

select check_quantity from sale_statistic 业务单吨




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
 	group by  carrier_name

