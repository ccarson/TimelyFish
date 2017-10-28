CREATE VIEW [caredata].SHIPMENT_SALES_VW
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
      ,t.source_file_id
      ,t.manually_closed
      ,p.*
      ,l.sub_cohort_id
      ,l.location_id
      ,s.pigs
      ,s.weight
      ,s.actual_weight
      ,s.event_id shipped_event_id
      ,s.supervisor_id
      ,IsNull(f.currency_unit, p.currency_unit) currency
      ,IsNull(f.weight_unit, t.unit_of_measure) uom
  FROM caredata.shipment_sales p INNER JOIN caredata.shipment_tickets t on p.ticket_id = t.ticket_id and t.deletion_date IS NULL
                                INNER JOIN caredata.ev_cohort_shipments s ON t.ticket_id = s.ticket_id and s.deletion_date IS NULL
                                INNER JOIN caredata.cohort_location_reservations l ON s.sub_cohort_id = l.sub_cohort_id and l.deletion_date IS NULL
                                LEFT OUTER JOIN careglobal.sites f ON t.from_site_id = f.site_id
