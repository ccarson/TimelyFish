
create FUNCTION [dbo].[UserAccessCpny](@parm1 Varchar(100))
RETURNS  @rtnTable TABLE 
(
    -- columns returned by the function
    
    CpnyID varchar(10) NOT NULL
)
 WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
BEGIN
Declare @UserID varchar(47), @ScrnNbr varchar(5), @SecLevel Varchar(1), @DBName Varchar(30)
declare @pos int ,@piece varchar(500)

--Get the UserID, ScrnNbr, SecLevel, DBName from the packaged string sent in
--Parm1 is a * delimited string containing UserID, ScrnNbr, SecLevel, DBName needed to determine which companies
-- the current user has access to in the current string
set @pos =  patindex('%*%' , @parm1)
set @UserID = left(@parm1, @pos - 1)
set @parm1 = stuff(@parm1, 1, @pos, '')
set @pos =  patindex('%*%' , @parm1)
set @ScrnNbr = left(@parm1, @pos - 1)
set @parm1 = stuff(@parm1, 1, @pos, '')
set @pos =  patindex('%*%' , @parm1)
set @SecLevel = left(@parm1, @pos - 1)
set @parm1 = stuff(@parm1, 1, @pos, '')
set @pos =  patindex('%*%' , @parm1)
set @DBName = left(@parm1, @pos - 1)


--This select returns which companies user has access to
insert into @rtnTable
SELECT  vs_Share_UserCpny.cpnyid FROM vs_Share_UserCpny  WHERE UserID = @UserID  AND
  Scrn = @ScrnNbr AND SecLevel >= @seclevel and 
  DatabaseName = @DBName AND Active = 1
return
END

