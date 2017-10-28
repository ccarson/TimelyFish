CREATE VIEW [caredata].[SHIPMENT_TICKETS_VW]
AS
SELECT t.*
      ,IsNull(s.weight_unit, t.unit_of_measure) uom
  FROM caredata.shipment_tickets t LEFT OUTER JOIN careglobal.sites s ON t.from_site_id = s.site_id
