
CREATE FUNCTION getNonReversNonCorrBatType (@BatNbr char(10), @Module char(2), @BatType char(1))
Returns varchar(1)
as
Begin
	declare @ReturnString varchar(1)
	declare @LocBatNbr as char(10)
	declare @LocBatType as char(1)
	select @LocBatNbr = @BatNbr
	select @LocBatType = @BatType
	select @ReturnString = @BatType
	
	while @LocBatType = 'O' or @LocBatType = 'V'
	begin
		select @LocBatNbr = b.OrigBatNbr, @LocBatType = b.battype from Batch b 
				where ltrim(rtrim(b.batnbr)) = ltrim(Rtrim(@LocBatNbr)) AND ltrim(rtrim(b.module)) = ltrim(rtrim(@Module))
		select @ReturnString = @LocBatType
	end
		             
	Return (@ReturnString)
	
End
