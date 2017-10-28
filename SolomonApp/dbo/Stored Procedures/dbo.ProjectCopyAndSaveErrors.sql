
Create proc ProjectCopyAndSaveErrors
@parm1 varchar(16), --Copy Project ID
@parm2 varchar(16), --New Project ID
@parm3 varchar(47), --UserAddress
@parm4 varchar(47)  --UserID


AS
 SELECT *
   FROM CopyProjectAndTasksBad
  WHERE CopyProj = @parm1
    AND NewProj  = @parm2
    AND UserAddress = @parm3
    AND UserID = @parm4  
 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProjectCopyAndSaveErrors] TO [MSDSL]
    AS [dbo];

