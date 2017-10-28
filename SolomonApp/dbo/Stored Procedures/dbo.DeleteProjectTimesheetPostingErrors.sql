
Create proc DeleteProjectTimesheetPostingErrors @parm1 varchar(47) --UserAddress
AS

 DELETE FROM WrkTimesheetPostBad 
  WHERE UserAddress = @parm1
 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[DeleteProjectTimesheetPostingErrors] TO [MSDSL]
    AS [dbo];

