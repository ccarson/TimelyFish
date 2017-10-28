create Proc RCCue_VENDOVDU @parm1 varchar(10) as
SELECT COUNT(*) FROM APDoc d Join Vendor v on d.VendID = v.VendID
Where DueDate <> ' 1900/01/01' and DATEDIFF(day, DueDate, Getdate()) > 0 and d.CpnyID = @parm1 and d.Status = 'A' and d.Rlsed = 1 and d.opendoc = '1'

GO
GRANT CONTROL
    ON OBJECT::[dbo].[RCCue_VENDOVDU] TO [MSDSL]
    AS [dbo];

