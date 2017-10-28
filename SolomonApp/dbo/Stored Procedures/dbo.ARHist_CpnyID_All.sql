 /****** Object:  Stored Procedure dbo.ARHist_CpnyID_All    Script Date: 4/7/98 12:30:33 PM ******/
Create Proc ARHist_CpnyID_All @parm1 varchar ( 15), @parm2 varchar ( 10), @parm3 varchar ( 4) as
       Select * from ARHist
           where CustId like @parm1
             and CpnyID Like @parm2
             and FiscYr like @parm3
           order by CustId, FiscYr


