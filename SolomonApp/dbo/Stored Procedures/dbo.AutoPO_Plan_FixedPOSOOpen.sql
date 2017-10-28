 create proc AutoPO_Plan_FixedPOSOOpen
	@InvtID		varchar(30),
	@SiteID		varchar(10),
	@QtyPrec	smallint
as

	SELECT	ISNULL(SUM(	(CASE WHEN L.UnitMultDiv = 'D'
                              THEN CASE WHEN L.CnvFact <> 0
                                        THEN round(S.QtyOrd / L.CnvFact, @QtyPrec) - round(S.QtyShip / L.CnvFact, @QtyPrec)
						                ELSE 0
						            END
					          ELSE round(S.QtyOrd * L.CnvFact, @QtyPrec) - round(S.QtyShip * L.CnvFact, @QtyPrec)
					      END) -

				        (CASE WHEN D.UnitMultDiv = 'D'
                              THEN CASE WHEN D.CnvFact <> 0
                                        THEN round(A.QtyOrd / D.CnvFact, @QtyPrec) - round(A.QtyRcvd / D.CnvFact, @QtyPrec)
						                ELSE 0
						            END
					          ELSE round(A.QtyOrd * D.CnvFact, @QtyPrec) - round(A.QtyRcvd * D.CnvFact, @QtyPrec)
					      END)), 0) QtyRecvdUnshipped

      FROM POAlloc A JOIN PurOrdDet D
                       ON D.PONbr = A.PONbr
                      AND D.LineRef = A.POLineRef

                     JOIN PurchOrd P
                       ON P.PONbr = A.PONbr

                     JOIN SOLine L
                       ON L.CpnyID = A.CpnyID
                      AND L.OrdNbr = A.SOOrdNbr
                      AND L.LineRef = A.SOLineRef

                     JOIN SOSched S
                       ON S.CpnyID = A.CpnyID
                      AND S.OrdNbr = A.SOOrdNbr
                      AND S.LineRef = A.SOLineRef
                      AND S.SchedRef = A.SOSchedRef

					 JOIN SOHeader H
                       ON H.OrdNbr = S.OrdNbr

    WHERE D.InvtID = @InvtID
      AND D.SiteID = @SiteID
      AND P.POType = 'OR'                    --Regular Order
      AND P.Status IN ('O', 'P')	         -- Open Orders, Purchase Order
      AND S.Status = 'O'
      AND L.Status = 'O'
      AND (L.AutoPO = '1' OR S.AutoPO = '1') --Auto Create PO
      AND H.ShipCmplt = '1'                  -- Ship Complete



