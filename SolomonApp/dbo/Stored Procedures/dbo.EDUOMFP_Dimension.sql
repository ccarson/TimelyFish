 CREATE Proc EDUOMFP_Dimension @Dimension varchar(3), @UOM varchar(6) As
Select * From EDUOMFP Where Dimension = @Dimension And UOM Like @UOM Order By Dimension, UOM



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDUOMFP_Dimension] TO [MSDSL]
    AS [dbo];

