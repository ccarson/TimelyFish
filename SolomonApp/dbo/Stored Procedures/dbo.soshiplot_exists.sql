Create procedure soshiplot_exists @parm1 varchar (5), @parm2 varchar (15)  as
SET NOCOUNT ON
select count(*) from SoshipLot With(NoLock)
where LineRef = @parm1 and
      Shipperid =  @parm2 and
      LotSerNbr <> ''

GO
GRANT CONTROL
    ON OBJECT::[dbo].[soshiplot_exists] TO [MSDSL]
    AS [dbo];

