
CREATE PROC Proj_Alloc_Qtyremain2 @InvtID    VARCHAR(30),
                                  @SiteID    VARCHAR(10),
                                  @WhseLoc   VARCHAR(10),
                                  @ProjectID VARCHAR(16),
                                  @TaskID    VARCHAR(32),
                                  @SrcNbr    VARCHAR(15)
AS
    SELECT Sum(Isnull(QtyRemaintoIssue, 0))
    FROM   InvProjAlloc WITH(NOLOCK)
    WHERE  InvtID = @InvtID
           AND SiteID = @SiteID
           AND WhseLoc = @WhseLoc
           AND ProjectID = @ProjectID
           AND TaskID = @TaskID
           AND SrcNbr = @SrcNbr 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[Proj_Alloc_Qtyremain2] TO [MSDSL]
    AS [dbo];

