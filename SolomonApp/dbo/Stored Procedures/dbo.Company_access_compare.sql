 Create Proc Company_access_compare
@Parm1 varchar (50),
@Parm2 varchar (47),
@Parm3 varchar (5),
@Parm4 varchar(1)

WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
DECLARE @TotalCpny varchar(3)
DECLARE @UserAccessCpny varchar(3)

 SELECT @userAccessCpny = count(*)
         FROM vs_Share_UserCpny
         WHERE DatabaseName = @Parm1 AND
               UserID = @Parm2 AND
               Scrn = @Parm3 AND
               SecLevel >= @Parm4 and
               Active = 1


select @TotalCpny =  count(*) from vs_company where databasename = @parm1

If @TotalCpny > @UserAccessCpny
Select 1 as UserAccessAllCpny
Else
Select 0 as UserAccessAllCpny

