CREATE procedure solot_exists @parm1 varchar (5), @parm2 varchar (15)  as
SET NOCOUNT ON
select count(*) from SoLot With(NoLock)
where LineRef = @parm1 and
      OrdNbr =  @parm2


GO
GRANT CONTROL
    ON OBJECT::[dbo].[solot_exists] TO [MSDSL]
    AS [dbo];

