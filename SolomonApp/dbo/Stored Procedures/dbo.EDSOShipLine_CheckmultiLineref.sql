 CREATE PROC EDSOShipLine_CheckmultiLineref
  @CpnyId varchar(10), @shipperid varchar(15),@Invtid varchar(30)
AS Declare @cnt int, @LineRef varchar(5)
--select count
Select @Cnt = count(*) from soshipline where cpnyid = @cpnyid and shipperid = @ShipperId and invtid = @invtid
If @Cnt > 1
  Begin
      Select @LineRef = '-1'
    goto exitproc
  end
Else
  begin
  Select @LineRef = lineref  from soshipline where cpnyid = @cpnyid and shipperid = @ShipperId and invtid = @invtid
  end
Exitproc:
Select @LineRef



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOShipLine_CheckmultiLineref] TO [MSDSL]
    AS [dbo];

