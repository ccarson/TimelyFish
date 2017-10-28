--DROP Procedure [dbo].[cfp_RunningInventory]
--GO
CREATE Procedure [dbo].[cfp_RunningInventory]
        @INVID  varchar(20),
        @CMPYID varchar(10),
        @SiteId varchar(10),
        @StartYr varchar(8)

AS

	-- select @INVID = '11025', @CMPYID = 'CFF', @SiteId = '100', @StartYr = '2006'


	--===== Drop the temp table if it exists
		 IF OBJECT_ID('tempdb..#TmpInvData','U') IS NOT NULL
			DROP TABLE #TmpInvData
	;
	--===== Create and populate the temp table on the fly
	 SELECT invtid
		  ,[Acct]
		  ,[BatNbr]
		  ,[ProjectID]
		  ,[FiscYr]
		  ,[PerEnt]
		  ,[PerPost]
		  ,([invtmult]*[Qty]) as QTY
		  ,CONVERT([numeric](19, 5), NULL) as 'RunningTotal'
		  ,[ExtCost]
		  ,[UnitPrice]
		  ,[TranAmt]
		  ,[RefNbr]
		  ,[Sub]
		  ,[ToSiteID]
		  ,[ToWhseLoc]
		  ,[TranType]
		  ,[TranDate]
		  ,[Crtd_DateTime]
		  ,[Crtd_User]
		  ,[LUpd_DateTime]
		  ,[LUpd_Prog]
		  ,[LUpd_User]
	   INTO #TmpInvData
	   FROM solomonapp.dbo.[INTran]
	   where InvtID = @INVID
		and SiteID = @SiteId
		and CpnyID = @CMPYID
		and FiscYr >= @StartYr
		and TranType in ('II','RC','AJ','RI','TR','PI')
	;

	--===== Declare some essential variables with obvious names to reflect their use
	DECLARE @PrevItem VARCHAR(100),
			@PrevBal  [numeric](19, 5),
			@Counter  INT
	;
	--===== Preset the counter variable and Beginning balance.
	SELECT @Counter = 1
	;
	Select @PrevBal = BegQty from solomonapp.dbo.item2hist where InvtID=@INVID and FiscYr = @StartYr and SiteID=@SiteId 
	;
	
	if (@PrevBal is null)
	  select @PrevBal=0
    ;
	--===== This produces an ordered, running total update.  It has a built in fault detector that will let you know if
		 -- a failure occured.  That same fault detector is what makes the ordered update work even when the clustered 
		 -- index is in a totally different order.  This type of update is affectionately known as the "Quirky Update"
		 -- and it's a powerful tool to learn.  Special thanks to Paul White and Tom Thompson for the fault detector.
	;
	WITH
	cteSort AS
	(
	 SELECT Counter = ROW_NUMBER() OVER(ORDER BY fiscyr, trandate),
			*
	   FROM #TmpInvData
	)
	 UPDATE tgt
		SET @PrevBal = RunningTotal = CASE WHEN tgt.Counter = @Counter 
									  THEN  tgt.Qty + @PrevBal
									   ELSE 1/0 --Force error if out of sequence
								   END,
			@PrevItem = invtid,
			@Counter  = @Counter + 1
	   FROM cteSort tgt WITH (TABLOCKX) --Absolutely essential, we don't want anyone sneaking in while we're updating
	  OPTION (MAXDOP 1)                 --Parallelism must be prevented for the serial nature of this update
	;
	--===== Display the test data after the running total update
	 SELECT * FROM #TmpInvData ORDER BY FiscYr, Crtd_DateTime
	 ;

	--===== Explicitly drop the temp table ... probably not required
		 IF OBJECT_ID('tempdb..#TmpInvData','U') IS NOT NULL
			DROP TABLE #TmpInvData
	;


