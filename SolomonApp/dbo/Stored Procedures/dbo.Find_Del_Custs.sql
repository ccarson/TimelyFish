 Create proc Find_Del_Custs @parm1 smalldatetime as
Select c.custid from customer c, vt_08550CustBalSum v where

c.custid = v.custid and
v.LastActDate < @parm1 and
v.TotFutureBal = 0 and
v.TotCurrBal = 0


