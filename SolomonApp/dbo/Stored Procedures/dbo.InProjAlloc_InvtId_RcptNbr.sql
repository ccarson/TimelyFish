CREATE PROC InProjAlloc_InvtId_RcptNbr @InvtID varchar (30), @SiteID varchar (10), @RcptNbr varchar (15)  AS
   SELECT RcptAlloc = (SELECT SUM(QtyRemainToIssue)
                         FROM InvProjAlloc WITH(NOLOCK) 
                        WHERE SrcNbr = @Rcptnbr
                          AND InvtID = @InvtID
                          AND SiteID = @SiteID 
                          AND SrcType IN ('POR','PRR','GSO')),
	AllocRegInvExist =(SELECT Count(*)
                          FROM InvProjAlloc WITH(NOLOCK) 
                         WHERE InvtID = @InvtID
                           AND SiteID = @SiteID 
                           AND SrcType IN ('PIA','RFI'))


