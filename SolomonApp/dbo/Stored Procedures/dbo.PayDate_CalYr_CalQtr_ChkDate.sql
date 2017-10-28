 Create Proc  PayDate_CalYr_CalQtr_ChkDate @parm1 varchar ( 4), @parm2 smallint, @parm3 smalldatetime, @parm4 varchar (10) as
       Select * from PayDate
           where CalYr   =  @parm1
             and CalQtr  =  @parm2
             and ChkDate =  @parm3
             and CpnyId  =  @parm4
           order by CalYr  ,
                    CalQtr ,
                    ChkDate,
                    CpnyId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PayDate_CalYr_CalQtr_ChkDate] TO [MSDSL]
    AS [dbo];

