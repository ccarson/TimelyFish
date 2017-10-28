 CREATE Procedure IRInquiry_FillforInq @ComputerName Varchar(30), @SiteID VarChar(10), @InvtId varchar(30), @Revised SmallInt AS
Set NoCount On
Declare @DaysToLookAhead Float
Declare @QtyOnHandNow Float
Declare @DateStart as SmallDateTime

Set @DaysToLookAhead = 0.0
Select @DaysToLookAhead = (Select IsNull(DaysAheadToHave,0) from IR_BuckDaysAhead Where InvtId = @InvtId)
Select @DaysToLookAhead = (Select Isnull(@DaysToLookAhead,0))
-- Clear all prior info
Update IRInquiry
Set QtyBalToFcast = 0.0, QtyDesireIn = 0.0, QtyEnd = 0.0, QtyIn = 0.0, QtyRequired = 0.0, QtyStart = 0.0, InvtID = @InvtID
where ComputerName = @ComputerName

-- Regardless of flag sent in, calculate both current and revised.  This will allow quick display for switching
Set @Revised = 0
While (@Revised < 2)
Begin
	-- Update IRInquiry, fill in QtyIn, QtyOut, QtyOutFCast, QtyOutFirm
	-- Fill in In and Firm out
	If @Revised = 0
	Begin
		Update IRInquiry
		Set
			 QtyIn = IsNull((Select Sum(IsNull(QtyNeeded,0))
						from IRRequirement
						where IRRequirement.InvtId = @InvtId and IRRequirement.SiteID Like @SiteID
							and IRRequirement.DueDate between IRInquiry.DateStart and IRInquiry.DateEnd
							And IRRequirement.Revised = @Revised and IRRequirement.DocumentType in ('PO','PL')),0),
			 QtyRequired = IsNull((Select Sum((-1) * IsNull(QtyNeeded,0))
						from IRRequirement
						where IRRequirement.InvtId = @InvtId and IRRequirement.SiteID Like @SiteID
							and IRRequirement.DueDate between IRInquiry.DateStart and IRInquiry.DateEnd
							And IRRequirement.Revised = @Revised and IRRequirement.DocumentType in ('SO','PLR','SH')),0),
			 QtyBalToFcast = IsNull((Select Sum((-1) * IsNull(QtyNeeded,0))
						from IRRequirement
						where IRRequirement.InvtId = @InvtId and IRRequirement.SiteID Like @SiteID
							and IRRequirement.DueDate between IRInquiry.DateStart and IRInquiry.DateEnd
							And IRRequirement.Revised = @Revised and IRRequirement.DocumentType = 'FC'),0),
			 QtyDesireIn = IsNull((Select Sum((-1) * IsNull(QtyNeeded,0))
						from IRRequirement
						where IRRequirement.InvtId = @InvtId and IRRequirement.SiteID Like @SiteID
							and IRRequirement.DueDate between IRInquiry.DateStart and IRInquiry.DateEnd
							And IRRequirement.Revised = @Revised and IRRequirement.DocumentType = 'EXT'),0),
			 SafetyStock = IsNull((Select SafetyStk
						from Inventory
						where InvtID = @InvtID),0)
			 Where ComputerName = @ComputerName and Revised = @Revised
	End Else
	Begin
		Update IRInquiry Set
			 QtyIn = IsNull((Select Sum(IsNull(QtyRevised,0))
					from IRRequirement
					where IRRequirement.InvtId = @InvtId and IRRequirement.SiteID Like @SiteID
						and IRRequirement.DueDatePlan between IRInquiry.DateStart and IRInquiry.DateEnd
						and IRRequirement.DocumentType in ('PO','PL')),0),
			 QtyRequired = IsNull((Select Sum((-1) * IsNull(QtyRevised,0))
					from IRRequirement
					where IRRequirement.InvtId = @InvtId and IRRequirement.SiteID Like @SiteID
						and IRRequirement.DueDatePlan between IRInquiry.DateStart and IRInquiry.DateEnd
						and IRRequirement.DocumentType in ('SO','PLR','SH')),0),
			 QtyBalToFcast = IsNull((Select Sum((-1) * IsNull(QtyRevised,0))
					from IRRequirement
					where IRRequirement.InvtId = @InvtId and IRRequirement.SiteID Like @SiteID
						and IRRequirement.DueDatePlan between IRInquiry.DateStart and IRInquiry.DateEnd
						and IRRequirement.DocumentType = 'FC'),0),
			 QtyDesireIn = IsNull((Select Sum((-1) * IsNull(QtyRevised,0))
					from IRRequirement
					where IRRequirement.InvtId = @InvtId and IRRequirement.SiteID Like @SiteID
						and IRRequirement.DueDatePlan between IRInquiry.DateStart and IRInquiry.DateEnd
						and IRRequirement.DocumentType = 'EXT'),0),
			 SafetyStock = IsNull((Select SafetyStk
					from Inventory
					where InvtID = @InvtID),0)
			 Where ComputerName = @ComputerName and Revised = @Revised
	End
	-- Initialize QOH, for use in equations below
	Select @QtyOnHandNow = IsNull((Select Sum(isnull(Qtyonhand,0)) as 'QOH'
					from Location
						left outer join LocTable
							on Location.SiteId = LocTable.SiteId
							and Location.WhseLoc = LocTable.WhseLoc
					where Location.Invtid = @InvtId and Location.SiteId Like @SiteId
						and LocTable.InclQtyAvail <> 0),0)
	-- Set up Cursors now
	DECLARE	csr_Balances CURSOR
	FOR SELECT DateStart
		FROM IRInquiry
		Where ComputerName = @ComputerName and Revised = @Revised
		Order by ComputerName, DateStart FOR Update
	OPEN csr_Balances
	FETCH NEXT FROM csr_Balances INTO @DateStart
	WHILE (@@fetch_status <> -1)
	BEGIN
		-- Update the table
		Update IRInquiry
			Set
			BalBegin = @QtyOnHandNow,
			BalEnd = (@QtyOnHandNow + QtyBalToFcast + QtyEnd + QtyIn + QtyOutFcast + QtyRequired + QtyStart)
			Where Current Of csr_Balances
	--		BalEnd = (@QtyOnHandNow + QtyBalToFcast + QtyDesireIn + QtyEnd + QtyIn + QtyOutFcast + QtyRequired + QtyStart)

		-- Read terminating QOH, for use on the next row
		Select @QtyOnHandNow = BalEnd
			From IRInquiry
			Where ComputerName = @ComputerName and DateStart = @DateStart and Revised = @Revised
		FETCH NEXT FROM csr_Balances INTO @DateStart
	END
	-- Clean up cursor
	CLOSE csr_Balances
	DEALLOCATE csr_Balances
Select @Revised = (Select @Revised + 1)
End
Set NoCount Off



GO
GRANT CONTROL
    ON OBJECT::[dbo].[IRInquiry_FillforInq] TO [MSDSL]
    AS [dbo];

