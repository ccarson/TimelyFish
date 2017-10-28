 Create Procedure Update_AP_PRTran @parm1 varchar(10), @parm2 varchar(10) As
update pr
	set APBatch = "", APRefnbr = "", APLineID = 0
	from prtran pr
	where 	pr.APBatch = @parm1 and
		pr.APRefnbr = @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Update_AP_PRTran] TO [MSDSL]
    AS [dbo];

