##TMS公司所在TMS系统内，实际发生的运输业务，总运单数=平台运单+线下运单
select  type, count(*) from waybill
where is_deleted=0
group by type


select road_toll_com 过路费, maintenance_cost 维修费 from income_statistic iss
join carrier car on (car.id=iss.carrier_id) 
where 
iss.created_at >="2018-12-03  00:00:00" and iss.created_at<="2018-12-08  23:59:59" and 
car.name="龙口市胜通物流有限公司";


select cc.carrier_name, count( distinct waybill_number) from waybill wb
	left join delivery_order dorder on (wb.delivery_order_id=dorder.id)
	left join delivery_order_carriers doc on(dorder.id=doc.`deliveryorder_id`)
	left join cooperative_carrier cc on (cc.id=doc.cooperativecarrier_id)
	 	left join company com on (com.id=dorder.trader_id)
     	left join section_trip st on (st.waybill_id=wb.id)
     where	
     com.company_name="龙口胜通能源有限公司"
  	 and st.work_end_time >"2018-12-10  00:00:00 " and st.work_end_time <"2018-12-15  23:59:59"
 	 group by  carrier_name;
 	 
 	 

	 
	 
	  select carrier,sum(freight_value) from income_statistic iss
     join company com on (com.id=iss.company_id)
    where
     com.company_name="龙口胜通能源有限公司"
     and
     iss.work_end_time >"2018-12-10  00:00:00 " and iss.work_end_time <"2018-12-15  23:59:59"
     group by carrier;
     
     
     
      select bo.short_name 名字1,count(distinct bo.order_number) num1 from business_order bo
 join consumer con on (con.id=bo.consumer_id)
 join company com on (com.id=bo.company_id)
 where
  com.company_name="龙口胜通能源有限公司"
  and bo.created_at >"2018-12-03  00:00:00 " and bo.created_at <"2018-12-08  23:59:59" and bo.is_deleted=0

 
 
 select count(distinct bo.order_number)业务单量,count(distinct bo.consumer_id) 周活跃客户数  from business_order bo
 join consumer con on (con.id=bo.consumer_id)
 join company com on (com.id=bo.company_id)
where bo.is_deleted=0 and bo.created_at >"2018-12-03  00:00:00 " and bo.created_at <"2018-12-08  23:59:59" 
and com.company_name ="龙口胜通能源有限公司" and wb.is_deleted=0 and st.type="online"


select * from section_trip group by section_type



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
