 CREATE Proc ARHist_CpnyID_All1 @parm1 varchar ( 15), @parm2 varchar ( 10), @parm3 varchar ( 4) as
       Select * from ARHist
           where CustId like @parm1
             and (CpnyID Like @parm2 or @parm2 ='')
             and FiscYr like @parm3
           order by CustId, FiscYr


