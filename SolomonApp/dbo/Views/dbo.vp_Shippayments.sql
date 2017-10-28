
CREATE VIEW vp_Shippayments
AS

Select DISTINCT S.s4future01, S.shipperid, S.PmtRef From SOShippayments S
         join 	SOSHipHeader H
                On S.ShipperId = H.Shipperid
                   AND S.CpnyId = H.CpnyID
         Join   Artran A
                ON A.Custid = H.Custid
                   AND A.SiteID = H.Invcnbr
                   AND A.CpnyID = H.CpnyID
         Where A.TranType = 'PA' 
               AND A.SiteId <> ''
        
   UNION ALL
   Select  DISTINCT S.s4future01,S.Shipperid, S.PmtRef From SOShippayments S
        join 	SOSHipHeader H
                On S.ShipperId = H.ShipperID

        Join ARADJust D
                ON D.Custid = H.Custid
                   AND D.AdjdRefNbr= H.Invcnbr
                   AND D.AdjgDocType = 'PA'
