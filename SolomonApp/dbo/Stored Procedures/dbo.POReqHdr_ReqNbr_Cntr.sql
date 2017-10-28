 /****** Object:  Stored Procedure dbo.POReqHdr_ReqNbr_Cntr    Script Date: 12/17/97 10:49:08 AM ******/
Create Procedure POReqHdr_ReqNbr_Cntr @Parm1 Varchar(10), @Parm2 Varchar(2) as
SELECT * From POReqHdr WHERE ReqNbr = @Parm1 and ReqCntr LIKE @Parm2
ORDER BY ReqNbr DESC, ReqCntr DESC


