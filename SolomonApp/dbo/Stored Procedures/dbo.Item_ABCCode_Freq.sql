 Create Proc Item_ABCCode_Freq
	@Siteid  Varchar(10),
        @ABCCode Varchar(2),
        @Freq_CountDate SmallDateTime

as

Update itemsite set selected = 1, countstatus = 'P'
    Where siteid = @Siteid
      And ABCCode = @ABCCode
      And LastCountDate <= @Freq_CountDate
      And CountStatus = 'A'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Item_ABCCode_Freq] TO [MSDSL]
    AS [dbo];

