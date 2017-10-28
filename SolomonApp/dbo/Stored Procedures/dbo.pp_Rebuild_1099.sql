 --APPTABLE
--USETHISSYNTAX

CREATE procedure pp_Rebuild_1099 AS

UPDATE AP_Balances SET 	LUpd_DateTime = GETDATE(), LUpd_Prog = '03990', LUpd_User = 'REBUILD',
	NYBox00 = ROUND(z.Box00,2),
	NYBox01 = ROUND(z.Box01, 2),
	NYBox02 = ROUND(z.Box02, 2),
	NYBox03 = ROUND(z.Box03, 2)+ Case when w.Box03 <> 0 then ROUND(w.Box03, 2) else 0 end ,
	NYBox04 = ROUND(z.Box04, 2),
	NYBox05 = ROUND(z.Box05, 2),
	NYBox06 = ROUND(z.Box06, 2),
	NYBox07 = ROUND(z.Box07, 2),
    NYBox09 = ROUND(z.Box09, 2),
    NYBox11 = ROUND(z.Box15a, 2),
    NYBox12 = ROUND(z.Box15b, 2),
    NYBox13 = ROUND(z.box13, 2),
    NYBox14 = ROUND(z.box14, 2)
FROM    AP_Balances b, vp_Rebuild_1099 z, Vendor v left join  vp_rebuild_BW w on  v.VendId = w.VendId AND v.next1099Yr = w.CalendarYr 
WHERE v.VendId = z.VendId AND v.Next1099Yr = z.CalendarYr AND
        z.vendid = b.vendid AND b.CpnyId = z.CpnyId

UPDATE AP_Balances SET 	LUpd_DateTime = GETDATE(), LUpd_Prog = '03990', LUpd_User = 'REBUILD',
	CYBox00 = ROUND(z.Box00, 2),
	CYBox01 = ROUND(z.Box01, 2),
	CYBox02 = ROUND(z.Box02, 2),
	CYBox03 = ROUND(z.Box03, 2) + Case when w.Box03 <> 0 then ROUND(w.Box03, 2) else 0 end ,
	CYBox04 = ROUND(z.Box04, 2),
	CYBox05 = ROUND(z.Box05, 2),
	CYBox06 = ROUND(z.Box06, 2),
	CYBox07 = ROUND(z.Box07, 2),
	CYBox09 = ROUND(z.Box09, 2),
	CYBox11 = ROUND(z.Box15a, 2),
	CYBox12 = ROUND(z.Box15b, 2),
	CYBox13 = ROUND(z.box13, 2),
	CYBox14 = ROUND(z.box14, 2)
FROM    AP_Balances b, vp_Rebuild_1099 z, Vendor v left join  vp_rebuild_BW w on  v.VendId = w.VendId AND v.Curr1099Yr = w.CalendarYr 
WHERE v.VendId = z.VendId AND v.Curr1099Yr = z.CalendarYr  AND
        z.vendid = b.vendid AND b.CpnyId = z.CpnyId
        

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_Rebuild_1099] TO [MSDSL]
    AS [dbo];

