create PROCEDURE ADG_InvtProjAllocTranHist
 @CpnyID varchar(10),
 @SrcType varchar(3),  
 @SrcNbr varchar(15),  
 @SrcLineRef varchar(5)
AS  

Select * from INPrjAllocTranHist 
Where CpnyID = @CpnyID And SrcType = @SrcType And SrcNbr = @SrcNbr And SrcLineRef = @SrcLineRef
Order By RecordID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_InvtProjAllocTranHist] TO [MSDSL]
    AS [dbo];

