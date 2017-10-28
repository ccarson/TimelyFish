 
CREATE VIEW vs_share_secCpny
AS
SELECT vc.cpnyname,
	vc.databasename,
	vc.active,
	vc.cpnyid cpnyid,
	substring(screennumber, 1, 5) scrn,
	coalesce(vg.userid, va.userid) userid,
	convert(CHAR, max(viewrights + updaterights + insertrights + deleterights + initrights)) seclevel
FROM vs_company vc
INNER JOIN vs_accessdetrights va ON isnull(NULLIF(va.companyid, '[ALL] '), vc.cpnyid) = vc.cpnyid
LEFT OUTER JOIN vs_usergrp vg ON vg.groupid = va.userid
	AND va.rectype = 'G'
GROUP BY cpnyname,
	vc.databasename,
	active,
	cpnyid,
	screennumber,
	coalesce(vg.userid, va.userid)

