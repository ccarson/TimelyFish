CREATE Proc [dbo].[pXFCheckPerm]
	 @parm1 varchar(47)

 	-- Added Execute As to handle SL Integrated Security method -- TJones 3/13/2012
	WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
	as
	select *
	FROM SolomonSystem.dbo.usergrp 
	Where UserID=@parm1 AND GroupID IN ('FEEDMGT','ADMINISTRATORS') 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXFCheckPerm] TO [MSDSL]
    AS [dbo];

