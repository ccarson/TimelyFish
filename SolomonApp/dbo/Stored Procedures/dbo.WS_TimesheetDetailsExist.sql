
Create Proc [dbo].WS_TimesheetDetailsExist @parm1 varchar (10) AS
    SELECT *
      FROM pjtimdet 
        where docnbr = @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_TimesheetDetailsExist] TO [MSDSL]
    AS [dbo];

