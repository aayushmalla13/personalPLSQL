create or replace view vw_bot20 as 
select ids, cName,totalCases from(
select row_number() over (order by totalCases desc) ids, cName, totalCases
from covidInfo)
where ids <21; 



create or replace view vw_top20 as 
select ids,cName,totalCases from (select row_number() over (order by totalCases asc) ids, cName, totalCases
from covidInfo)
where ids<21;



--
--select * from table(totalFinder);

--
--create or replace view totalNum as
--select row_number() over ( order by case_count asc) ids,case_type,case_count from table(totalFinder);

--CREATE OR REPLACE VIEW vw_newdata as
--select row_number() over (order by cName) ids,cName,newCases,newDeaths from newcovidInfo
--where upper(cName)='NEPAL';

CREATE OR REPLACE VIEW vw_newdata as
select  'NEPAL Position:'|| ''||rankFinder('NEPAL')  || '- total: '||ci.totalcases ||'; today:'|| nc.newCases || '- deaths:'||ci.totaldeaths ||'; today:'|| nc.newDeaths nepal from newcovidInfo nc
inner join covidInfo ci
on
nc.cName = ci.cName
where upper(nc.cName)='NEPAL';
select * from vw_newdata;

-------FINAL QUERY----------
select vw_bot20.cName,vw_bot20.totalCases, vw_top20.cName,vw_top20.totalCases,totalNum.case_type,totalNum.case_count,vw_newdata.cName,vw_newdata.newCases,vw_newdata.newDeaths
from vw_bot20   join vw_top20
on vw_bot20.ids = vw_top20.ids 
 left join totalNum
on
vw_top20.ids= totalNum.ids
left join vw_newdata
on
vw_top20.ids=vw_newdata.ids;


SELECT * FROM vw_top20;

---view joins
SELECT vw_top20.cName,vw_top20.totalCases, vw_bot20.cName, vw_bot20.totalCases
from vw_top20 left join
vw_bot20
on
vw_top20.ids= vw_bot20.ids;
