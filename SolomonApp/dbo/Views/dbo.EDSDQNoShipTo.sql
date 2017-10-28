 

CREATE View EDSDQNoShipTo As
Select Distinct A.CpnyId, A.EDIPOID, B.CustId, A.Storenbr From ED850SDQ A Inner Join ED850Header B On A.CpnyId = B.CpnyId And A.EDIPOID = B.EDIPOID
Where A.StoreNbr Not In (Select EDIShipToRef From EDSTCustomer C Where C.CustId = B.CustId) And B.UpdateStatus = 'BI'

 
