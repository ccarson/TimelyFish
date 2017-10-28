
CREATE VIEW [QQ_pjcosubd]
AS
SELECT     SD.project, P.project_desc AS [project description], SD.subcontract, 
                      C.subcontract_desc AS [subcontract description], C.vendid AS [vendor ID], CASE WHEN CHARINDEX('~', 
                      V.VEND_NAME) > 0 THEN CONVERT(CHAR(30), LTRIM(SUBSTRING(V.VEND_NAME, 1, CHARINDEX('~', V.VEND_NAME) - 1)) 
                      + ', ' + LTRIM(RTRIM(SUBSTRING(V.VEND_NAME, CHARINDEX('~', V.VEND_NAME) + 1, 30)))) 
                      ELSE V.VEND_NAME END AS [vendor name], SD.change_order_num AS [change order], 
                      SH.co_desc AS [change order description], SD.sub_line_item AS [change order line item], SD.pjt_entity AS task, 
                      SD.line_desc AS [line item description], SD.cpnyId AS company, SD.gl_acct AS [G/L account], 
                      SD.gl_subacct AS [G/L subaccount], SD.acct AS [account category], SD.labor_class_cd AS [labor class], 
                      SD.change_amt AS [amount of change], SD.change_units AS [units change], 
                      D.original_amt AS [original subcontract amount], D.original_units AS [original subcontract units], 
                      D.revised_amt AS [revised subcontract amount], D.revised_units AS [revised subcontract units], 
                      SD.retention_method AS [retention method], SD.retention_percent AS [retention percent], 
                      convert(date,SH.date_co) AS [change order date], SH.impact_days AS [impact days], SH.reqd_by AS [requested by], 
                      SH.reqd_reason AS [request reason], SH.vendor_ref AS [vendor reference], SH.status1 AS [change order status], 
                      convert(date,SH.date_apprv) AS [date approved], SH.approved_by AS [approved by], C.status_sub AS [subcontract status], 
                      C.status_pay AS [subcontract pay status], P.customer, P.manager1 AS [project manager], 
                      P.manager2 AS [business manager], P.slsperid AS [sales person], P.status_pa AS [project status], 
                      SH.subco_cat_cd AS [subcontract category], SH.pjt_change_order AS [project change order], 
                      C.sub_type_cd AS [subcontract type], convert(date,C.date_start_act) AS [subcontract actual start date], 
                      convert(date,C.date_end_rev) AS [subcontract revised end date], C.last_payreqnbr AS [last payment request number], 
                      C.specialty_cd AS [speciialty code], SD.sd_id01, SD.sd_id02, SD.sd_id03, 
                      SD.sd_id04, SD.sd_id05, SD.sd_id06, SD.sd_id07, convert(date,SD.sd_id08) AS [sd_id08], 
                      convert(date,SD.sd_id09) AS [sd_id09], SD.sd_id10, SD.sd_id11, SD.sd_id12, SD.sd_id13, 
                      SD.sd_id14, SD.sd_id15, SD.sd_id16, SD.sd_id17, convert(date,SD.sd_id18) AS [sd_id18], 
                      convert(date,SD.sd_id19) AS [sd_id19], SD.sd_id20, SD.user1, SD.user2, SD.user3, SD.user4, 
                      SD.user5, SD.user6, SD.user7, SD.user8, convert(date,SD.crtd_datetime) AS [create date], SD.crtd_prog AS [create program], 
                      SD.crtd_user AS [create user], convert(date,SD.lupd_datetime) AS [last update date], SD.lupd_prog AS [last update program], 
                      SD.lupd_user AS [last update user]
FROM         PJCOSUBD SD WITH (nolock) INNER JOIN
                      PJCOSUBH SH WITH (nolock) ON SD.change_order_num = SH.change_order_num AND 
						SD.project = SH.project AND SD.subcontract = SH.subcontract INNER JOIN
                      PJPROJ P WITH (nolock) ON SD.project = P.project INNER JOIN
                      PJSUBCON C WITH (nolock) ON SD.project = C.project AND SD.subcontract = C.subcontract INNER JOIN
                      PJSUBDET D WITH (nolock) ON SD.project = D.project AND SD.subcontract = D.subcontract AND 
						SD.sub_line_item = D.sub_line_item LEFT OUTER JOIN
                      PJSUBVEN V WITH (nolock) ON C.vendid = V.vendid

