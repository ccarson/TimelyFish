 /****** Object:  Stored Procedure dbo.RQItemXRef_all    Script Date: 9/4/2003 6:21:21 PM ******/

/****** Object:  Stored Procedure dbo.RQItemXRef_all    Script Date: 7/5/2002 2:44:41 PM ******/

/****** Object:  Stored Procedure dbo.RQItemXRef_all    Script Date: 1/7/2002 12:23:11 PM ******/

/****** Object:  Stored Procedure dbo.RQItemXRef_all    Script Date: 1/2/01 9:39:36 AM ******/

/****** Object:  Stored Procedure dbo.RQItemXRef_all    Script Date: 11/17/00 11:54:30 AM ******/

/****** Object:  Stored Procedure dbo.RQItemXRef_all    Script Date: 10/25/00 8:32:16 AM ******/

/****** Object:  Stored Procedure dbo.RQItemXRef_all    Script Date: 10/10/00 4:15:38 PM ******/

CREATE PROCEDURE RQItemXRef_all
	@parm1 varchar( 30 ),
	@parm2 varchar( 1 ),
	@parm3 varchar( 10 )
AS
	SELECT *
	FROM ItemXRef
	WHERE InvtID LIKE @parm1
	   AND AltIDType LIKE @parm2
	   AND EntityID LIKE @parm3
	ORDER BY InvtID,
	   AltIDType,
	   EntityID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RQItemXRef_all] TO [MSDSL]
    AS [dbo];

