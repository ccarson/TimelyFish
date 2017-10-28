create Proc RCCue_VENDDUE @parm1 varchar(10) as
SELECT COUNT(*) FROM APDoc d Join Vendor v on d.VendID = v.VendID 
Where DueDate <> ' 1900/01/01' and DueDate < DateAdd(d,30,Getdate()) and DueDate >= Getdate() and d.CpnyID = @parm1 and d.Status = 'A' and d.Rlsed = 1 and d.opendoc = '1'

GO
GRANT CONTROL
    ON OBJECT::[dbo].[RCCue_VENDDUE] TO [MSDSL]
    AS [dbo];

