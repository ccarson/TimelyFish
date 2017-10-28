Create proc InPrjAllocTranHist_Exists @SrcNbr varchar(15), @SrcLineRef varchar (5), @SrcType varchar (3), 
                                        @TranSrcNbr varchar (15),  @TranSrcLineRef varchar (5), @TranSrcType varchar (3)
AS

  SELECT *
    FROM InPrjAllocTranHist 
   WHERE SrcNbr = @SrcNbr
     AND SrcLineRef = @SrcLineRef
     AND SrcType = @SrcType
     AND TranSrcNbr = @TranSrcNbr
     AND TranSrcLineRef = @TranSrcLineRef
     AND TranSrcType = @TranSrcType


GO
GRANT CONTROL
    ON OBJECT::[dbo].[InPrjAllocTranHist_Exists] TO [MSDSL]
    AS [dbo];

