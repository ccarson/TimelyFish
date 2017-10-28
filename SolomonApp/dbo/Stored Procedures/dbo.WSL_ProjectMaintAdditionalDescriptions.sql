
CREATE PROCEDURE [dbo].[WSL_ProjectMaintAdditionalDescriptions]
@page  int -- ignored.  here for patttern
,@size  int -- ignored.  here for patttern
,@sort   nvarchar(200) -- ignored.  here for patttern
 ,@parm1 varchar (16) -- Project   Required.  no wildcards expected.
AS
  SET NOCOUNT ON

	select  isnull(pt.code_value_desc,'') [ProjectTypeDesc],
			isnull(bl.code_value_desc,'') [BusinessLineDesc],
			isnull(l.code_value_desc,'') [LocationDesc]
	from PJvProject  as pj  (nolock)
	LEFT outer join PJCODE as pt (nolock) on pt.code_value = pj.pm_id01 AND pt.code_type = '0PTP'
	LEFT outer join PJCODE as bl (nolock) on bl.code_value = pj.pm_id02 AND bl.code_type = '0LOB'
	LEFT outer join PJCODE as l (nolock) on l.code_value = pj.pm_id04 AND l.code_type = '0LOC'
	where pj.project = @parm1

