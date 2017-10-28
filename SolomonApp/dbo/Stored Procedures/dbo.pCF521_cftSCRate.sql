
/****** Object:  Stored Procedure dbo.pCF521_cftSCRate    Script Date: 2/3/2005 9:04:05 AM ******/

/****** Object:  Stored Procedure dbo.CF521p_cftSCRate_PPA    Script Date: 2/2/2005 1:17:45 PM ******/
CREATE   Procedure pCF521_cftSCRate @parm1 varchar (16), @parm2 varchar (16), @parm3 varchar (16)
AS
    Select * from cftSCRate 
	Where AcctCat LIKE @parm1 AND Type LIKE @parm2 AND SubType LIKE @parm3
	Order by Type, SubType
	

