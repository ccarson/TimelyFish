 
CREATE VIEW vr_10690_INTranAccts
As

	----------------------------------------------
	-- Account INTran Records
	----------------------------------------------
	SELECT 	T.*,
		UnitCost2 = Case When T.Qty > 0 Then (T.TranAmt / T.Qty) Else 0 End, 
		Debit = Case When T.TranType = 'RC' 
				Or (T.TranType = 'CM' And B.JrnlType = 'IN') 
				Or (T.Trantype = 'AS' And T.DrCr = 'D' and T.KitID <> '')
					Then T.TranAmt
			 When ((T.TranType = 'AJ' Or T.TranType = 'PI') and (T.Qty * T.InvtMult) < 0) 
					Then T.TranAmt * -1
			 When T.TranType = 'II' 
					Then T.ExtCost + T.OvrhdAmt
			 When (T.TranType = 'AC' And T.InvtMult * T.TranAmt >= 0) 
				Or (T.TranType = 'TR' And T.ToSiteID <> '')	
					Then Abs(T.TranAmt)
			 Else Null End,

		Credit = Case When ((T.TranType = 'IN' Or T.TranType = 'DM') And B.JrnlType = 'IN') 
				Or ((T.TranType = 'AJ' Or T.TranType = 'PI') And (T.Qty * T.InvtMult) >= 0)
					Then T.TranAmt - T.OvrhdAmt
			 When T.TranType = 'AS' and T.DrCr = 'C' and T.KitID <> ''  
					Then T.TranAmt
			 When T.TranType = 'RI'
					Then T.ExtCost
			 When (T.TranType = 'AC' And T.InvtMult * T.TranAmt < 0)
					Then Abs(T.TranAmt)			 
			 When (T.TranType = 'TR' And T.ToSiteID = '')
					Then (Case When I.ValMthd = 'T' Then Abs(T.ExtCost) Else Abs(T.TranAmt) End)			 
			 Else Null End, 
				
		Account = T.Acct, 
		AccountDescr = A.Descr,
		SubAccount = T.Sub, 
		InvtDescr = IsNull(I.Descr, ''), 
		AccountType = 'Acct' 
	FROM	INTran T 
	 left join Inventory I on T.InvtID = I.InvtID  
	 Join 	Batch B on B.BatNbr = T.BatNbr 
	 left join Account A on A.Acct = T.Acct
	Where	B.Module = 'IN' 
	  And	(T.Trantype = 'RC'    
	  Or	(T.TranType = 'TR')
	  Or	(T.TranType = 'II' Or (T.TranType = 'CM' And B.JrnlType = 'IN') Or T.TranType = 'RI')
	  Or	((T.TranType = 'IN' Or T.TranType = 'DM') And B.JrnlType = 'IN')
	  Or 	(T.TranType = 'AJ' And T.JrnlType <> 'OM' Or T.TranType = 'PI')
	  Or 	(T.TranType = 'AS' and T.KitID <> '')
	  Or 	(T.TranType = 'AC'))

	UNION
	
	----------------------------------------------
	-- Inventory Account INTran Records
	----------------------------------------------
	SELECT 	T.*,
		UnitCost2 = Case When T.Qty > 0 Then (T.ExtCost / T.Qty) Else 0 End, 
		Debit = Case When (T.TranType = 'AJ' Or T.TranType = 'PI') And (T.Qty * T.InvtMult) >= 0
					Then T.TranAmt
			When T.TranType = 'CM' Or T.TranType = 'RI'
					Then T.ExtCost
			When (T.TranType = 'AC' and T.InvtMult * T.TranAmt < 0)
				Or (T.TranType = 'TR' And T.ToSiteID = '')
					Then Abs(T.TranAmt)			
			When (T.TranType = 'AS' and T.DrCr = 'D' and T.KitID = '')
					Then T.TranAmt		
			Else Null End,

		Credit = Case When T.TranType = 'RC'
					Then T.TranAmt - T.OvrhdAmt
			When T.TranType = 'II'
				Or (T.TranType = 'IN' And Not B.JrnlType = 'IN')
				Or (B.JrnlType = 'IN' And (T.TranType = 'IN' Or T.TranType = 'DM'))
					Then T.ExtCost
			When (T.TranType = 'AJ' Or T.TranType = 'PI') And (T.Qty * T.InvtMult) < 0 
					Then T.TranAmt * -1
			When (T.TranType = 'AC' and T.InvtMult * T.TranAmt >= 0) 
				Or (T.TranType = 'TR' And T.ToSiteID <> '')
					Then Abs(T.TranAmt)		
			When (T.TranType = 'AS' and T.DrCr = 'C' and T.KitID = '')
					Then T.TranAmt		
			Else Null End, 
	
		Account = T.InvtAcct, 
		AccountDescr = A.Descr,
		SubAccount = T.InvtSub, 
		InvtDescr = IsNull(I.Descr, ''),
		AccountType = 'InvtAcct'
	FROM	INTran T
	 left join Inventory I on T.InvtID = I.InvtID 
	 Join 	Batch B on B.BatNbr = T.BatNbr
	 left join Account A on A.Acct = T.InvtAcct
	Where	B.Module = 'IN'
	  And	(T.Trantype = 'RC'   
	  Or	(T.TranType = 'TR')
	  Or	(T.TranType = 'II' Or T.TranType = 'CM' Or T.TranType = 'RI')	  
	  Or	(T.TranType = 'IN' And B.JrnlType <> 'IN')
	  Or	(T.TranType = 'IN' Or T.TranType = 'DM')
	  Or 	(T.TranType In ('AJ', 'PI')) 
	  Or 	(T.TranType = 'AS' and T.KitID = '')
	  Or 	(T.TranType = 'AC'))

	UNION

	----------------------------------------------
	-- COGS Account INTran Records
	----------------------------------------------
	SELECT 	T.*,
		UnitCost2 = Case When T.Qty > 0 Then (T.ExtCost / T.Qty) Else 0 End, 
		Debit = Case When T.TranType = 'IN' and B.JrnlType <> 'IN'
					Then T.ExtCost
			 When (T.TranType = 'DM' or T.TranType = 'IN') And B.JrnlType = 'IN'
					Then T.ExtCost + T.OvrhdAmt
			 When (T.TranType = 'AJ' And T.JrnlType = 'OM' And (T.Qty * T.InvtMult) < 0)	
					Then T.TranAmt * -1
			 Else Null End,

		Credit = Case When T.TranType = 'CM' 
					Then T.ExtCost
			 When (T.TranType = 'AJ' And T.JrnlType = 'OM' And (T.Qty * T.InvtMult) >= 0)	
					Then T.TranAmt - T.OvrhdAmt
			 Else Null End,
		
		Account = T.COGSAcct, 
		AccountDescr = A.Descr,
		SubAccount = T.COGSSub, 
		InvtDescr = IsNull(I.Descr, ''),
		AccountType = 'COGSAcct'
	FROM	INTran T
	 left join Inventory I on T.InvtID = I.InvtID 
	 Join 	Batch B on B.BatNbr = T.BatNbr
	 left join Account A on A.Acct = T.COGSAcct
	Where	B.Module = 'IN'
	  And	((T.TranType = 'IN' and B.JrnlType <> 'IN')
	  Or	((T.TranType = 'IN' Or T.TranType = 'DM') And B.JrnlType = 'IN')
	  Or 	(T.TranType = 'AJ' And T.JrnlType = 'OM')
	  Or	T.TranType = 'CM')

	UNION

	----------------------------------------------
	-- AR Clearing Account INTran Records
	----------------------------------------------
	SELECT 	T.*, 
		UnitCost2 = Case When T.Qty > 0 Then (T.TranAmt / T.Qty) Else 0 End, 
		Debit = Case When (T.TranType = 'IN' Or T.TranType = 'DM') And B.JrnlType = 'IN'
					Then T.TranAmt
			 Else Null End,
		
		Credit = Case When T.TranType = 'CM' and B.JrnlType = 'IN'
					Then T.TranAmt
			 Else Null End,
			
		Account = S.ARClearingAcct, 
		AccountDescr = A.Descr,
		SubAccount = S.ARClearingSub, 
		InvtDescr = IsNull(I.Descr, ''),
		AccountType = 'ARClearingAcct'
	FROM	INTran T
	 left join Inventory I on T.InvtID = I.InvtID 
	 join 	INSetup S on 0 = 0
	 left join Account A on A.Acct = S.ARClearingAcct
	 Join 	Batch B on B.BatNbr = T.BatNbr		
	Where	B.Module = 'IN'
	  And	((T.TranType = 'IN' Or T.TranType = 'DM' Or T.TranType = 'CM') And B.JrnlType = 'IN')

	UNION

	----------------------------------------------
	-- Material Overhead Account INTran Records
	----------------------------------------------
	SELECT 	T.*,
		UnitCost2 = Case When T.Qty > 0 Then (T.TranAmt / T.Qty) Else 0 End, 
		Debit = Null,
	
		Credit = Case When (T.Trantype = 'RC' 
				Or (T.TranType = 'CM' Or T.TranType = 'DM' Or T.TranType = 'IN' Or T.TranType = 'II' Or T.TranType = 'RI'))			
					Then T.OvrhdAmt
			      When (B.EditScrnNbr = '10050' and T.TranDesc = 'Overhead Entry')
					Then T.TranAmt
			 Else Null End,

		Account = S.MatlOvhOffAcct, 
		AccountDescr = A.Descr,
		SubAccount = S.MatlOvhOffSub, 
		InvtDescr = IsNull(I.Descr, ''),
		AccountType = 'MatlOvhOffAcct'
	FROM	INTran T  
	 left join Inventory I on T.InvtID = I.InvtID 
	 join	INSetup S on 0 = 0
	 left join Account A on A.Acct = S.MatlOvhOffAcct
	 Join 	Batch B on B.BatNbr = T.BatNbr		
	Where	B.Module = 'IN'
	  And	T.OvrhdAmt > 0
	  And	(T.Trantype = 'RC'   
	  Or	(T.TranType = 'CM' Or T.TranType = 'DM' Or T.TranType = 'IN' Or T.TranType = 'II' Or T.TranType = 'RI') 
	  Or	(B.EditScrnNbr = '10050' and T.TranDesc = 'Overhead Entry'))

	UNION

	----------------------------------------------
	-- Variance Account INTran Records
	----------------------------------------------
	SELECT 	T.*,
		UnitCost2 = Case When T.Qty > 0 Then (T.TranAmt / T.Qty) Else 0 End, 	
		Debit = CASE WHEN T.DrCr = 'D'
			THEN
				CASE WHEN T.TranAmt >= 0 THEN T.TranAmt	ELSE NULL END
			ELSE
				CASE WHEN T.TranAmt <= 0 THEN -T.TranAmt ELSE NULL END
			END,	
		Credit = CASE WHEN T.DrCr = 'C'
			THEN
				CASE WHEN T.TranAmt > 0 THEN T.TranAmt ELSE NULL END
			ELSE
				CASE WHEN T.TranAmt < 0 THEN -T.TranAmt ELSE NULL END
			END,	
		Account = S.DfltVarAcct, 
		AccountDescr = A.Descr,
		SubAccount = S.DfltVarSub, 
		InvtDescr = IsNull(I.Descr, ''),
		AccountType = 'VarianceAcct'
	FROM	INTran T  
	 left join Inventory I on T.InvtID = I.InvtID 
	 join	INSetup S on 0 = 0
	 left join Account A on A.Acct = S.DfltVarAcct
	 Join 	Batch B on B.BatNbr = T.BatNbr		
	Where	B.Module = 'IN'
	  And	T.TranDesc = 'Standard Cost Variance'	


 
