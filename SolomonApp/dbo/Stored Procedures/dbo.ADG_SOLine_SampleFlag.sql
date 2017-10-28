
create proc ADG_SOLine_SampleFlag
	@InvtID   varchar(30),
    @OrdNbr   varchar(15),
	@LineRef  varchar(5),
	@CpnyId   varchar(10)
as
	declare	@Sample	smallint	-- logical
	
	select	@Sample = Sample

	from	SOLine (nolock)
	where	InvtID = @Invtid  AND
            CpnyID = @CpnyID  AND
            OrdNbr = @OrdNbr  AND
            LineRef = @LineRef

    Select @Sample
	
