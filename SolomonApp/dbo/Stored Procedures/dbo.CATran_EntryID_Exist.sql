 /****** Object:  Stored Procedure dbo.CATran_EntryID_Exist    Script Date: 4/7/98 12:49:20 PM ******/
create Proc CATran_EntryID_Exist @parm1 varchar ( 2) as
  Select * from CATran
  Where EntryID = @parm1
 Order by EntryId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CATran_EntryID_Exist] TO [MSDSL]
    AS [dbo];

