DROP SCHEMA IF EXISTS USAirlineFlights2;
CREATE DATABASE IF NOT EXISTS USAirlineFlights2;
use USAirlineFlights2;

CREATE TABLE USAirports (
	IATA			VARCHAR(32) NOT NULL PRIMARY KEY,
	Airport			VARCHAR(80),
	City			VARCHAR(32),
	State			VARCHAR(32),
	Country			VARCHAR(32),
	Latitude		FLOAT,
	Longitude		FLOAT);
    
CREATE TABLE Carriers (
	CarrierCode		VARCHAR(32) NOT NULL PRIMARY KEY,
	Description		VARCHAR(120)
);

CREATE TABLE IF NOT EXISTS Flights(
	flightID		INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	colYear			SMALLINT,
	colMonth		SMALLINT,
    DayOfMonths		SMALLINT,
	DayOfWeek		SMALLINT,
	DepTime			SMALLINT,
	CRSDepTime		SMALLINT,
	ArrTime			SMALLINT,
	CRSArrTime		SMALLINT,
	UniqueCarrier	VARCHAR(32),
	FlightNum		VARCHAR(32),
	TailNum			VARCHAR(32),
	ActualElapsedTime SMALLINT,
	CRSElapsedTime	SMALLINT,
	AirTime			SMALLINT,
	ArrDelay		SMALLINT,
	DepDelay		SMALLINT,
	Origin			VARCHAR(32),
	Dest			VARCHAR(32),
	Distance		SMALLINT,
	TaxiIn			SMALLINT,
	TaxiOut			SMALLINT,
	Cancelled		BOOLEAN,
	CancellationCode VARCHAR(32),
	Diverted		BOOLEAN,
    
    FOREIGN KEY (Dest)
		REFERENCES USAirports (IATA),
        
	FOREIGN KEY (Origin)
		REFERENCES USAirports (IATA),
        
	FOREIGN KEY (UniqueCarrier)
		REFERENCES Carriers (CarrierCode)
);
-- 1. Quantitat de registres de la taula de vols:
SELECT COUNT(*) FROM flights;

-- 2. Retard promig de sortida i arribada segons l'aeroport origen:
SELECT 
	Origin, 
    AVG(ArrDelay) AS 'prom_arribades', 
    AVG(DepDelay) AS 'prom_sortides' 
FROM flights 
GROUP BY Origin;

-- 3. Retard promig d'arribades dels vols, per mesos, anys i segons l'aeroport origen.
SELECT Origin,
	colYear,
    colMonth,
    AVG(ArrDelay) AS 'prom_arribades'
FROM flights
GROUP BY colMonth
ORDER BY Origin;

-- 4. Retard promig d'arribada dels vols, per mesos, anys i segons l'aeroport origen. Per nom de ciutat.
SELECT City,
	colYear,
    colMonth,
    AVG(ArrDelay) AS 'prom_arribades'
FROM (flights INNER JOIN usairports ON flights.Origin = usairports.IATA)
GROUP BY colMonth
ORDER BY City;

-- 5. Les companyies amb més vols cancelats, per mesos i any. Ordenat per companyies amb mes cancelacions primer.
SELECT UniqueCarrier,
	colYear,
    colMonth,
	SUM(Cancelled) AS 'total_cancelled'
FROM flights
WHERE Cancelled = 1
GROUP BY UniqueCarrier
ORDER BY total_cancelled DESC;

-- 6. L'identificador dels 10 avions que més distància han recorregut fent vols

SELECT TailNum,
	SUM(Distance) AS 'totalDistance'
FROM flights
WHERE TailNum <> ''
GROUP BY TailNum 
ORDER BY totalDistance DESC
LIMIT 10;

-- 7. Companyies amb el seu retard promig només d'aquelles les quals els seus vols arriben al seu destí amb
-- un retràs promig major de 10 minuts
SELECT UniqueCarrier,
	AVG(ArrDelay) AS 'promig_retard'
FROM flights
GROUP BY UniqueCarrier HAVING promig_retard > 10.0
ORDER BY promig_retard DESC;




	
    
	





	
    

    


	
