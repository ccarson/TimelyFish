 create proc ADG_Plan_FixedPOSOOpen
	@InvtID		varchar(30),
	@SiteID		varchar(10),
	@QtyPrec	smallint
as
	select	isnull(sum(	(	case when L.UnitMultDiv = 'D' then
						case when L.CnvFact <> 0 then
							round(S.QtyOrd / L.CnvFact, @QtyPrec) - round(S.QtyShip / L.CnvFact, @QtyPrec)
						else
							0
						end
					else
						round(S.QtyOrd * L.CnvFact, @QtyPrec) - round(S.QtyShip * L.CnvFact, @QtyPrec)
					end) -

				(	case when D.UnitMultDiv = 'D' then
						case when D.CnvFact <> 0 then
							round(A.QtyOrd / D.CnvFact, @QtyPrec) - round(A.QtyRcvd / D.CnvFact, @QtyPrec)
						else
							0
						end
					else
						round(A.QtyOrd * D.CnvFact, @QtyPrec) - round(A.QtyRcvd * D.CnvFact, @QtyPrec)
					end)

		), 0) QtyRecvdUnshipped

	from	POAlloc A

	join	PurOrdDet D
	on	D.PONbr = A.PONbr
	and	D.LineRef = A.POLineRef

	join	PurchOrd P
	on	P.PONbr = A.PONbr

	join	SOLine L
	on	L.CpnyID = A.CpnyID
	and	L.OrdNbr = A.SOOrdNbr
	and	L.LineRef = A.SOLineRef

	join	SOSched S
	on	S.CpnyID = A.CpnyID
	and	S.OrdNbr = A.SOOrdNbr
	and	S.LineRef = A.SOLineRef
	and	S.SchedRef = A.SOSchedRef

	where	D.InvtID = @InvtID
	and	D.SiteID = @SiteID
	and	P.POType = 'OR'
	and	P.Status not in ('Q', 'X')	-- Quote, Cancelled
	and	S.Status = 'O'
	and	L.Status = 'O'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_Plan_FixedPOSOOpen] TO [MSDSL]
    AS [dbo];

