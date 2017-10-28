 CREATE Procedure EDFindFax @Otherid varchar(10),@Siteid varchar(10),@Partyid varchar(15),@Type varchar(1),@custaddrid varchar(10) AS
Declare @Fax varchar(30)
Select @Fax = '  '
If @Type = 'C'
 Select @Fax = fax from SOAddress where Custid = @Partyid and ShiptoID = @CustAddrid
Else  If @Type =  'V'
  Select @Fax =  fax from Vendor where Vendid = @Partyid
Else  If @Type = 'S'
 Select @Fax =  fax from Site where Siteid = @Siteid
Else
 Select @fax = Fax from address where Addrid = @Otherid
Select @Fax



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDFindFax] TO [MSDSL]
    AS [dbo];

