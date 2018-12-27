##1、采购额、采购单量和采购吨位的分布（按液厂/省/月份）
select  sum(unit_sum_price)采购额 , sum(discounts_sum_price)优惠后采购额,count(distinct waybill)采购单量,sum(active_tonnage)采购吨位 ,actual_fluid_name 液厂,province 省份,month(active_time) 月
from (
select unit_sum_price ,discounts_sum_price, waybill,active_tonnage,active_time,actual_fluid_name,province  from `procurement_statistic` ps
join actual_fluid af on (af.id=replace(ps.fluid_id,"-",""))
join coordinate coor on (af.coordinate_id=coor.id)
union all
select unit_sum_price ,discounts_sum_price, waybill,active_tonnage,active_time,actual_fluid_name,province  from `procurement_statistic` ps
join fluid on (fluid.id=replace(ps.fluid_id,"-",""))
join `actual_fluid` af on (af.id=fluid.actual_fluid_id)
join coordinate coor on (af.coordinate_id=coor.id)
) pss
group by actual_fluid_name ,province,month(active_time)
order by actual_fluid_name ,month(active_time)



##销售额、销售单量和销售吨位的分布（按客户/省/月份)
 	sell_rental	   actual_quantity consumer_id

select  sum(sell_rental)销售总额,count(distinct waybill)销售单量 ,con.consumer_name,con.consumer_address,month(active_time)  from sale_statistic  ss join consumer_new con on (ss.consumer_id=con.id) 
group by con.consumer_name ,month(active_time)


##运单量（按承运商/月份）的分布

select count(distinct waybill_number) ,cooc.carrier_name,month(wb.created_at) from waybill wb join section_trip st on (st.waybill_id=wb.id) 
join `cooperative_carrier` cooc on (cooc.credit_code=st.credit_code)
where wb.is_deleted=0
group by cooc.carrier_name,month(wb.created_at)

##
select province ,count(*)from delivery_point_new 
group by province



select count(distinct st.id)/16123 from section_trip st 
join weight_note wn on (wn.section_trip_id=st.id)
where section_type ="unload"  and  TIMESTAMPDIFF(hour,arrival_time,wn.audit_datetime)>=36 and  TIMESTAMPDIFF(hour,arrival_time,wn.audit_datetime)<36


group by TIMESTAMPDIFF(hour,arrival_time,wn.audit_datetime)


arrival_time, audit_datetime,TIMESTAMPDIFF(minute,arrival_time,wn.audit_datetime) ,count(*) as differ



select  count(*)/9939 from section_trip st join weight_note wn on (wn.section_trip_id=st.id)
where section_type ="pickup" 

and TIMESTAMPDIFF(minute,arrival_time,wn.audit_datetime)>=0 
and TIMESTAMPDIFF(minute,arrival_time,wn.audit_datetime) <=40
group by TIMESTAMPDIFF(minute,arrival_time,wn.audit_datetime)


