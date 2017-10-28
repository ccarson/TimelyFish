 CREATE PROCEDURE DMG_SOPlan_UpdateDelete
   	@SupplyDemandType 	varchar(2),
	@DeleteSOPlan		smallint,
   	@ComputerName     	varchar(21),
   	@CpnyID           	varchar(10),
	@RefNbr           	Varchar(16),
	@LineRef          	varchar(5),
	@SchedRef         	varchar(5),
	@WOTask			varchar(32),
	@Crtd_Prog		Varchar(8),
	@Crtd_User		Varchar(10)

AS

   SET NOCOUNT ON

	-- Update the appropriate bucket

	-- Only Supply side plan records
	-- Skips SO bound SOPlan records
	IF @SupplyDemandType = 'PO'
	BEGIN

		INSERT INTO INUpdateQty_Wrk
		(ComputerName, InvtID, SiteID, Crtd_DateTime, Crtd_Prog, Crtd_User, LUpd_DateTime,
		 LUpd_Prog, LUpd_User, UpdatePO)
		SELECT	distinct @ComputerName, InvtID, SiteID,
	       		Convert(SmallDateTime, GetDate()), @Crtd_Prog, @Crtd_User,
	       		Convert(SmallDateTime, GetDate()), @Crtd_Prog, @Crtd_User, 1
		FROM	SOPlan p WITH(NOLOCK)
		WHERE	NOT EXISTS (	Select *
					From	INUpdateQty_Wrk INU
					Where	INU.ComputerName = @ComputerName
						AND INU.InvtID = p.InvtID
						AND INU.SiteID = p.SiteID)
			AND p.Cpnyid = @CpnyID
			AND p.PONbr = @RefNbr
			AND p.POLineRef LIKE @LineRef
			AND p.POLineRef <> ''
			AND p.PlanType NOT IN ('50')

		UPDATE	INUpdateQty_Wrk
		SET	UpdatePO = 1
		FROM	SOPlan p WITH(NOLOCK)
			JOIN INUpdateQty_Wrk INU
				ON INU.InvtID = p.InvtID AND INU.SiteID = p.SiteID
		WHERE	INU.ComputerName = @ComputerName
			AND p.Cpnyid = @CpnyID
			AND p.PONbr = @RefNbr
			AND p.POLineRef LIKE @LineRef
			AND p.POLineRef <> ''
			AND p.PlanType NOT IN ('50')
			AND INU.UpdatePO <> 1

		IF @DeleteSOPlan = 1
			DELETE FROM	SOPlan
			WHERE	Cpnyid = @CpnyID
				AND PONbr = @RefNbr
				AND POLineRef LIKE @LineRef
				AND POLineRef <> ''
				AND PlanType NOT IN ('50')
	END
		-- Shipper Demand and Supply
  	ELSE IF @SupplyDemandType = 'SH'
	BEGIN
		--   Supply
		--     Includes Kit Assy and/or TransferOrder Supply (26, 29)

		INSERT INTO INUpdateQty_Wrk
		(ComputerName, InvtID, SiteID, Crtd_DateTime, Crtd_Prog, Crtd_User, LUpd_DateTime,
		 LUpd_Prog, LUpd_User, UpdateSO)
		SELECT	distinct @ComputerName, InvtID, SiteID,
	       		Convert(SmallDateTime, GetDate()), @Crtd_Prog, @Crtd_User,
	       		Convert(SmallDateTime, GetDate()), @Crtd_Prog, @Crtd_User, 1
		FROM	SOPlan p WITH(NOLOCK)
		WHERE	NOT EXISTS (	Select *
					From	INUpdateQty_Wrk INU
					Where	INU.ComputerName = @ComputerName
						AND INU.InvtID = p.InvtID
						AND INU.SiteID = p.SiteID)
			AND p.Cpnyid = @CpnyID
	      	AND p.SOShipperID = @RefNbr
	        AND ((p.SOShipperLineRef LIKE @LineRef AND p.SOShipperLineRef <> '')
				OR (p.PlanType IN ('26', '29')))

		UPDATE	INUpdateQty_Wrk
		SET	UpdateSO = 1
		FROM	SOPlan p WITH(NOLOCK)
			JOIN INUpdateQty_Wrk INU
				ON INU.InvtID = p.InvtID AND INU.SiteID = p.SiteID
		WHERE	INU.ComputerName = @ComputerName
           	AND p.Cpnyid = @CpnyID
	      	AND p.SOShipperID = @RefNbr
	        AND ((p.SOShipperLineRef LIKE @LineRef AND p.SOShipperLineRef <> '')
				OR (p.PlanType IN ('26', '29')))
			AND INU.UpdateSO <> 1

		IF @DeleteSOPlan = 1
			DELETE FROM	SOPlan
			WHERE	Cpnyid = @CpnyID
				AND SOShipperID = @RefNbr
				AND ((SOShipperLineRef LIKE @LineRef AND SOShipperLineRef <> '')
					OR (PlanType In ('26', '29')))
	END

	-- Shipper Supply Only
	ELSE IF @SupplyDemandType = 'HS'
	BEGIN
		-- Supply
		--   Includes Kit Assy and/or TransferOrder Supply (26, 29)

		INSERT INTO INUpdateQty_Wrk
		(ComputerName, InvtID, SiteID, Crtd_DateTime, Crtd_Prog, Crtd_User, LUpd_DateTime,
		 LUpd_Prog, LUpd_User, UpdateSO)
		SELECT	distinct @ComputerName, InvtID, SiteID,
	       		Convert(SmallDateTime, GetDate()), @Crtd_Prog, @Crtd_User,
	       		Convert(SmallDateTime, GetDate()), @Crtd_Prog, @Crtd_User, 1
		FROM	SOPlan p WITH(NOLOCK)
		WHERE	NOT EXISTS (	Select *
					From	INUpdateQty_Wrk INU
					Where	INU.ComputerName = @ComputerName
						AND INU.InvtID = p.InvtID
						AND INU.SiteID = p.SiteID)
			AND p.Cpnyid = @CpnyID
			AND p.SOShipperID = @RefNbr
			AND p.PlanType IN ('26', '29')

		UPDATE	INUpdateQty_Wrk
		SET	UpdateSO = 1
		FROM	SOPlan p WITH(NOLOCK)
			JOIN INUpdateQty_Wrk INU
				ON INU.InvtID = p.InvtID AND INU.SiteID = p.SiteID
		WHERE	INU.ComputerName = @ComputerName
			AND p.Cpnyid = @CpnyID
			AND p.SOShipperID = @RefNbr
			AND p.PlanType IN ('26', '29')
			AND INU.UpdateSO <> 1

		IF @DeleteSOPlan = 1
			DELETE FROM	SOPlan
			WHERE	Cpnyid = @CpnyID
				AND SOShipperID = @RefNbr
				AND PlanType IN ('26', '29')
	END

	-- Sales Order Demand and Supply
	ELSE IF @SupplyDemandType = 'SO'
	BEGIN
		-- Demand
		--   Skips WO bound SOPlan records (Firm-17, Released-18)
		--   Skips PO bound SOPlan records (21)
		-- Supply
		--   Includes Kit Assy and/or TransferOrder Supply (25, 28)

		INSERT INTO INUpdateQty_Wrk
		(ComputerName, InvtID, SiteID, Crtd_DateTime, Crtd_Prog, Crtd_User, LUpd_DateTime,
		 LUpd_Prog, LUpd_User, UpdateSO)
		SELECT	distinct @ComputerName, InvtID, SiteID,
	       		Convert(SmallDateTime, GetDate()), @Crtd_Prog, @Crtd_User,
	       		Convert(SmallDateTime, GetDate()), @Crtd_Prog, @Crtd_User, 1
		FROM	SOPlan p WITH(NOLOCK)
		WHERE	NOT EXISTS (	Select *
					From	INUpdateQty_Wrk INU
					Where	INU.ComputerName = @ComputerName
						AND INU.InvtID = p.InvtID
						AND INU.SiteID = p.SiteID)
			AND p.Cpnyid = @CpnyID
			AND p.SOOrdNbr = @RefNbr
			AND ((p.SOLineRef LIKE @LineRef AND p.SOLineRef <> ''
					AND p.SOSchedRef LIKE @SchedRef AND p.SOSchedRef <> ''
					AND p.PlanType NOT IN ('17', '18', '21'))
				OR (p.PlanType IN ('25', '28')))

		UPDATE	INUpdateQty_Wrk
		SET	UpdateSO = 1
		FROM	SOPlan p WITH(NOLOCK)
			JOIN INUpdateQty_Wrk INU
				ON INU.InvtID = p.InvtID AND INU.SiteID = p.SiteID
		WHERE	INU.ComputerName = @ComputerName
			AND p.Cpnyid = @CpnyID
			AND p.SOOrdNbr = @RefNbr
			AND ((p.SOLineRef LIKE @LineRef AND p.SOLineRef <> ''
					AND p.SOSchedRef LIKE @SchedRef AND p.SOSchedRef <> ''
					AND p.PlanType NOT IN ('17', '18', '21'))
				OR (p.PlanType IN ('25', '28')))
			AND INU.UpdateSO <> 1

		IF @DeleteSOPlan = 1
			DELETE FROM	SOPlan
			WHERE	Cpnyid = @CpnyID
				AND SOOrdNbr = @RefNbr
				AND ((SOLineRef LIKE @LineRef AND SOLineRef <> ''
						AND SOSchedRef LIKE @SchedRef AND SOSchedRef <> ''
						AND PlanType NOT IN ('17', '18', '21'))
					OR (PlanType In ('25', '28')))
	END

	ELSE IF @SupplyDemandType = 'SS'
	BEGIN
		-- Supply
		--   Includes Kit Assy and/or TransferOrder Supply (25, 28)

		INSERT INTO INUpdateQty_Wrk
		(ComputerName, InvtID, SiteID, Crtd_DateTime, Crtd_Prog, Crtd_User, LUpd_DateTime,
		 LUpd_Prog, LUpd_User, UpdateSO)
		SELECT	distinct @ComputerName, InvtID, SiteID,
	       		Convert(SmallDateTime, GetDate()), @Crtd_Prog, @Crtd_User,
	       		Convert(SmallDateTime, GetDate()), @Crtd_Prog, @Crtd_User, 1
		FROM	SOPlan p WITH(NOLOCK)
		WHERE	NOT EXISTS (	Select *
					From	INUpdateQty_Wrk INU
					Where	INU.ComputerName = @ComputerName
						AND INU.InvtID = p.InvtID
						AND INU.SiteID = p.SiteID)
			AND p.Cpnyid = @CpnyID
			AND p.SOOrdNbr = @RefNbr
			AND p.PlanType IN ('25', '28')

		UPDATE	INUpdateQty_Wrk
		SET	UpdateSO = 1
		FROM	SOPlan p WITH(NOLOCK)
			JOIN INUpdateQty_Wrk INU
				ON INU.InvtID = p.InvtID AND INU.SiteID = p.SiteID
		WHERE	INU.ComputerName = @ComputerName
			AND p.Cpnyid = @CpnyID
			AND p.SOOrdNbr = @RefNbr
			AND p.PlanType IN ('25', '28')
			AND INU.UpdateSO <> 1

		IF @DeleteSOPlan = 1
			DELETE FROM	SOPlan
			WHERE	Cpnyid = @CpnyID
				AND SOOrdNbr = @RefNbr
				AND PlanType IN ('25', '28')
	END

	-- Work Order Supply
	ELSE IF @SupplyDemandType = 'WS'
		-- Only Supply side plan records
		-- Skips SO bound SOPlan records
	BEGIN

		INSERT INTO INUpdateQty_Wrk
		(ComputerName, InvtID, SiteID, Crtd_DateTime, Crtd_Prog, Crtd_User, LUpd_DateTime,
		 LUpd_Prog, LUpd_User, UpdateWOSupply)
		SELECT	distinct @ComputerName, InvtID, SiteID,
	       		Convert(SmallDateTime, GetDate()), @Crtd_Prog, @Crtd_User,
	       		Convert(SmallDateTime, GetDate()), @Crtd_Prog, @Crtd_User, 1
		FROM	SOPlan p WITH(NOLOCK)
		WHERE	NOT EXISTS (	Select *
					From	INUpdateQty_Wrk INU
					Where	INU.ComputerName = @ComputerName
						AND INU.InvtID = p.InvtID
						AND INU.SiteID = p.SiteID)
			AND p.Cpnyid = @CpnyID
			AND p.WONbr = @RefNbr
			AND p.WOBTLineRef LIKE @LineRef
			AND p.WOBTLineRef <> ''
			AND p.PlanType NOT IN ('54')

		UPDATE	INUpdateQty_Wrk
		SET	UpdateWOSupply = 1
		FROM	SOPlan p WITH(NOLOCK)
			JOIN INUpdateQty_Wrk INU
				ON INU.InvtID = p.InvtID AND INU.SiteID = p.SiteID
		WHERE	INU.ComputerName = @ComputerName
			AND p.CpnyID = @CpnyID
			AND p.WONbr = @RefNbr
			AND p.WOBTLineRef LIKE @LineRef
			AND p.WOBTLineRef <> ''
			AND p.PlanType NOT IN ('54')
			AND INU.UpdateWOSupply <> 1

		IF @DeleteSOPlan = 1
			DELETE FROM	SOPlan
			WHERE	CpnyID = @CpnyID
				AND WONbr = @RefNbr
				AND WOBTLineRef LIKE @LineRef
				AND WOBTLineRef <> ''
				AND PlanType NOT IN ('54')
	END

	-- Work Order Demand
	ELSE IF @SupplyDemandType = 'WD'
	BEGIN

		INSERT INTO INUpdateQty_Wrk
		(ComputerName, InvtID, SiteID, Crtd_DateTime, Crtd_Prog, Crtd_User, LUpd_DateTime,
		 LUpd_Prog, LUpd_User, UpdateWODemand)
		SELECT	distinct @ComputerName, InvtID, SiteID,
	       		Convert(SmallDateTime, GetDate()), @Crtd_Prog, @Crtd_User,
	       		Convert(SmallDateTime, GetDate()), @Crtd_Prog, @Crtd_User, 1
		FROM	SOPlan p WITH(NOLOCK)
		WHERE	NOT EXISTS (	Select *
					From	INUpdateQty_Wrk INU
					Where	INU.ComputerName = @ComputerName
						AND INU.InvtID = p.InvtID
						AND INU.SiteID = p.SiteID)
			AND p.Cpnyid = @CpnyID
			AND p.WONbr = @RefNbr
			AND p.WOTask LIKE @WOTask
			AND p.WOMRLineRef LIKE @LineRef
			AND p.WOMRLineRef <> ''

		UPDATE	INUpdateQty_Wrk
		SET	UpdateWODemand = 1
		FROM	SOPlan p WITH(NOLOCK)
			JOIN INUpdateQty_Wrk INU
				ON INU.InvtID = p.InvtID
		WHERE	INU.ComputerName = @ComputerName
			AND p.Cpnyid = @CpnyID
			AND p.WONbr = @RefNbr
			AND p.WOTask LIKE @WOTask
			AND p.WOMRLineRef LIKE @LineRef
			AND p.WOMRLineRef <> ''
			AND INU.UpdateWODemand <> 1

		IF @DeleteSOPlan = 1
			DELETE FROM	SOPlan
			WHERE	Cpnyid = @CpnyID
				AND WONbr = @RefNbr
				AND WOTask LIKE @WOTask
				AND WOMRLineRef LIKE @LineRef
				AND WOMRLineRef <> ''
	END



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOPlan_UpdateDelete] TO [MSDSL]
    AS [dbo];

