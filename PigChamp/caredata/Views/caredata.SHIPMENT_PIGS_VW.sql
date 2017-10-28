CREATE VIEW [caredata].SHIPMENT_PIGS_VW
AS
SELECT t.from_site_id
      ,t.source_id
      ,t.ticket_name
      ,t.transport_id
      ,t.truck_identifier
      ,t.shipment_date
      ,t.pigs_shipped
      ,t.av_age
      ,t.av_weight
      ,t.unit_of_measure
      ,t.comments
      ,t.data_source_is_file
      ,t.source_file_id
      ,t.manually_closed
      ,p.*
      ,IsNull(f.currency_unit, p.currency_unit) currency
      ,IsNull(f.weight_unit, t.unit_of_measure) uom
      ,l.event_id placement_event_id
      ,l.sub_cohort_id placement_sub_cohort_id
      ,l.pigs placement_pigs
      ,l.placement_date
      ,l.sex_id
      ,l.genetics_id
      ,l.pig_type_id
      ,s.event_id as shipped_event_id
      ,s.pigs
      ,s.weight
      ,s.actual_weight
      ,s.sub_cohort_id
      ,s.supervisor_id 
      ,r.location_id
  FROM caredata.shipment_pigs p INNER JOIN caredata.shipment_tickets t on p.ticket_id = t.ticket_id and t.deletion_date IS NULL
                               LEFT OUTER JOIN careglobal.sites f ON t.from_site_id = f.site_id
                               LEFT OUTER JOIN caredata.ev_cohort_placements l ON t.ticket_id = l.ticket_id and l.deletion_date IS NULL
                               LEFT OUTER JOIN caredata.ev_cohort_shipments s ON t.ticket_id = s.ticket_id and s.deletion_date IS NULL
                               LEFT OUTER JOIN caredata.cohort_location_reservations r ON s.sub_cohort_id = r.sub_cohort_id and r.deletion_date IS NULL
