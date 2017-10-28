 /****** Object:  Stored Procedure dbo.APARlink_ServCont_LINKED    Script Date: 06/7/06 ******/
Create Procedure APARlink_ServCont_LINKED @VendID varchar(15), @APRefNbr varchar (10),
                                 @Custid varchar(15), @ARRefNbr varchar (10) AS

SELECT *
  FROM APARLINK
 WHERE Vendid = @VendID
   AND APRefNbr = @APRefNbr
   AND APDoctype = 'VO'
   AND Custid = @Custid
   AND ARRefNbr = @ARRefNbr
   AND ARDoctype = 'IN'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APARlink_ServCont_LINKED] TO [MSDSL]
    AS [dbo];

