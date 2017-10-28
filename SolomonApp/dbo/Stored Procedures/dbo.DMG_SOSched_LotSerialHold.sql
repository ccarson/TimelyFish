 CREATE PROCEDURE DMG_SOSched_LotSerialHold
	@CpnyID as varchar(10),
	@OrdNbr as varchar(10) as

if exists(select * from SOSched where CpnyID = @CpnyID and OrdNbr = @OrdNbr and LotSerialEntered < LotSerialReq)
	select convert(smallint, 1)
else
	select convert(smallint, 0)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOSched_LotSerialHold] TO [MSDSL]
    AS [dbo];

