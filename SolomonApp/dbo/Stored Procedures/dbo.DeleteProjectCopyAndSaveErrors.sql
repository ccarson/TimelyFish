
Create proc DeleteProjectCopyAndSaveErrors @parm1 varchar(47) --UserAddress
AS

 DELETE FROM CopyProjectAndTasksBad 
  WHERE UserAddress = @parm1
 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[DeleteProjectCopyAndSaveErrors] TO [MSDSL]
    AS [dbo];

