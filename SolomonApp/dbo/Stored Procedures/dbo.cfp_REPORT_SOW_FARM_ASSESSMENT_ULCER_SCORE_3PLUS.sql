



-- ======================================================================================
-- Author:	Nick Honetschlager
-- Create date:	4/18/2016
-- Description:	Ulcer Score 3+. Converted to stored procedure from sql in rdl.
-- Parameters: 	@pEvalID
--
-- ======================================================================================
/* 
========================================================================================================
Change Log: 
Date        Author		 	   Change 
----------- ------------------ ------------------------------------------------------------ 

========================================================================================================
*/
CREATE PROCEDURE [dbo].[cfp_REPORT_SOW_FARM_ASSESSMENT_ULCER_SCORE_3PLUS] 
@pEvalID int

AS

select   fq.Definition as 'Question'
	,fq.QuestionNbr
	,er.answer as 'Score'
	, tot_sum.FarrowCapacity as 'Count_Total'
	, cast(er.answer as decimal)/cast(tot_sum.FarrowCapacity as decimal) as 'Pct'
from dbo.cft_Eval_Results er
inner join dbo.cft_Eval ce on ce.Eval_id=er.Eval_id and FormID = 13
inner join dbo.cft_Form_Ques fq on er.Question_id=fq.Question_id 
inner join (
			select ContactName
				 , ContactID
				 , SUM(StdCap) as FarrowCapacity
			from (
					select c.ContactName
						 , c.ContactID
						 , b.StdCap
						 , b.BarnNbr
					  from centraldata.dbo.Contact c
					left join (select contactid, stdcap, BarnNbr
								  from centraldata.dbo.Barn
								  where (BarnNbr like '%FAR%' or BarnNbr like '%FR%' or BarnNbr like '%ISO%' or BarnNbr like '%IS%') and StatusTypeID=1
							   ) b on b.ContactID=c.ContactID
					where (c.ContactName like 'C0%' or c.contactname like 'M0%')
					  and c.StatusTypeID=1
					  and c.ContactName not in ('C027','C029','C031','C032','C034','C036', 'C003 Transfer','C039 Flow','M001 Nursery')
					  and c. ContactID not in ( -- SBF Farms
							  '002526' , '005424' , '005541' , '002536' , '002539' , '002686' , '002545' , '004184' , '004304' , '004185' , '004742' 
							, '002547' , '002548' , '002549' , '002550' , '002551' , '002552' , '002553' , '004314' , '006767' , '002566' , '002567' 
							, '002837' , '002573' , '002575' , '002576' , '006857' , '002580' , '009520' , '004242' , '003903' , '003905' , '004313' 
							, '004247' , '004309' , '004292' , '004210' , '004442' , '004432' , '004426' , '004414' , '004413' , '004415' , '004416' 
							, '004417' , '004595' , '004614' , '004615' , '004849' , '002597' , '004418' , '004396' , '002582' , '002583' , '002589' 
							, '002308' , '002592' , '005565' , '002595' , '008965' , '010493' , '005446' , '002601' , '002602' , '004300' , '002604' 
							, '002606' , '002605' , '010141' , '007947' , '002610' , '009030' , '002615' , '005121' , '002617' , '002619' , '009029' 
							, '002625' , '002626' , '002306' , '002627' , '010708' , '010709' , '002632' , '002616' , '002651' , '003529' , '003530' 
							, '003692' , '003700' , '003697' , '003701' , '003702' , '002633' , '002637' , '002640' , '002642' , '002645' , '002646' 
							, '009674' , '002648' , '004397' , '003768' , '002649' , '002652' , '002654' , '010732' , '009355' , '009359' , '009360'
							, '007207' , '002656' , '002657' , '002659' , '002660' , '008123' , '008122' , '006727' , '002666' , '002667' , '002668' 
							, '009677' , '006615' , '011322')
					UNION
					select c.ContactName
						 , c.ContactID
						 , b.StdCap
						 , b.BarnNbr
					  from centraldata.dbo.Contact c
					left join (select CASE right(LEFT(barnnbr,3),2) 
										 When '28' THEN 'C027'
										 When '30' THEN 'C029'
										 When '33' THEN 'C032'
										 When '35' THEN 'C034'
										 When '37' THEN 'C036'
										 Else 'C0' + right(LEFT(barnnbr,3),2) 
									   END as ContactName
								  , stdcap, BarnNbr
								  from centraldata.dbo.Barn
								  where (BarnNbr like '%FR%' or BarnNbr like '%ISO%' or BarnNbr like '%IS%' ) and StatusTypeID=1
							   ) b on b.ContactName=c.ContactName
					where c.ContactName in ('C027','C029','C031','C032','C034','C036')
					  and c.StatusTypeID=1
					  and c.ContactName not in ('C003 Transfer','C039 Flow')
					  and c. ContactID not in ( -- SBF Farms
							  '002526' , '005424' , '005541' , '002536' , '002539' , '002686' , '002545' , '004184' , '004304' , '004185' , '004742' 
							, '002547' , '002548' , '002549' , '002550' , '002551' , '002552' , '002553' , '004314' , '006767' , '002566' , '002567' 
							, '002837' , '002573' , '002575' , '002576' , '006857' , '002580' , '009520' , '004242' , '003903' , '003905' , '004313' 
							, '004247' , '004309' , '004292' , '004210' , '004442' , '004432' , '004426' , '004414' , '004413' , '004415' , '004416' 
							, '004417' , '004595' , '004614' , '004615' , '004849' , '002597' , '004418' , '004396' , '002582' , '002583' , '002589' 
							, '002308' , '002592' , '005565' , '002595' , '008965' , '010493' , '005446' , '002601' , '002602' , '004300' , '002604' 
							, '002606' , '002605' , '010141' , '007947' , '002610' , '009030' , '002615' , '005121' , '002617' , '002619' , '009029' 
							, '002625' , '002626' , '002306' , '002627' , '010708' , '010709' , '002632' , '002616' , '002651' , '003529' , '003530' 
							, '003692' , '003700' , '003697' , '003701' , '003702' , '002633' , '002637' , '002640' , '002642' , '002645' , '002646' 
							, '009674' , '002648' , '004397' , '003768' , '002649' , '002652' , '002654' , '010732' , '009355' , '009359' , '009360'
							, '007207' , '002656' , '002657' , '002659' , '002660' , '008123' , '008122' , '006727' , '002666' , '002667' , '002668' 
							, '009677' , '006615' , '011322')
			) far
			where far.BarnNbr like '%FAR%' or far.BarnNbr like '%FR%'
			group by ContactName, ContactID
                  ) tot_sum on tot_sum.ContactID = ce.SiteContactID

where ce.Eval_id=@pEvalID
  and fq.Area = 'Ulcer Score'
  

 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[cfp_REPORT_SOW_FARM_ASSESSMENT_ULCER_SCORE_3PLUS] TO [MSDSL]
    AS [dbo];

