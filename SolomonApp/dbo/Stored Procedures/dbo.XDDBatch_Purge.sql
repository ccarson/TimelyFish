
CREATE PROCEDURE XDDBatch_Purge
	@FileType	varchar( 1 ),		-- 'R'-AR-EFT, 'E'-AP-EFT, 'P'-Pos Pay, 'L'- Lockbox
	@NbrMonths	smallint
AS

	Declare	@CutOffDate	smalldatetime

	-- Check of number of months is less than two... make that the minimum
	if @NbrMonths < 2  SET @NbrMonths = 2
	-- Use today's system date to subtract from...
	SET @CutOffDate = DateAdd(m, -@NbrMonths, GetDate())

	if @FileType = 'E'
	BEGIN

		DELETE
		FROM	XDDBatch
		WHERE	EBFileNbr IN (Select EB.EBFileNbr FROM XDDEBFile EB (nolock)
					WHERE	EB.TransmitDate < @CutOffDate
						and EB.TransmitDate <> 0
						and EB.FileType IN ('E', 'W'))
			and EBFileNbr <> ''
			and FileType IN ('E', 'W')
			
		DELETE
		FROM	XDDFile_Wrk
		WHERE	EBFileNbr IN (Select EB.EBFileNbr FROM XDDEBFile EB (nolock)
					WHERE	EB.TransmitDate < @CutOffDate
						and EB.TransmitDate <> 0
						and EB.FileType IN ('E', 'W'))
			and EBFileNbr <> ''			
			and FileType IN ('E', 'W')

		
		DELETE	
		FROM	XDDEBFile
		WHERE	TransmitDate < @CutOffDate
			and TransmitDate <> 0
			and FileType IN ('E', 'W')
			

	END

	if @FileType = 'R'
	BEGIN

		-- Select Invoices
		DELETE	
		FROM	XDDBatchAREFT
		WHERE	BatNbr IN (SELECT BatNbr FROM XDDBatch XB (nolock)
					WHERE XB.EBFileNbr IN (Select EB.EBFileNbr FROM XDDEBFile EB (nolock)
							WHERE	EB.TransmitDate < @CutOffDate
								and EB.TransmitDate <> 0
								and EB.FileType IN ('R', 'X'))
						and XB.EBFileNbr <> ''
						and XB.FileType IN ('R', 'X'))

		-- XDDBatch
		DELETE
		FROM	XDDBatch
		WHERE	EBFileNbr IN (Select EB.EBFileNbr FROM XDDEBFile EB (nolock)
					WHERE	EB.TransmitDate < @CutOffDate
						and EB.TransmitDate <> 0
						and EB.FileType IN ('R', 'X'))
			and EBFileNbr <> ''
			and FileType IN ('R', 'X')
			
		DELETE
		FROM	XDDFile_Wrk
		WHERE	EBFileNbr IN (Select EB.EBFileNbr FROM XDDEBFile EB (nolock)
					WHERE	EB.TransmitDate < @CutOffDate
						and EB.TransmitDate <> 0
						and EB.FileType IN ('R', 'X'))
			and EBFileNbr <> ''			
			and FileType IN ('R', 'X')

		
		DELETE	
		FROM	XDDEBFile
		WHERE	TransmitDate < @CutOffDate
			and TransmitDate <> 0
			and FileType IN ('R', 'X')

	
	END	

	if @FileType = 'P'
	BEGIN

		DELETE
		FROM	XDDBatch
		WHERE	EBFileNbr IN (Select EB.EBFileNbr FROM XDDEBFile EB (nolock)
					WHERE	EB.TransmitDate < @CutOffDate
						and EB.TransmitDate <> 0
						and EB.FileType = 'P')
			and EBFileNbr <> ''			
			and FileType = 'P'
			
		DELETE
		FROM	XDDFile_Wrk
		WHERE	EBFileNbr IN (Select EB.EBFileNbr FROM XDDEBFile EB (nolock)
					WHERE	EB.TransmitDate < @CutOffDate
						and EB.TransmitDate <> 0
						and EB.FileType = 'P')
			and EBFileNbr <> ''			
			and FileType = 'P'
		
		DELETE	
		FROM	XDDEBFile
		WHERE	TransmitDate < @CutOffDate
			and TransmitDate <> 0
			and FileType = 'P'

	END
	
	if @FileType = 'L'
	BEGIN

		-- Good Grid
		DELETE	
		FROM	XDDBatchARLB
		WHERE 	LBBatNbr IN (Select BatNbr FROM XDDBatch XB (nolock)
					WHERE	XB.DepDate < @CutOffDate
						and XB.DepDate <> 0
						and XB.FileType = 'L'
						and XB.KeepDelete = 'C')

		-- Errors Grid
		DELETE	
		FROM	XDDBatchARLBErrors
		WHERE 	LBBatNbr IN (Select BatNbr FROM XDDBatch XB (nolock)
					WHERE	XB.DepDate < @CutOffDate
						and XB.DepDate <> 0
						and XB.FileType = 'L'
						and XB.KeepDelete = 'C')
		
		-- Applications
		DELETE	
		FROM	XDDBatchARLBApplic
		WHERE 	LBBatNbr IN (Select BatNbr FROM XDDBatch XB (nolock)
					WHERE	XB.DepDate < @CutOffDate
						and XB.DepDate <> 0
						and XB.FileType = 'L'
						and XB.KeepDelete = 'C')

		-- XDDBatch
		DELETE
		FROM	XDDBatch
		WHERE	DepDate < @CutOffDate
			and DepDate <> 0
			and FileType = 'L'
			and KeepDelete = 'C'
	END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDBatch_Purge] TO [MSDSL]
    AS [dbo];

