CREATE Procedure pXF135_cftMillSite_MillId @parm1 varchar (6) as 
    Select * from cftMillSite Where MillId = @parm1


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF135_cftMillSite_MillId] TO [MSDSL]
    AS [dbo];

