CREATE TABLE [JustRentIt.Neighborhood](
	nghId CHAR(9) NOT NULL, 
	nghName VARCHAR(30),
	nghHealthCenter INTEGER, 
	nghShopping INTEGER, 
	nghEntertainment INTEGER, 
	nghDinning INTEGER, 
	nghTransportation INTEGER, 
	nghEmployers INTEGER, 
	nghCrimeIndex INTEGER
	CONSTRAINT pk_Neighborhood_nghId PRIMARY KEY (nghId) )

CREATE TABLE [JustRentIt.Apartment](
	aptId CHAR(9) NOT NULL,
	nghId CHAR(9),
	aptName VARCHAR(50),
	aptPhoneNo CHAR(10),
	aptAddress VARCHAR(80), 
	aptWebsite VARCHAR(80),
	aptOpenDate DATE, 
	aptCampsDistance NUMERIC(3,2),
	aptGoogleReview NUMERIC(2,1)
	CONSTRAINT pk_Apartment_aptId PRIMARY KEY (aptId),
	CONSTRAINT fk_Apartment_nghId FOREIGN KEY (nghId)
		REFERENCES [JustRentIt.Neighborhood] (nghId)
		ON DELETE CASCADE ON UPDATE CASCADE )

CREATE TABLE [JustRentIt.Renter](
	rntId CHAR(9) NOT NULL, 
	rntFirstName VARCHAR(50),
	rntLastName VARCHAR(50), 
	rntPhoneNo CHAR(10), 
	rntEmail VARCHAR(100), 
	rntType VARCHAR(20)
	CONSTRAINT pk_Renter_rntId PRIMARY KEY (rntId) )

CREATE TABLE [JustRentIt.Corenter](
	rntID CHAR(9) NOT NULL,
	corentID CHAR(9) NOT NULL
	CONSTRAINT pk_Corenter_rntId_corentId PRIMARY KEY (rntId, corentId),
	CONSTRAINT fk_Corenter_rntId FOREIGN KEY (rntId)
		REFERENCES [JustRentIt.Renter] (rntId)
		ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_Corenter_corentId FOREIGN KEY (corentId)
		REFERENCES [JustRentIt.Renter] (rntId)
		ON DELETE NO ACTION ON UPDATE NO ACTION )

CREATE TABLE [JustRentIt.Company](
	cpyId CHAR(9) NOT NULL, 
	cpyName VARCHAR(50), 
	cpyPhoneNo CHAR(10), 
	cpyEmail VARCHAR(100), 
	cpyWebsite VARCHAR(100)
	CONSTRAINT pk_Company_cpyId PRIMARY KEY (cpyId) )

CREATE TABLE [JustRentIt.Own](
	aptId CHAR(9) NOT NULL,
	cpyId CHAR(9) NOT NULL
	CONSTRAINT pk_Own_aptId_cpyId PRIMARY KEY (aptId,cpyId),
	CONSTRAINT fk_Own_aptId FOREIGN KEY (aptId)
		REFERENCES [JustRentIt.Apartment] (aptId)
		ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_Own_cpyId FOREIGN KEY (cpyId)
		REFERENCES [JustRentIt.Company] (cpyId)
		ON DELETE CASCADE ON UPDATE CASCADE )

CREATE TABLE [JustRentIt.Employee](
	empId CHAR(9) NOT NULL, 
	aptId CHAR(9), 
	empFirstName VARCHAR(50),
	empLastName VARCHAR(50), 
	empPhoneNo CHAR(10), 
	empEmail VARCHAR(100), 
	empPosition VARCHAR(20)
	CONSTRAINT pk_Employee_empId PRIMARY KEY (empId),
	CONSTRAINT fk_Employee_aptId FOREIGN KEY (aptId)
		REFERENCES [JustRentIt.Apartment] (aptId)
		ON DELETE NO ACTION ON UPDATE NO ACTION )

CREATE TABLE [JustRentIt.Room](
	romId CHAR(9) NOT NULL,
	aptId CHAR(9) NOT NULL, 
	romType VARCHAR(6), 
	romPrice INTEGER, 
	romStatus VARCHAR(30)
	CONSTRAINT pk_Room_romId PRIMARY KEY (romId),
	CONSTRAINT fk_Room_aptId FOREIGN KEY (aptId)
		REFERENCES [JustRentIt.Apartment] (aptId)
		ON DELETE CASCADE ON UPDATE CASCADE )

CREATE TABLE [JustRentIt.Lease](
	leaseId CHAR(9) NOT NULL, 
	cpyId CHAR(9), 
	romId CHAR(9), 
	rntId CHAR(9), 
	leaseTotalPrice INTEGER, 
	leaseDeposit INTEGER, 
	leaseSignDate DATE, 
	leaseStartDate DATE, 
	leaseEndDate DATE
	CONSTRAINT pk_Lease_leaseId PRIMARY KEY (leaseId),
	CONSTRAINT fk_Lease_cpyId FOREIGN KEY (cpyId)
		REFERENCES [JustRentIt.Company] (cpyId)
		ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_Lease_romId FOREIGN KEY (romId)
		REFERENCES [JustRentIt.Room] (romId)
		ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_Lease_rntId FOREIGN KEY (rntId)
		REFERENCES [JustRentIt.Renter] (rntId)
		ON DELETE NO ACTION ON UPDATE NO ACTION )             