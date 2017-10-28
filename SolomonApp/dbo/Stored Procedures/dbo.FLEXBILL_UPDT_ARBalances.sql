 create proc FLEXBILL_UPDT_ARBalances
     @ShipperID varchar(15), 
	 @CpnyID  varchar(10),  
     @BaseDecPl SMALLINT,
     @Sol_User Varchar(10)
as
    UPDATE b
       SET TotShipped = ROUND(b.TotShipped - s.BalDue, @BaseDecPl),
           LUpd_DateTime = GETDATE(),
           LUpd_Prog = '40690',
           LUpd_User = @Sol_User
      FROM AR_Balances b JOIN SoShipHeader s 
                           ON s.CustId = b.CustID 
                          AND s.CpnyID = b.CpnyID
     WHERE s.ShipperID = @ShipperID 
       AND s.CpnyID = @CpnyID
       AND s.Status = 'C'
       
