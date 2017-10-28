 Create Proc Ed850LDisc_LineNbr @parm1 varchar(15)  As Select * from Ed850LDisc where EDIPOID = @parm1 order by LineNbr


