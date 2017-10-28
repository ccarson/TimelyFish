
Create proc ProjectTimesheetPostingErrors
@parm1 varchar(10), --Document ID
@parm2 varchar(47), --UserAddress
@parm3 varchar(47)  --UserID


AS
 SELECT *
   FROM WrkTimesheetPostBad
  WHERE DocNbr = @parm1
    AND UserAddress = @parm2
    AND UserID = @parm3  
 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProjectTimesheetPostingErrors] TO [MSDSL]
    AS [dbo];

