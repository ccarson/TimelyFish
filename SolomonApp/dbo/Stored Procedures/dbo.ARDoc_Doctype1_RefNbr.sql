 /****** Object:  Stored Procedure dbo.ARDoc_Doctype1_RefNbr    Script Date: 4/7/98 12:30:33 PM ******/
Create Procedure ARDoc_Doctype1_RefNbr @parm1 varchar ( 10), @parm2 varchar ( 10) as
    Select * from ARDoc where
	CpnyId = @parm1
	and doctype IN ('PA', 'CM', 'PP')
	and rlsed = 1
	and refnbr like @parm2
	order by CpnyId, Doctype, Refnbr


