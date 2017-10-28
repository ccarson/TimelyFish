 

CREATE VIEW vs_Stubdetail_Deduction AS 
    select p.RI_ID, s.EmpId, s.TypeId as EarnDedId, sum(s.EDCurrAmt) as CurrAmt
      from Stubdetail s INNER JOIN vs_PRTran_Unique_Chk p 
        ON s.Acct     = p.ChkAcct
       and s.Sub      = p.ChkSub
       and s.ChkNbr   = p.RefNbr
     where s.Stubtype = 'D'
  group by p.RI_ID, s.EmpId, s.TypeId


 
