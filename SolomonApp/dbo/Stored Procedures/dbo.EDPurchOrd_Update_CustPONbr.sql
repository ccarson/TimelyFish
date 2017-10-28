 CREATE PROCEDURE EDPurchOrd_Update_CustPONbr  @CpnyID varchar(10), @OrdNbr varchar(15) AS

	DECLARE @RetValue varchar(10), @Remarks varchar(10)

	DECLARE @FetchStatus int
	DECLARE @POCpnyID varchar(10), @PONbr varchar(10), @POOrdNbr varchar(15)
	DECLARE @EDIPOID varchar(10)
	DECLARE @CustPODate smalldatetime, @CustPONbr varchar(30)
	DECLARE @SetupCount smallint, @DistinctOrdNbr smallint, @DistinctCustPONbr smallint
	DECLARE @CancelDate smalldatetime, @DeliveryDate smalldatetime

        -- Initialize the return values.
	SELECT @RetValue = 'NEXT', @Remarks = ''

	SELECT @POCpnyID = '', @PONbr = '', @POOrdNbr = '', @EDIPOID = '', @CustPONbr = ' '

	SELECT @SetupCount = Count(*) FROM EDSetup (NOLOCK) FULL Outer Join ANSetup (NOLOCK) On EDSetup.SetupID = ANSetup.SetupID

	-- cursor for all POAlloc records
	DECLARE crs_POAlloc CURSOR FOR
	SELECT 	DISTINCT CpnyID, PONbr
	FROM	POAlloc (NOLOCK)
	WHERE	CpnyID = @CpnyID AND SOOrdNbr = @OrdNbr

	OPEN crs_POAlloc

	FETCH NEXT FROM crs_POAlloc into @POCpnyID, @PONbr

	SELECT @FetchStatus = @@Fetch_Status
	WHILE @FetchStatus = 0 AND @SetupCount > 0
	BEGIN
		-- get CpnyID and PONbr
--		SELECT @CpnyID = '0060', @PONbr = '000014'
--		SELECT @CpnyID = CpnyID FROM PurchOrd WHERE PONbr = @PONbr

		-- get Sales Order number
		SELECT @DistinctOrdNbr = Count (DISTINCT SOOrdNbr) FROM POAlloc (NOLOCK) WHERE CpnyID = @CpnyID AND PONbr = @PONbr
		IF @DistinctOrdNbr = 1
		BEGIN
			SELECT DISTINCT @POCpnyID = CpnyID, @POOrdNbr = SOOrdNbr FROM POAlloc (NOLOCK) WHERE CpnyID = @CpnyID AND PONbr = @PONbr

			-- get EDIPOID
			SELECT @EDIPOID = EDIPOID from SOHeader (NOLOCK) WHERE CpnyID = @POCpnyID AND OrdNbr = @POOrdNbr
				-- get CustPODate and CustPONbr
			SELECT @DistinctCustPONbr = Count (DISTINCT CustPONbr) FROM ED850LineItem (NOLOCK) WHERE CpnyID = @POCpnyID AND EDIPOID = @EDIPOID
			IF @DistinctCustPONbr = 1
			BEGIN
				SELECT DISTINCT @CustPODate = CustPODate, @CustPONbr = CustPONbr FROM ED850LineItem (NOLOCK) WHERE CpnyID = @POCpnyID AND EDIPOID = @EDIPOID
			END
		END
		IF @DistinctOrdNbr <> 1 OR @DistinctCustPONbr <> 1
		BEGIN
			SELECT @CustPODate = '01/01/1900', @CustPONbr = ' '
		END

--		PRINT @CustPODate
--		PRINT @CustPONbr

		-- QN 02/24/2003, DE 231097 - get CancelDate and DeliveryDate from EDSOHeader
		SELECT @CancelDate = COALESCE(NULLIF(s.CancelDate,''),c.CancelDate,''), @DeliveryDate = COALESCE(NULLIF(s.DeliveryDate,''),c.DeliveryDate,'')
		FROM EDSOHeader s (NOLOCK) LEFT JOIN ED850HeaderExt c (NOLOCK) ON c.EDIPOID = @EDIPOID AND c.CpnyID = @POCpnyID
		WHERE	s.CpnyID = @CpnyID AND s.OrdNbr = @OrdNbr

		IF EXISTS (SELECT * FROM EDPurchOrd (NOLOCK) WHERE PONbr = @PONbr)
		BEGIN
			UPDATE EDPurchOrd
			SET	EndCustPODate = @CustPODate, EndCustPONbr = @CustPONbr,
				CancelDate = @CancelDate, DeliveryDate = @DeliveryDate
			WHERE PONbr = @PONbr
		END
		ELSE BEGIN
		Insert Into EDPurchOrd
		Select 	' ' 'AcctNbr', ' ' 'AgreeNbr', '01/01/1900' 'ArrivalDate', 0 'BackOrderFlag',
			' ' 'BatchNbr', ' ' 'BidNbr', @CancelDate 'CancelDate', ' ' 'ChangeNbr',
			' ' 'ContractNbr', '01/01/1900' 'ConvertedDate', GetDate() 'CreationDate', ' ' 'CrossDock',
			PurchOrd.Crtd_DateTime 'Crtd_Datetime', PurchOrd.Crtd_Prog 'Crtd_Prog', PurchOrd.Crtd_User 'Crtd_User', @DeliveryDate 'DeliveryDate',
			' ' 'DeptNbr', ' ' 'DistributorNbr', '01/01/1900' 'EffDate', ' ' 'EndCustPackNbr',
			@CustPODate 'EndCustPODate', @CustPONbr 'EndCustPONbr', ' ' 'EndCustSONbr', '01/01/1900' 'ExpirDate',
			IsNull(EDVendor.FOBLocQual,' ') 'FOBLocQual', 0 'Height', ' ' 'HeightUOM', '01/01/1900' 'LastEDIDate',
			0 'Len', ' ' 'LenUOM', PurchOrd.Lupd_DateTime 'Lupd_Datetime', PurchOrd.Lupd_Prog 'Lupd_Prog',
			PurchOrd.Lupd_User 'Lupd_User', 0 'NbrContainer', ' ' 'OutboundProcNbr', @PONbr 'PONbr',
			' ' 'POSuff', '01/01/1900' 'PromoEndDate', ' ' 'PromoNbr', '01/01/1900' 'PromoStartDate',
			' ' 'PurReqNbr', ' ' 'QuoteNbr', '01/01/1900' 'RequestDate', IsNull(Carrier.CarrierId,' ') 'Routing',
			' ' 'RoutingIdCode', ' ' 'RoutingIdQual', ' ' 'RoutingSeqCode', ' ' 'S4Future01',
			' ' 'S4Future02', 0 'S4Future03', 0 'S4Future04', 0 'S4Future05',
			0 'S4Future06', '01/01/1900' 'S4Future07', '01/01/1900' 'S4Future08', 0 'S4Future09',
			0 'S4Future10', ' ' 'S4Future11', ' ' 'S4Future12', ' ' 'SalesDivision',
			' ' 'Salesman', ' ' 'SalesRegion', ' ' 'SalesTerritory', '01/01/1900' 'ScheduleDate',
			'01/01/1900' 'ShipDate', IsNull(EDVendor.ShipMethPay,' ') 'ShipMthPay', '01/01/1900' 'ShipNBDate', '01/01/1900' 'ShipNLDate',
			'01/01/1900' 'ShipWeekOf', ' ' 'TranMethCode', ' ' 'User1', '01/01/1900' 'User10',
			' ' 'User2', ' ' 'User3', ' ' 'User4', 0 'User5',
			0 'User6', ' ' 'User7', ' ' 'User8', '01/01/1900' 'User9',
			0 'Volume', ' ' 'VolumeUOM', 0 'Weight', ' ' 'WeightUOM',
			0 'Width', ' ' 'WidthUOM', ' ' 'WONbr', NULL 'tstamp'
		From PurchOrd Left Outer Join EDVendor On PurchOrd.VendId = EDVendor.VendId Left Outer Join ShipVia On PurchOrd.CpnyId = ShipVia.CpnyId And PurchOrd.ShipVia = ShipVia.ShipViaId Left Outer Join Carrier On ShipVia.CarrierId = Carrier.CarrierId
		Where Not Exists(Select * From EDPurchOrd Where PONbr = @PONbr)
		END

		FETCH NEXT FROM crs_POAlloc into @POCpnyID, @PONbr
		SELECT @FetchStatus = @@Fetch_Status
	END

	CLOSE crs_POAlloc
	DEALLOCATE crs_POAlloc

	-- Return the answer.
	SELECT @RetValue, @Remarks


