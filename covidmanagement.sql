CREATE OR REPLACE PACKAGE covidManagement AS

----- PROCEDURE TO UPDATE THE DATA IN TABLES----------
PROCEDURE updatecovidInfo(nCases NUMBER,dCases NUMBER,rCases NUMBER ,sCases NUMBER, country VARCHAR);

--- Function to find the rank of the Country based on the total cases ------
FUNCTION rankFinder(countryName VARCHAR2)
RETURN VARCHAR2;

--- Function that returns total number of cases in the world -----
FUNCTION totalCases
RETURN NUMBER;

------- FUNCTION TO FIND TOTAL DEATHS-------------
FUNCTION totalDeaths
RETURN NUMBER;

-----FUNCTION TO FIND TOTAL RECOVERED CASES -------------
FUNCTION totalRecovered
RETURN NUMBER;

-----FUNCTION TO FIND TOTAL SERIOUS CASES-------------
FUNCTION totalSerious
RETURN NUMBER;

----- FUNCTION TO FIND TOTAL ACTIVE CASES ------
FUNCTION totalactiveCases
RETURN NUMBER;

----FUNCTION TO FIND TOTAL MILD CASES
FUNCTION totalmildCases
RETURN NUMBER;

--- FUNCTION TO FIND TOTAL CLOSED CASES
FUNCTION totalclosedCases
RETURN NUMBER;
    
END covidManagement;
/

CREATE OR REPLACE PACKAGE BODY covidManagement AS

----- PROCEDURE TO UPDATE THE DATA IN TABLES----------
PROCEDURE updatecovidInfo(nCases NUMBER,dCases NUMBER,rCases NUMBER ,sCases NUMBER, country VARCHAR)
AS
BEGIN
-- QUERY TO UPDATE THE MAIN TABLE
UPDATE covidInfo
SET totalCases= totalCases+ nCases , totalDeaths= totalDeaths+dCases, totalRecovered=rCases, totalSerious=sCases
WHERE UPPER(cName)= country;

-- QUERY TO UPDATE THE TABLE THAT HOLDS NEW DATA
UPDATE newcovidInfo
SET newCases= nCases, newDeaths=dCases
WHERE UPPER(cName)= country;
END updatecovidInfo;
-----------------------------------------------------
------ Functions to find rank of the Country -------
FUNCTION rankFinder(countryName VARCHAR2)
RETURN VARCHAR2
IS
pos NUMBER(5);
BEGIN
SELECT cpos INTO pos FROM (
SELECT ci.*, DENSE_RANK() OVER(ORDER BY totalCases DESC) cpos
from covidInfo ci
)
where UPPER(cName)= countryName;
RETURN pos;
END rankFinder;
--------------------------------------------------------
------- FUNCTION TO FIND TOTALCASES -------------
FUNCTION totalCases
RETURN NUMBER
AS
totalCases NUMBER(20);
BEGIN
--------
SELECT SUM(ci.totalCases) into totalCases
FROM covidInfo ci;
---------
RETURN totalCases ;
END totalCases;

---------------------------------------------------------
------- FUNCTION TO FIND TOTAL DEATHS-------------
FUNCTION totalDeaths
RETURN NUMBER
AS
totalDeaths NUMBER(20);

BEGIN
-----------------------------
SELECT SUM(ci.totalDeaths) into totalDeaths
FROM covidInfo ci;
-----------------------------
RETURN totalDeaths ;
END totalDeaths;

----------------------------------------------------------
-----FUNCTION TO FIND TOTAL RECOVERED CASES -------------
FUNCTION totalRecovered
RETURN NUMBER
AS
totalRecovered NUMBER(20);

BEGIN
SELECT SUM(ci.totalRecovered) into totalRecovered
FROM covidInfo ci;
-----------------------------
RETURN totalRecovered ;
END totalRecovered;
-------------------------------------
-----FUNCTION TO FIND TOTAL SERIOUS CASES-------------
FUNCTION totalSerious
RETURN NUMBER
AS
totalSerious  NUMBER(20);
results   varchar2(255);
BEGIN
SELECT SUM(ci.totalSerious) into totalSerious
FROM covidInfo ci;
results:= totalSerious;
RETURN results ;
END totalSerious;
------------------

----FUNCTION TO FIND TOTAL ACTIVE CASES
FUNCTION totalactiveCases
RETURN NUMBER
AS
tactiveCases NUMBER(20);
BEGIN
tactiveCases :=totalCases()-totalDeaths()-totalRecovered();
RETURN tactiveCases;
END totalactiveCases;

--------------------------------------------------
----FUNCTION TO FIND TOTAL MILD CASES
FUNCTION totalmildCases
RETURN NUMBER
AS
tmildCases NUMBER(20);
BEGIN
tmildCases :=totalCases()-totalDeaths()-totalRecovered()-totalSerious();
RETURN tmildCases;
END totalmildCases;
---------------------------------------------
--- FUNCTION TO FIND TOTAL CLOSED CASES
FUNCTION totalclosedCases
RETURN NUMBER
AS
tmildCases NUMBER(20);
BEGIN
tmildCases :=totalCases()-totalactiveCases();
RETURN tmildCases;
END totalclosedCases;
--------------------------------------

END covidmanagement;
----------------------------------------

---------------- VIEWS -----------------------

------- VIEW TO GENEREATE BOTTOM 20 --------------
create or replace view vw_bot20 as 
select ids, cName,totalCases from(
select row_number() over (order by totalCases desc) ids, cName, totalCases
from covidInfo)
where ids <21; 


------- VIEW TO GENEREATE TOP 20 --------------
create or replace view vw_top20 as 
select ids,cName,totalCases from (select row_number() over (order by totalCases asc) ids, cName, totalCases
from covidInfo)
where ids<21;


-------- VIEW TO GENERATE DATA OF NEPAL
CREATE OR REPLACE VIEW vw_newdata as
select  'NEPAL Position:'|| ''||covidManagement.rankFinder('NEPAL')  || '- total: '||ci.totalcases ||'; today:'|| nc.newCases || '- deaths:'||ci.totaldeaths ||'; today:'|| nc.newDeaths nepal from newcovidInfo nc
inner join covidInfo ci
on
nc.cName = ci.cName
where upper(nc.cName)='NEPAL';


------------------------- FINAL QUERY TO GENEREATE THE DESIRED RESULT ----------------
with remres as (
            SELECT 2 ids,'TotalCases:' E ,' ' F, ' ' G,' ' H,  'Deaths:' d ,' ' M, 'Recovered: ' N, ' ' O from dual
            union
            SELECT 3 ids,''||covidManagement.totalCases() ,' ' F, ' ' G,' ' H, ''||covidManagement.totalDeaths(),' ' M, ''||covidManagement.totalRecovered(), ' ' O from dual    
            union
            SELECT 4 ids,' ' E ,' ' F, ' ' G,' ' H,  ' ' d ,' ' M, ' ' N, ' ' O from dual
            union
             SELECT 5 ids,' ' E ,' ' F, ' ' G,' ' H,  ' ' d ,' ' M, ' ' N, ' ' O from dual
            union
             SELECT 6 ids,' ' E ,' ' F, ' ' G,' ' H,  ' ' d ,' ' M, ' ' N, ' ' O from dual
            union
             SELECT 7 ids,' ' E ,' ' F, ' ' G,' ' H,  ' ' d ,' ' M, ' ' N, ' ' O from dual
            union
            SELECT 8 ids,' ' E ,' ' F, ' ' G,' ' H,  ' ' d ,' ' M, 'Closed Cases ' N, ' ' O from dual
            union
            SELECT 9 ids,'Active' E ,' ' F, ' ' G,' ' H,  ' ' d ,' ' M, ' ' N, ' ' O from dual
            union
            SELECT 10 ids,'Cases' E ,' ' F, ''||covidManagement.totalactiveCases(),' ' H,  ' ' d ,' ' M, ''||(covidManagement.totalCases() - covidManagement.totalactiveCases()), ' ' O from dual
            union
            SELECT 11 ids,' ' E ,' ' F, 'Currently Infected Patients ' G,' ' H,  ' ' d ,' ' M, 'Cases which has an outcome' N, ' ' O from dual
            union
            SELECT 12 ids,' ' E ,' ' F, ' ' G,' ' H,  ' ' d ,' ' M, ' ' N, ' ' O from dual
            union
            SELECT 13 ids,' ' E ,' ' F, ' ' G,' ' H,  ' ' d ,' ' M, ' ' N, ' ' O from dual
            union
            SELECT 14 ids,' ' E ,''||covidManagement.totalmildCases || '('|| ROUND((covidManagement.totalmildCases()/covidManagement.totalactiveCases())*100,1) ||'%)' , ' ' G,''||covidManagement.totalSerious ||'('|| Round(covidManagement.totalSerious()/covidManagement.totalactiveCases()*100,1) ||'%)',  ' ' d ,
            ''||covidManagement.totalRecovered || '('|| Round(covidManagement.totalRecovered()/(covidManagement.totalDeaths()+covidManagement.totalRecovered())*100) ||'%)' , ' ' N, 
            ''||covidManagement.totalDeaths ||'('|| Round(covidManagement.totalDeaths()/(covidManagement.totalCases() - covidManagement.totalactiveCases())*100) ||'%)' from dual
            union
            SELECT 15 ids,' ' E ,'in Mild Condition' , ' ' G,' Serious or Critical ' ,  ' ' d ,'Recovered/Discharged ' , ' ' N, 'Deaths '  from dual
            union
            SELECT 16 ids,' ' E , nepal, ' ' G,' ' H,  ' ' d ,' ' M, ' ' N, ' ' O from vw_newdata
    
            )select vw_bot20.cName "TOP" ,vw_bot20.totalCases "20",remres.E " ",remres.F " ",remres.G " ",remres.H " ",remres.d " ",remres.M " ",remres.N " ",remres.O " ", vw_top20.cName "BOTTOM" ,vw_top20.totalCases " 20"
from vw_bot20    left join remres
on vw_bot20.ids=remres.ids
 left join vw_top20
on vw_bot20.ids = vw_top20.ids 
;
   

