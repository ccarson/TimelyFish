 

CREATE VIEW vs_PRTran_Unique_Chk AS 
    select r.RI_ID, t.ChkAcct, t.ChkSub, t.RefNbr
      from RPTRuntime r 
     CROSS JOIN PRTran t
      LEFT OUTER JOIN VPSetup v ON v.SetupId='VP'
      LEFT OUTER JOIN PRBatinfo b ON t.Batnbr=b.Batnbr
     where t.Rlsed  <> 0 
       And t.Paid   <> 0 
       And ((t.TranType = 'CK' And t.TimeShtFlg <> 0) Or t.TranType = 'HC')
       And Datediff(Month,
                    case when v.WeekEndOpt = 'Y' 
                         then isnull(b.WeekEnd,t.Trandate)
                         else t.Trandate end,
                    Reportdate) = 0 
  group by r.RI_ID, t.ChkAcct, t.ChkSub, t.RefNbr


 
