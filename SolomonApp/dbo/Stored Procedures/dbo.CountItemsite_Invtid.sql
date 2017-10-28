 Create Procedure CountItemsite_Invtid  @Invtid Varchar(30)

As

Select Count(*) from Itemsite
where Invtid = @Invtid
  And (qtyonhand <> 0
       or qtyonpo <> 0
       or QtyCustOrd <> 0)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CountItemsite_Invtid] TO [MSDSL]
    AS [dbo];

