Create Procedure baAPDoc_VORefNbr @parm1 varchar (10)  as 
    Select * from APDoc Where DocType = 'VO' and RefNbr = @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[baAPDoc_VORefNbr] TO [MSDSL]
    AS [dbo];

