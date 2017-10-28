CREATE VIEW _hypmv_2   AS SELECT  [dbo].[cftpiggroup].[taskid] as _hypmv_2_col_1,  [dbo].[cftpiggroup].[projectid] as _hypmv_2_col_2,  [dbo].[cftsitesvcmgrasn].[effectivedate] as _hypmv_2_col_3,  [dbo].[cftpiggroup].[piggroupid] as _hypmv_2_col_4,  
[dbo].[cftcontact].[contactid] as _hypmv_2_col_5,  [dbo].[cftpiggroup].[pgstatusid] as _hypmv_2_col_6,  [dbo].[cftpginvtran].[reversal] as _hypmv_2_col_7,  
[dbo].[cftpginvtran].[acct] as _hypmv_2_col_8,  [dbo].[cftpginvtran].[trandate] as _hypmv_2_col_9,  
[dbo].[cftsitesvcmgrasn].[svcmgrcontactid] as _hypmv_2_col_10,  [dbo].[cftpiggroup].[pigprodphaseid] as _hypmv_2_col_11,  [dbo].[cftpginvtran].[inveffect] as _hypmv_2_col_12,  [dbo].[cftpstype].[descr] as _hypmv_2_col_13,  
[dbo].[cftcontact].[contactname] as _hypmv_2_col_14,  SUM([SolomonApp].[dbo].[cftPGInvTran].[Qty]) as _hypmv_2_col_15, 
SUM([SolomonApp].[dbo].[cftPGInvTran].[TotalWgt]) as _hypmv_2_col_16, SUM([SolomonApp].[dbo].[cftPGInvTran].[Qty]*[SolomonApp].[dbo].[cftPGInvTran].[InvEffect]) as _hypmv_2_col_17, 
SUM([SolomonApp].[dbo].[cftPGInvTran].[TotalWgt]*[SolomonApp].[dbo].[cftPGInvTran].[InvEffect]) as _hypmv_2_col_18, 
count_big(*) as _hypmv_2_col_19 FROM  [dbo].[cftpigprodphase],  [dbo].[cftpigsale],  [dbo].[pjptdsum],  [dbo].[cftcontact],  [dbo].[cftpiggroup], 
[dbo].[cftsite],  [dbo].[cftsitesvcmgrasn],  [dbo].[cftpginvtran],  [dbo].[cftpstype]   
WHERE ( [dbo].[cftpigprodphase].[pigprodphaseid] = [dbo].[cftpiggroup].[pigprodphaseid] ) AND ( [dbo].[cftpiggroup].[piggroupid] = [dbo].[cftpginvtran].[piggroupid] ) 
AND ( [dbo].[cftpigsale].[refnbr] = [dbo].[cftpginvtran].[sourcerefnbr] ) AND ( [dbo].[cftpigsale].[batnbr] = [dbo].[cftpginvtran].[sourcebatnbr] ) 
AND ( [dbo].[cftpigsale].[saletypeid] = [dbo].[cftpstype].[salestypeid] ) 
AND (( [dbo].[pjptdsum].[project] = [dbo].[cftpiggroup].[projectid] ) AND ( [dbo].[pjptdsum].[pjt_entity] = [dbo].[cftpiggroup].[taskid] )) 
AND ( [dbo].[cftpiggroup].[piggroupid] = [dbo].[cftpginvtran].[piggroupid] ) AND ( [dbo].[cftpiggroup].[piggroupid] = [dbo].[cftpginvtran].[piggroupid] ) 
AND ( [dbo].[cftpiggroup].[piggroupid] = [dbo].[cftpginvtran].[piggroupid] ) AND ( [dbo].[cftpiggroup].[piggroupid] = [dbo].[cftpginvtran].[piggroupid] ) AND ( [dbo].[cftpiggroup].[sitecontactid] = [dbo].[cftsitesvcmgrasn].[sitecontactid] ) 
AND ( [dbo].[cftpiggroup].[sitecontactid] = [dbo].[cftsitesvcmgrasn].[sitecontactid] ) AND ( [dbo].[cftcontact].[contactid] = [dbo].[cftsitesvcmgrasn].[svcmgrcontactid] ) AND ( [dbo].[cftpiggroup].[sitecontactid] = [dbo].[cftsite].[contactid] ) 
AND ( [dbo].[cftcontact].[contactid] = [dbo].[cftpiggroup].[sitecontactid] ) AND ( [dbo].[cftpiggroup].[piggroupid] = [dbo].[cftpginvtran].[piggroupid] ) AND ( [dbo].[cftpiggroup].[piggroupid] = [dbo].[cftpginvtran].[sourcepiggroupid] ) 
AND ( [dbo].[cftpiggroup].[piggroupid] = [dbo].[cftpginvtran].[piggroupid] ) AND ( [dbo].[cftpiggroup].[piggroupid] = [dbo].[cftpginvtran].[piggroupid] ) AND ( [dbo].[cftpiggroup].[piggroupid] = [dbo].[cftpginvtran].[piggroupid] ) 
GROUP BY  [dbo].[cftpiggroup].[taskid],  [dbo].[cftpiggroup].[projectid],  [dbo].[cftsitesvcmgrasn].[effectivedate],  [dbo].[cftpiggroup].[piggroupid],  [dbo].[cftcontact].[contactid],  [dbo].[cftpiggroup].[pgstatusid],  [dbo].[cftpginvtran].[reversal],  
[dbo].[cftpginvtran].[acct],  [dbo].[cftpginvtran].[trandate],  [dbo].[cftsitesvcmgrasn].[svcmgrcontactid],  [dbo].[cftpiggroup].[pigprodphaseid],  [dbo].[cftpginvtran].[inveffect],  [dbo].[cftpstype].[descr],  [dbo].[cftcontact].[contactname] 

 