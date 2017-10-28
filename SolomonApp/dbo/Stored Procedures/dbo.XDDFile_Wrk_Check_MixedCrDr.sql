CREATE PROCEDURE XDDFile_Wrk_Check_MixedCrDr
	@EBFileNbr		varchar( 6 ),
	@FileType		varchar( 1 ),	-- E-AP-EFT, R-AR-EFT
	@CpnyID			varchar( 10 ),
	@Acct			varchar( 10 ),
	@Sub			varchar( 24 )	

AS


-- For now ignore AR EFT files
-- If @FileType = 'E'
select convert(smallint, count(*)) FROM XDDFile_Wrk (nolock)
WHERE 	EBFileNbr = @EBFileNbr
	and FileType = @FileType
	and ChkCpnyID = @CpnyID
	and ChkAcct = @Acct
	and ChkSub = @Sub
	and RecordSummary = 'V'
	and VchDocType = 'AD'
--else
--select convert(smallint, count(*)) FROM XDDFile_Wrk (nolock)
--WHERE 	EBFileNbr = @EBFileNbr
--	and FileType = @FileType
--	and ChkCpnyID = @CpnyID
--	and ChkAcct = @Acct
--	and ChkSub = @Sub
--	and RecordSummary <> 'X'
--	and VchDocType = 'CM'
