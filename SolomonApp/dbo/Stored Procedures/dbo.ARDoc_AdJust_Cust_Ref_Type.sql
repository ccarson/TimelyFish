 /****** Object:  Stored Procedure dbo.ARDoc_AdJust_Cust_Ref_Type    Script Date: 4/7/98 12:30:32 PM ******/
Create proc ARDoc_AdJust_Cust_Ref_Type @parm1 varchar ( 15), @parm2 varchar ( 10), @parm3 varchar ( 2) As
Select * from Ardoc where
        ardoc.custid = @parm1 and
        ardoc.refnbr = @parm2 and
        ardoc.doctype = @parm3


