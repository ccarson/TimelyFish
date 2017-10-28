 /****** Object:  Stored Procedure dbo.ARAdjust_CustId    Script Date: 4/7/98 12:30:32 PM ******/
Create Proc ARAdjust_CustId @parm1 varchar ( 15) as
    Select * from ARAdjust where custid like @parm1
    order by CustId, AdjdDocType, AdjdRefNbr, AdjgDocDate



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARAdjust_CustId] TO [MSDSL]
    AS [dbo];

