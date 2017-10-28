 /****** Object:  Stored Procedure dbo.EntryTyp_Active    Script Date: 4/7/98 12:49:20 PM ******/
Create Proc EntryTyp_Active @parm1 varchar ( 2) as
    select * from Entrytyp
     where entryid like @parm1
    and active =  1
    order by EntryId


