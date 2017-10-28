
/****** Object:  Stored Procedure dbo.pCFScreens    Script Date: 9/10/2004 1:03:27 PM ******/


CREATE   Proc  pCFScreens 
@parm1 varchar (7) 
as
       Select * 
	from vs_Screen
        where vs_Screen.Module="CF"
	AND vs_Screen.Number LIKE @parm1
        order by vs_Screen.Number 



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCFScreens] TO [MSDSL]
    AS [dbo];

