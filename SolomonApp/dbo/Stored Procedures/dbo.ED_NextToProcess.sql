 CREATE PROCEDURE ED_NextToProcess @NextFunctionID varchar(8), @NextClassID varchar(4) AS
Select CpnyId, ShipperId from soshipheader
where NextFunctionID = @NextFunctionID and NextFunctionClass = @NextClassID And Cancelled = 0
order by shipperid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED_NextToProcess] TO [MSDSL]
    AS [dbo];

