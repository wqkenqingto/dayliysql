 
 #贸易公司站点运单信息
 select wb.waybill_number,bo.station as 站点名,replace(station_id,"-","")站点id,bo.settlement_total_price 结算总价,bo.total_price 销售总价,dpn.longitude,dpn.latitude  from waybill wb
join section_trip st on (st.waybill_id=wb.id)
join business_order bo on(bo.id=st.business_order_id)
join delivery_point_new dpn on(replace(bo.station_id,"-","")=dpn.id )
join company com on (com.id=bo.company_id)
where
 com.`company_name` ='龙口胜通能源有限公司' and  stop_time between'2018-11-01 00:00:00' and '2018-12-01 15:08:44';
 
 
 
 
  #贸易公司站点运单信息2
 select wb.waybill_number,bo.station as 站点名,replace(station_id,"-","")站点id,bo.settlement_total_price 结算总价,bo.total_price 销售总价,dpn.longitude,dpn.latitude  from waybill wb
join section_trip st on (st.waybill_id=wb.id)
join business_order bo on(bo.id=st.business_order_id)
join delivery_point_new dpn on(replace(bo.station_id,"-","")=dpn.id )
join company com on (com.id=bo.company_id)
where
 com.`company_name` ='龙口胜通能源有限公司' and  stop_time between'2018-11-01 00:00:00' and '2018-12-01 15:08:44'
 
 
 
 
 #承运商公司
 select wb.waybill_number,dpn.longitude,dpn.latitude ,cc.carrier_name from waybill wb
join section_trip st on (st.waybill_id=wb.id)
join company com on (com.id=bo.company_id)
join cooperative_carrier cc on (cc.company_id=com.id)
join delivery_order dorder on(dorder.id=doc.deliveryorder_id)
join delivery_order_carriers doc on (doc.cooperativecarrier_id=cc.id)
join delivery_point_new dpn on(replace(bo.station_id,"-","")=dpn.id )


join weight_note wn on (wn.section_trip_id=st.id)
where
audit_datetime between'2018-10-01 00:00:00' and '2018-12-01 15:08:44' 
and com.company_name ='龙口胜通能源有限公司'
-- where carrier_name="龙口市胜通物流有限公司"



select com.company_name,coo.carrier_name from cooperative_carrier coo
join company com on (com.id=coo.company_id)
where company_name='龙口胜通能源有限公司'
group by company_id

#承运商2
select cc.carrier_name 承运商,wb.waybill_number 订单号,dpn.station_name 站点名,dpn.id,wn.upload_value 吨位 from waybill wb 
	left join delivery_order dorder on (wb.delivery_order_id=dorder.id)
	left join delivery_order_carriers doc on(dorder.id=doc.`deliveryorder_id`)
	left join cooperative_carrier cc on (cc.id=doc.cooperativecarrier_id)
	left join company com on (com.id=dorder.trader_id)
	left join section_trip st on (st.waybill_id=wb.id)
	left join business_order bo on(bo.id=st.business_order_id)
	left join delivery_point_new dpn on(replace(bo.station_id,"-","")=dpn.id )
	left join weight_note wn on (wn.section_trip_id=st.id)
	where  
-- 	audit_datetime between'2018-10-01 00:00:00' and '2018-12-01 15:08:44' and 
	business_order_id is not null  and dpn.id is not null and wb.is_deleted =0 
	and st.is_deleted=0 	and upload_value is not null