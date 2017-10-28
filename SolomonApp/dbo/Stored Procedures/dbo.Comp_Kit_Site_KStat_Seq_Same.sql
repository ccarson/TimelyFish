 Create Proc Comp_Kit_Site_KStat_Seq_Same @parm1 varchar ( 30), @parm2 varchar ( 10), @parm3 varchar ( 1), @parm4beg varchar ( 5), @parm4end varchar (5) as
            Select * from Component where Kitid = @parm1
                    and KitSiteId = @parm2
                    and KitStatus = @parm3
                    and Sequence between @parm4beg and @parm4end
                    and Status = KitStatus
                    Order by Kitid, KitSiteId, KitStatus, Sequence



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Comp_Kit_Site_KStat_Seq_Same] TO [MSDSL]
    AS [dbo];

