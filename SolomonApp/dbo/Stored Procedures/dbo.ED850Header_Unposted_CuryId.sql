 CREATE Proc ED850Header_Unposted_CuryId @CuryId varchar(4) As
Select CpnyId, EDIPOID From ED850Header Where UpdateStatus = 'OK' And CuryId = @CuryId And Exists
(Select * From EDInbound Where EDInbound.CustId = ED850Header.CustId And EDInbound.Trans In ('850','875') And EDInbound.ConvMeth In ('CH','CO','CI'))
Union
Select CpnyId, EDIPOID From ED850Header Where UpdateStatus = 'OK' And CuryId <> @CuryId And Exists
(Select * From EDInbound Where EDInbound.CustId = ED850Header.CustId And EDInbound.Trans In ('850','875') And EDInbound.ConvMeth In ('CH','CO','CI'))


