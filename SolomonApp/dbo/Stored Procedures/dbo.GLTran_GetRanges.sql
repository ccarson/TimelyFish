 CREATE PROC GLTran_GetRanges @CpnyID varchar (10), @Acct varchar (10), @Sub varchar(24),
   @LedgerID varchar(10), @PerPost varchar (6), @Size smallint As

--The procedure determines boundary batch numbers in order to split whole GLTran set into separate pages.
--Each page includes transactions between StartBatNbr and StopBatNbr
   DECLARE @StartBatNbr char(10)
   DECLARE @PrevBatNbr char(10)
   DECLARE @StopBatNbr char(10), @i int
   SELECT @StartBatNbr='', @i=1

   CREATE TABLE #Ranges (StartBatNbr char(10), StopBatNbr char(10))

   DECLARE SelBatches INSENSITIVE CURSOR FOR --Insensitive flag is required. Keyset synchronization takes a lot of time in some environments.
   SELECT BatNbr from GLTran with(INDEX(GLTRAN6)) --SQL may perform a table scan here. To avoid this let's specify the index explicitly.
   WHERE Posted   = 'P'
         AND CpnyID   = @CpnyID
         AND Acct     = @Acct
         AND Sub      = @Sub
         AND LedgerID = @LedgerID
         AND PerPost  = @PerPost
   ORDER BY BatNbr

   OPEN SelBatches
    FETCH NEXT FROM SelBatches INTO @StopBatNbr

   WHILE @@FETCH_STATUS=0 BEGIN
     IF @i%@Size=1 SELECT @StartBatNbr=@StopBatNbr --This is the first transaction of the current page.
     IF @i%@Size=0 BEGIN --This is the last transaction of the page.
         INSERT #Ranges VALUES(@StartBatNbr,@StopBatNbr) --Boundary batch numbers are determined.
         SELECT @PrevBatNbr=@StopBatNbr
         WHILE @@FETCH_STATUS=0 AND @PrevBatNbr=@StopBatNbr FETCH NEXT FROM SelBatches INTO @StopBatNbr --We shouldn't split a batch. Fetching of the remaining transactions of the last batch.
         END
     ELSE FETCH NEXT FROM SelBatches INTO @StopBatNbr
     SELECT @i=@i+1
     END

   IF @i%@Size<>1 OR NOT EXISTS(SELECT * FROM #Ranges) INSERT #Ranges VALUES(@StartBatNbr,'zzzzzzzzzz') --Last (or the only) page must include remaining batches.

   CLOSE SelBatches

   DEALLOCATE SelBatches

   SELECT * FROM #Ranges ORDER BY StartBatNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[GLTran_GetRanges] TO [MSDSL]
    AS [dbo];

