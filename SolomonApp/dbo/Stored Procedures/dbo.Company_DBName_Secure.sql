 Create Proc Company_DBName_Secure
@Parm1 varchar (50),
@Parm2 varchar (47),
@Parm3 varchar (5),
@Parm4 varchar(1),
@Parm5 varchar (10)

WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as

SELECT *
         FROM vs_Share_UserCpny
         WHERE DatabaseName = @Parm1 AND
               UserID = @Parm2 AND
               Scrn = @Parm3 AND
               SecLevel >= @Parm4 AND
               CpnyID Like @Parm5 AND
               Active = 1

         ORDER BY CpnyId, CpnyName



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Company_DBName_Secure] TO [MSDSL]
    AS [dbo];

