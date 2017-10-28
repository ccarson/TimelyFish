Create Procedure pXF100_cftMillSite_MillId @parm1 varchar (6) as 
    Select * from cftMillSite Where MillId = @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF100_cftMillSite_MillId] TO [MSDSL]
    AS [dbo];

