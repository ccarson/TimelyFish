 /****** Object:  Stored Procedure dbo.CuryAcct_All    Script Date: 4/7/98 12:38:58 PM ******/
Create Proc CuryAcct_All @parm1 varchar(10), @parm2 varchar ( 10), @parm3 varchar ( 24), @parm4 varchar ( 24), @parm5 varchar ( 4), @parm6 varchar ( 4) as
       Select * from CuryAcct
           where CpnyID like @parm1
             and Acct   like @parm2
             and Sub    like @parm3
             and LedgerID like @parm4
             and FiscYr like @parm5
             and CuryID like @parm6
             order by CpnyID, Acct,Sub,LedgerID, FiscYr, CuryID


