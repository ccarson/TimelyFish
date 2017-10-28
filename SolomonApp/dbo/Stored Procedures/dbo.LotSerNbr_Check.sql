CREATE Proc LotSerNbr_Check @InvtId varchar ( 30), @SiteId varchar (10), @WhseLoc varchar (10), @ProjectID varchar (16), @TaskId varchar (32), @LotSerNbr varchar (25), @AllocatedRefNbr varchar (15) as
select * from invprojalloclot WITH (NOLOCK)  
Where  invprojalloclot.invtid = @InvtId and 
       invprojalloclot.siteid = @siteid and 
       invprojalloclot.whseloc = @whseloc and
       invprojalloclot.ProjectId = @ProjectId and
       invprojalloclot.TaskId = @TaskId and
       invprojalloclot.LotSerNbr = @LotSerNbr and 
       invprojalloclot.SrcNbr = @AllocatedRefNbr and
       invprojalloclot.SrcType IN ('GSO','PIA','POR','PRR','RFI')


GO
GRANT CONTROL
    ON OBJECT::[dbo].[LotSerNbr_Check] TO [MSDSL]
    AS [dbo];

