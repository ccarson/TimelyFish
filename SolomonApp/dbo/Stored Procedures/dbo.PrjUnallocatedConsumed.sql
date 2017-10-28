Create proc PrjUnallocatedConsumed 
    @InvtID	varchar(30),
    @SiteID	varchar(10),
    @WhseLoc    varchar(10),
    @ProjectID  varchar(16),
    @TaskID     varchar(32),
    @CpnyID     varchar (10),
    @RefNbr     varchar (15)
as
Select ISNULL(Sum(t.QuantityStock),0) from InprojAlloctran t (nolock)
		join INProjAllocDoc d (nolock) on d.RefNbr = t.RefNbr
		where		t.Invtid = @InvtID AND
                  	t.SiteId = @SiteId AND
                  	t.ProjectID = @ProjectID AND
                  	t.TaskID = @TaskID AND
                  	t.WhseLoc = @WhseLoc AND
                  	t.CpnyID = @CpnyID AND
                  	t.RefNbr <> @RefNbr  AND
                  	t.UnallocSrcNbr <> '' AND
                  	d.Handling = 'I'
             

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PrjUnallocatedConsumed] TO [MSDSL]
    AS [dbo];

