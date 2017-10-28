 /****** Object:  Stored Procedure dbo.CATran_BatNbr_EntryID    Script Date: 4/7/98 12:49:20 PM ******/
Create Proc CATran_BatNbr_EntryID @parm1 varchar (10) as
select * from CATran
where batnbr = @parm1
order by entryid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CATran_BatNbr_EntryID] TO [MSDSL]
    AS [dbo];

