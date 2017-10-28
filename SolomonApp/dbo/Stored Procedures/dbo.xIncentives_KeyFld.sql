Create Procedure xIncentives_KeyFld @parm1 varchar (10) as 
    Select * from xIncentives Where KeyFld Like @parm1 Order by GPDiff, NPDiff

GO
GRANT CONTROL
    ON OBJECT::[dbo].[xIncentives_KeyFld] TO [MSDSL]
    AS [dbo];

