 create proc WO_ItemSite_Loc_LotSerMst_Reset
   @ProgID        varchar (8),
   @UserID        varchar (10),
   @ErrorCode     smallint OUTPUT
as
   set nocount on

   Update ItemSite
   Set QtyWOFirmSupply = 0,
       QtyWORlsedSupply = 0,
       QtyWOFirmDemand = 0,
       QtyWORlsedDemand = 0

	if (@@error = 0)
		print 'ItemSite Reset complete'
	else
		begin
			print 'ItemSite Reset error'
			select @ErrorCode = 1
			goto FINISH
		end

   Update Location
   Set QtyWORlsedDemand = 0
	if (@@error = 0)
		print 'Location Reset complete'
	else
		begin
			print 'Location Reset error'
			select @ErrorCode = 2
			goto FINISH
		end

   Update LotSerMst
   Set QtyWORlsedDemand = 0
	if (@@error = 0)
		print 'LotSerMst Reset complete'
	else
		begin
			print 'LotSerMst Reset error'
			select @ErrorCode = 2
			goto FINISH
		end

FINISH:



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WO_ItemSite_Loc_LotSerMst_Reset] TO [MSDSL]
    AS [dbo];

