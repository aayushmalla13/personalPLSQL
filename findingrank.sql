------- Functions to find rank of the Country -------
CREATE OR REPLACE FUNCTION rankFinder(countryName VARCHAR2)
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
/

SELECT rankFinder('USA') AS POSITION FROM DUAL;

------- FUNCTION TO FIND TOTALCASES -------------
CREATE OR REPLACE FUNCTION totalCases
RETURN NUMBER
AS
totalCases NUMBER(20);
results   varchar2(255);
BEGIN
SELECT SUM(ci.totalCases) into totalCases
FROM covidInfo ci;
results:= totalCases;
RETURN results ;
END totalCases;

------- FUNCTION TO FIND TOTAL DEATHS-------------
CREATE OR REPLACE FUNCTION totalDeaths
RETURN NUMBER
AS
totalDeaths NUMBER(20);
results   varchar2(255);
BEGIN
-----------------------------
SELECT SUM(ci.totalDeaths) into totalDeaths
FROM covidInfo ci;
-----------------------------
results:= totalDeaths;
RETURN results ;
END totalDeaths;



-----FUNCTION TO FIND TOTAL RECOVERED CASES -------------
CREATE OR REPLACE FUNCTION totalRecovered
RETURN NUMBER
AS
totalRecovered NUMBER(20);
results   varchar2(255);
BEGIN
SELECT SUM(ci.totalRecovered) into totalRecovered
FROM covidInfo ci;
-----------------------------
results:= totalRecovered;
RETURN results ;
END totalRecovered;

-----FUNCTION TO FIND TOTAL SERIOUS CASES-------------
CREATE OR REPLACE FUNCTION totalSerious
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

----FUNCTION TO FIND TOTAL ACTIVE CASES
CREATE OR REPLACE FUNCTION totalactiveCases
RETURN NUMBER
AS
tactiveCases NUMBER(20);
BEGIN
tactiveCases :=totalCases()-totalDeaths()-totalRecovered();
RETURN tactiveCases;
END totalactiveCases;

----FUNCTION TO FIND TOTAL MILD CASES
CREATE OR REPLACE FUNCTION totalmildCases
RETURN NUMBER
AS
tmildCases NUMBER(20);
BEGIN
tmildCases :=totalCases()-totalDeaths()-totalRecovered()-totalSerious();
RETURN tmildCases;
END totalmildCases;

--- FUNCTION TO FIND TOTAL CLOSED CASES
CREATE OR REPLACE FUNCTION totalclosedCases
RETURN NUMBER
AS
tmildCases NUMBER(20);
BEGIN
tmildCases :=totalCases()-totalactiveCases();
RETURN tmildCases;
END totalclosedCases;

-----FUNCTION TO FIND SERIOUS PERCENTAGE
--CREATE OR REPLACE FUNCTION totalseriousPercentage
--RETURN number
--AS
--tserious NUMBER(20);
--BEGIN
--tserious := 0.4;
----tserious := ROUND((totalSerious/(totalCases-totalDeaths-totalRecovered))*100,1);
--RETURN tserious;
--END totalseriousPercentage;
--select totalseriousPercentage from dual;
select ROUND((totalSerious/(totalCases-totalDeaths-totalRecovered))*100,1) from dual;
select ROUND((totalSerious()/totalactiveCases())*100,1) from dual;
---------------------------------------------------------------------

