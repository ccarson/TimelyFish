 Create Procedure dbo.pp_03400_APPO_INT @UserAddress char(21), @ProgID char(8), @Sol_User char(10), @Result INT OUTPUT as

/***** Update All POTran for Qty and Cost Vouchered and set the VouchStage *****/

Update p Set p.QtyVouched =  p.QtyVouched + v.qty,
             p.costvouched = CONVERT(DEC(28,3),p.costvouched) + CONVERT(DEC(28,3),v.tranamt),
             p.curycostvouched = CONVERT(DEC(28,3),p.curycostvouched) + CONVERT(DEC(28,3),v.curytranamt),
	     p.LUpd_DateTime = GETDATE(),
	     p.LUpd_Prog = @ProgID,
	     p.LUpd_User = @Sol_User,
             p.vouchstage = case when v.LineType in ('C', 'F') then
				case when (CONVERT(DEC(28,3),p.CuryCostVouched) + CONVERT(DEC(28,3),v.curytranamt) + abs(CONVERT(DEC(28,3),v.curyppv))) >= CONVERT(DEC(28,3),p.CuryExtCost)
	                         Then 'F'
                                 Else 'P'
                            	end
			    else
				case when (CONVERT(DEC(25,9),p.QtyVouched) + CONVERT(DEC(25,9),v.qty)) >= CONVERT(DEC(25,9),p.rcptqty)
                                 Then 'F'
                                 Else 'P'
				end
                            end
From POTran p, dbo.vp_03400_PO_VOQtyCost v
  Where p.rcptnbr = v.rcptnbr
    and p.lineref = v.rcptlineref
    and v.UserAddress = @UserAddress

IF @@ERROR <> 0 GOTO ABORT


/***** Update All Receipted Purchase Order Detail for Qty and Cost Vouchered and set the VouchStage *****/

Update p set p.QtyVouched =  p.QtyVouched + v.qty,
             p.costvouched = CONVERT(DEC(28,3),p.costvouched) + CONVERT(DEC(28,3),v.tranamt),
             p.curycostvouched = CONVERT(DEC(28,3),p.curycostvouched) + CONVERT(DEC(28,3),v.curytranamt),
		 p.LUpd_DateTime = GETDATE(),
		 p.LUpd_Prog = @ProgID,
	 	 p.LUpd_User = @Sol_User,
             p.vouchstage = v.vouchstage
From Purorddet p, dbo.vp_03400_UpdatePODet v
  Where p.ponbr = v.ponbr
    and p.lineref = v.lineref
    and v.useraddress = @useraddress

IF @@ERROR <> 0 GOTO ABORT

/***** Update All Purchase Order Detail for non-receipted Qty and Cost Vouchered and set the VouchStage *****/

Update p set p.QtyVouched =  p.QtyVouched + (t.qty * case when t.trantype = 'AD' then -1 else 1 end),
             p.costvouched = CONVERT(DEC(28,3),p.costvouched) + (CONVERT(DEC(28,3),t.tranamt) * case when t.trantype = 'AD' then -1 else 1 end),
             p.curycostvouched = CONVERT(DEC(28,3),p.curycostvouched) + (CONVERT(DEC(28,3),t.curytranamt) * case when t.trantype = 'AD' then -1 else 1 end),
		 p.LUpd_DateTime = GETDATE(),
	 	 p.LUpd_Prog = @ProgID,
	 	 p.LUpd_User = @Sol_User,
             p.vouchstage = Case when (CONVERT(DEC(28,3),p.curycostvouched) + (CONVERT(DEC(28,3),t.curytranamt)+ abs(CONVERT(DEC(28,3),t.curyppv))) * case when t.trantype = 'AD' then -1 else 1 end) >= CONVERT(DEC(28,3),p.CuryExtCost)
                         	Then 'F'
                         	Else 'P'
			    END,
	     p.OpenLine   = Case when (CONVERT(DEC(28,3),p.curycostvouched) + (CONVERT(DEC(28,3),t.curytranamt)+ abs(CONVERT(DEC(28,3),t.curyppv))) * case when t.trantype = 'AD' then -1 else 1 end) >= CONVERT(DEC(28,3),p.CuryExtCost)
                         	Then 0
                         	Else p.OpenLine
                            END
From Purorddet p, aptran t, wrkrelease w, purchord po
  Where p.ponbr = t.ponbr
    and p.lineref = t.polineref
    and t.batnbr = w.batnbr
    and t.trantype <> 'VC'
    and t.s4future10 = 0
    and (left(p.PurchaseType,1) = 'S' or po.potype = 'DP')
    and p.ponbr = po.ponbr
    and w.module = 'AP'
    and w.useraddress = @useraddress

IF @@ERROR <> 0 GOTO ABORT

--Update ItemSite record for Drop Ship orders
Update s set
	s.QtyOnDP = s.QtyOnDP - u.Qty
from ItemSite s
	INNER JOIN (select p.InvtID, p.SiteID, Qty = sum(t.qty * case when p.UnitMultDiv = 'D' then 1/p.CnvFact else p.CnvFact end * case when t.trantype = 'AD' then -1 else 1 end)
		FROM WRKRelease w
			INNER JOIN APTran t ON t.BatNbr = w.BatNbr AND w.UserAddress = @useraddress AND w.Module = 'AP'
			INNER JOIN PurOrdDet p ON p.ponbr = t.ponbr AND p.lineref = t.polineref
		where p.PurchaseType = 'GD'
		group by p.InvtID, p.SiteID) u ON u.InvtID = s.InvtID AND u.SiteID = s.SiteID

IF @@ERROR <> 0 GOTO ABORT

/***** Update POReceipt VouchStage on the basis of all POTran VouchStage *****/

Update p set p.LUpd_DateTime = GETDATE(),
	 	 p.LUpd_Prog = @ProgID,
	 	 p.LUpd_User = @Sol_User,
		 p.vouchstage = case When v.vouchstage =  'F' then 'F'
                                 else 'P'
                            end,
                 p.S4Future01 = v.ExtRefNbr
From vp_03400_UpdateRcpt v INNER LOOP join POReceipt p
                              on p.rcptnbr = v.rcptnbr


Where v.useraddress = @Useraddress

IF @@ERROR <> 0 GOTO ABORT

/***** Update PurchOrd VouchStage on the basis of all PurordDet VouchStage *****/

Update p set p.LUpd_DateTime = GETDATE(),
	 	 p.LUpd_Prog = @ProgID,
	 	 p.LUpd_User = @Sol_User,
		 p.vouchstage = case When v.StatusCount =  0 then 'F'
                                 else 'P'
                            end,
                 p.status = case when v.statusCount = 0 then 'M'
                                else p.status
                                end
From PurchOrd p
     join vp_03400_UpdatePO v
     on p.ponbr = v.ponbr
Where v.useraddress = @Useraddress

IF @@ERROR <> 0 GOTO ABORT

/**** Update RcptAddlCost Cost Vouched ****/

Update a set a.costvouched = CONVERT(DEC(28,3),a.costvouched) + (CONVERT(DEC(28,3),t.tranamt) * case when t.trantype = 'AD' then -1 else 1 end),
             a.curycostvouched = CONVERT(DEC(28,3),a.curycostvouched) + (CONVERT(DEC(28,3),t.curytranamt) * case when t.trantype = 'AD' then -1 else 1 end),
	    	 a.LUpd_DateTime = GETDATE(), a.LUpd_Prog = @ProgID, a.LUpd_User = @Sol_User
From RcptAddlCost a join Aptran t
     on a.rcptnbr = t.rcptnbr
     and a.AddlCostTypeID = t.invctypeid
     Join Wrkrelease w
     on t.batnbr = w.batnbr
Where w.useraddress = @useraddress
  and t.linetype = 'C'

IF @@ERROR <> 0 GOTO ABORT

/**** Update POAddlCost Cost Vouched ****/

Update a set a.costvouchered = CONVERT(DEC(28,3),a.costvouchered) + (CONVERT(DEC(28,3),t.tranamt) * case when t.trantype = 'AD' then -1 else 1 end),
             a.curycostvouched = CONVERT(DEC(28,3),a.curycostvouched) + (CONVERT(DEC(28,3),t.curytranamt) * case when t.trantype = 'AD' then -1 else 1 end),
		 a.LUpd_DateTime = GETDATE(), a.LUpd_Prog = @ProgID, a.LUpd_User = @Sol_User
From POAddlCost a join RcptAddlCost r
     on a.ponbr = r.ponbr
     and a.AddlCostTypeID = r.AddlCostTypeID
     join Aptran t
     on r.rcptnbr = t.rcptnbr
     and r.AddlCostTypeID = t.invctypeid
     Join Wrkrelease w
     on t.batnbr = w.batnbr
Where w.useraddress = @useraddress
  and t.linetype = 'C'
  and t.s4future10 = 0

IF @@ERROR <> 0 GOTO ABORT

/*****  Landed Cost *****/
/**** Update RcptAddlCost for landed cost aptrans ****/

Update a set a.APBatNbr = t.batnbr,
		 a.APRefno = t.RefNbr,
		 a.costvouched = CONVERT(DEC(28,3),a.costvouched) + (CONVERT(DEC(28,3),t.tranamt) * case when t.trantype = 'AD' then -1 else 1 end) + t.ppv,
             	 a.curycostvouched = CONVERT(DEC(28,3),a.curycostvouched) + (CONVERT(DEC(28,3),t.curytranamt) * case when t.trantype = 'AD' then -1 else 1 end)  + t.curyppv,
	    	 a.LUpd_DateTime = GETDATE(), a.LUpd_Prog = @ProgID, a.LUpd_User = @Sol_User,
                 a.vouchstatus = Case when
				  (CONVERT(DEC(28,3),a.curycostvouched) + (CONVERT(DEC(28,3),t.curytranamt)
					* case when t.trantype = 'AD'
						then -1
						else 1
					   end)
					 + CONVERT(DEC(28,3),t.curyppv)) >= CONVERT(DEC(28,3),a.CuryExpectedCost)
					 and t.s4future09 = 1
                         		Then 'F'
                         	 else
				 Case when
				  (CONVERT(DEC(28,3),a.curycostvouched) + (CONVERT(DEC(28,3),t.curytranamt)
					* case when t.trantype = 'AD'
						then -1
						else 1
					   end)
					 + CONVERT(DEC(28,3),t.curyppv)) < CONVERT(DEC(28,3),a.CuryExpectedCost)
					 and t.s4future09 = 0
					Then
					'P'
				end
				end

From RcptAddlCost a join Aptran t
     on a.rcptnbr = t.rcptnbr
     and a.AddlCostTypeID = t.invctypeid
     Join Wrkrelease w
     on t.batnbr = w.batnbr
Where w.useraddress = @useraddress
 and (t.linetype = 'C' or t.linetype = 'F')
  and t.s4future10 = 1

IF @@ERROR <> 0 GOTO ABORT

/**** Update POAddlCost for landed cost aptrans ****/

Update a set a.costvouchered = CONVERT(DEC(28,3),a.costvouchered) + (CONVERT(DEC(28,3),t.tranamt) * case when t.trantype = 'AD' then -1 else 1 end),
             a.curycostvouched = CONVERT(DEC(28,3),a.curycostvouched) + (CONVERT(DEC(28,3),t.curytranamt) * case when t.trantype = 'AD' then -1 else 1 end),
		 a.LUpd_DateTime = GETDATE(), a.LUpd_Prog = @ProgID, a.LUpd_User = @Sol_User,
             a.vouchstatus = Case when
				(CONVERT(DEC(28,3),a.curycostvouched) + (CONVERT(DEC(28,3),t.curytranamt)
					* case when t.trantype = 'AD'
						then -1
						else 1 end)
					+ CONVERT(DEC(28,3),t.curyppv)) >= CONVERT(DEC(28,3),a.CuryExpectedCost)
                         		Then 'F'
                         		Else 'P'
			    end

From POAddlCost a join RcptAddlCost r
     on a.ponbr = r.ponbr
     and a.AddlCostTypeID = r.AddlCostTypeID
     join Aptran t
     on r.rcptnbr = t.rcptnbr
     and r.AddlCostTypeID = t.invctypeid
     Join Wrkrelease w
     on t.batnbr = w.batnbr
Where w.useraddress = @useraddress
  and (t.linetype = 'C' or t.linetype = 'F')
  and t.s4future10 = 1

IF @@ERROR <> 0 GOTO ABORT

SELECT @Result = 1
GOTO FINISH

ABORT:
SELECT @Result = 0

FINISH:


