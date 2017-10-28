 Create Proc  CalcChkDet_SUM_CurrEarnDedAmt @EmpId varchar (10), @EDType varchar (1), @WrkLocId varchar (6), @EarnDedId varchar (10)  as
   Select sum(CurrEarnDedAmt) from CalcChkDet d, CalcChk c
           where d.EmpId     =    @EmpId
             and d.EDType    LIKE @EDType
             and d.WrkLocId  =    @WrkLocId
             and d.EarnDedId =    @EarnDedId
             and d.EmpId     =    c.EmpId
             and d.ChkSeq    =    c.ChkSeq
             and c.CheckNbr  <>   ''


