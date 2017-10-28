
CREATE PROCEDURE [dbo].[WSL_AttachmentFilenameEntry]
 @parm1  varchar (255)
AS
  SET NOCOUNT ON
  SELECT top 1 NoteId as id, rtrim(location)
  FROM vs_attachment
  WHERE upper(rtrim(location)) like upper(@parm1) 
  order by case
  when patindex('%[0-9].%',rtrim(location)) > 0
  then substring(rtrim(location),0, len(rtrim(location)) - patindex('%.%',reverse(rtrim(location)))+ 2 - 
           patindex('%[^0-9]%',reverse(substring(rtrim(location),0, len(rtrim(location)) - patindex('%.%',reverse(rtrim(location)))+ 1)))) +
	   Replicate('0', 255 - Len(rtrim(location)) ) + 
	   right( rtrim(location), len(rtrim(location)) - patindex('%[0-9]%',rtrim(location) ) -1)  
  else
	location
  end
  desc

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_AttachmentFilenameEntry] TO [MSDSL]
    AS [dbo];

