 CREATE PROC GLTran_PerPost_Range @Acct varchar (10), @Sub varchar(24), @LedgerID varchar(10),
   @PerPost varchar (6), @CpnyID varchar(10), @StartBatNbr varchar(10), @StopBatNbr varchar(10) As

   Select * from GLTran
   Where Posted   = 'P'
         and CpnyID   = @CpnyID
         and Acct     = @Acct
         and Sub      = @Sub
         and LedgerID = @LedgerID
         and PerPost  = @PerPost
	 and BatNbr between @StartBatNbr and @StopBatNbr
   Order by BatNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[GLTran_PerPost_Range] TO [MSDSL]
    AS [dbo];

