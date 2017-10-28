 CREATE PROCEDURE WOPurOrdDet_PurchOrd_Filter
   @InvtID        	varchar( 30 ),
   @SiteID        	varchar( 10 ),
   @PromDateBeg   	smalldatetime,
   @PromDateEnd   	smalldatetime,
   @PODateBeg		smalldatetime,
   @PODateEnd		smalldatetime,
   @VendID		varchar( 15 ),
   @Status		varchar( 1 ),
   @POType		varchar( 2 )

AS
   SELECT      	d.*,
		p.blktponbr,
		p.buyer,
		p.podate,
		p.ponbr,
		p.potype,
		p.status,
		p.terms,
		p.vendid,
		p.vendname
   FROM        	PurOrdDet d LEFT JOIN PurchOrd p
               	ON d.PONbr = p.PONbr
   WHERE       	d.InvtID = @InvtID and
               	d.SiteID LIKE @SiteID and
               	d.PromDate BETWEEN @PromDateBeg and @PromDateEnd and
               	p.PODate BETWEEN @PODateBeg and @PODateEnd and
		p.Vendid LIKE @VendID and
		p.Status LIKE @Status and
		p.POType LIKE @POType
   ORDER BY    	d.PONbr DESC, d.LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOPurOrdDet_PurchOrd_Filter] TO [MSDSL]
    AS [dbo];

