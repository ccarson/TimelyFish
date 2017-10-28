 /****** Object:  Stored Procedure dbo.ARHist_CustID    Script Date: 4/7/98 12:30:33 PM ******/
Create Proc ARHist_CustID @parm1 varchar ( 15) as
       Select * from ARHist
           where CustId like @parm1
           order by CustID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARHist_CustID] TO [MSDSL]
    AS [dbo];

