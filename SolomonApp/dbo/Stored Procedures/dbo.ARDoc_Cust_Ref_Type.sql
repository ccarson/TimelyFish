 /****** Object:  Stored Procedure dbo.ARDoc_Cust_Ref_Type    Script Date: 4/7/98 12:30:33 PM ******/
Create proc ARDoc_Cust_Ref_Type @parm1 varchar ( 6) As
Select * from Ardoc where
        ardoc.docbal = 0 and
        ardoc.rlsed = 1 and
        ardoc.perclosed <= @parm1 and
        ardoc.perclosed <> ''
        order by CustID, Doctype, RefNbr


