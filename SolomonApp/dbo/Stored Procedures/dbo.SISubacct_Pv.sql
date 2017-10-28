 /****** Object:  Stored Procedure dbo.SISubacct_Pv    Script Date: 4/7/98 12:42:26 PM ******/
/****** Object:  Stored Procedure dbo.SISubacct_Pv    Script Date: 12/17/97 10:48:54 AM ******/
Create Procedure SISubacct_Pv  @Parm1 Varchar(25), @Parm2 Varchar(24) as
Select * from SubAcct where sub Like @Parm1 and sub Like @Parm2 and
Active = 1 Order by Sub



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SISubacct_Pv] TO [MSDSL]
    AS [dbo];

