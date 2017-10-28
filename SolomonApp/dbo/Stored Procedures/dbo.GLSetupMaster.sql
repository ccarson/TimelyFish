 /****** Object:  Stored Procedure dbo.GLSetupMaster    Script Date: 4/7/98 12:38:58 PM ******/
Create Proc  GLSetupMaster as
       Select BaseCuryId,CpnyName,LastBatNbr,NbrPer,PerNbr,PerRetHist,ZCount from GLSetup



GO
GRANT CONTROL
    ON OBJECT::[dbo].[GLSetupMaster] TO [MSDSL]
    AS [dbo];

