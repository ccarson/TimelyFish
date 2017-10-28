
/****** Object:  Stored Procedure dbo.CF345p_cfvMills_All    Script Date: 11/30/2005 2:09:28 PM ******/
/****** Object:  Stored Procedure dbo.CF345p_cfvMills_All    Script Date: 9/6/2005 12:40:13 PM ******/

CREATE   Procedure CF345p_cfvMills_All  as 
    Select * from cfvMills 
    order by MillID




GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CF345p_cfvMills_All] TO PUBLIC
    AS [dbo];

