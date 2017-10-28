 /****** Object:  Stored Procedure dbo.ARHist_CpnyID    Script Date: 4/7/98 12:30:33 PM ******/
Create Proc ARHist_CpnyID @parm1 varchar ( 15), @parm2 varchar ( 4), @parm3 varchar ( 10) as
       Select * from ARHist
           where CustId like @parm1
             and Fiscyr Like @parm2
             and CpnyID like @parm3
           order by CustId, FiscYr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARHist_CpnyID] TO [MSDSL]
    AS [dbo];

