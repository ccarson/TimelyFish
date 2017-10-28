 create proc ADG_Plan_GetInventorySettings
	@InvtID		varchar(30),
	@SiteID		varchar(10)
as
	declare	@LeadTimeDefault	float,
		@LeadTimeMax		float

	select	@LeadTimeDefault = 999,
		@LeadTimeMax = 32000

	-- Use a LEFT JOIN against ItemSite to at least get the Inventory settings if they are
	-- available. Otherwise, there is a bigger problem if there is no Inventory record.
	select	LeadTime =	case	when IT.LeadTime is null then @LeadTimeDefault
					when IT.LeadTime > @LeadTimeMax then @LeadTimeMax
					when IT.LeadTime < 1 then cast(1 as float)
				else	IT.LeadTime
				end,

		PlanExpired =	case when ((I.LotSerIssMthd = 'E') and (I.LotSerTrack in ('LI', 'SI')) and (I.SerAssign = 'R')) then
					cast(1 as smallint)
				else
					cast(0 as smallint)
				end,

		I.ShelfLife,
		I.StkItem

	from	Inventory I (nolock)

	left join
		ItemSite IT (nolock)
	on	IT.InvtID = I.InvtID
	and	IT.SiteID = @SiteID

	where	I.InvtID = @InvtID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_Plan_GetInventorySettings] TO [MSDSL]
    AS [dbo];

