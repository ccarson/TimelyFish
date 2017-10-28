 CREATE PROC pp_0153000_CuryAcct_Find @parm1 varchar(10), @parm2 varchar ( 10), @parm3 varchar ( 24), @parm4 varchar ( 24), @parm5 varchar ( 4), @parm6 varchar ( 4) as
SELECT *
  FROM  CuryAcct
  WHERE CpnyID    =    @parm1
     and Acct     =    @parm2
     and Sub      =    @parm3
     and LedgerID =    @parm4
     and FiscYr   =    @parm5
     and CuryID   =    @parm6
Order by CpnyID, Acct, Sub, LedgerID, FiscYr, CuryID


