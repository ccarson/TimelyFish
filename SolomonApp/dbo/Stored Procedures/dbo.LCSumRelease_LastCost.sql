 Create proc LCSumRelease_LastCost
	@RcptNbr varchar(15),
	@Invtid Varchar (30),
	@SiteID Varchar(10)
as
Select Sum(tranamt)
from
	Intran WITH(NOLOCK)
where
	RcptNbr = @RcptNbr
	and Invtid = @InvtID
	and SiteID = @SiteID
	and jrnltype = 'LC'


