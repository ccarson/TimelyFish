 Create Proc VendItem_LastCost @VendID varchar(15), @InvtID varchar(30), @AlternateID varchar(30), @SiteID varchar(10), @PerNbr varchar(6) = '' as

select coalesce(nullif(v.LastCost,0), nullif(s.LastPurchasePrice,0), s.LastCost, 0)
from APSetup (NOLOCK)
left join VendItem v on v.VendID = @VendID and v.InvtID = @InvtID and v.AlternateID = @AlternateID and v.SiteID = @SiteID --and v.FiscYr = left(coalesce(nullif(@PerNbr,''), CurrPerNbr), 4)
left join ItemSite s on s.InvtID = @InvtID and s.SiteID = @SiteID

order by LastRcvd desc



GO
GRANT CONTROL
    ON OBJECT::[dbo].[VendItem_LastCost] TO [MSDSL]
    AS [dbo];

