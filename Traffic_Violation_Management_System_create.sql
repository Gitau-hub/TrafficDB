USE TRAFFICMANAGEMENT; 

CREATE TABLE Driver (
    DriverId int  NOT NULL,
    FirstName varchar(40)  NOT NULL,
    LastName varchar(30)  NOT NULL,
    LicenseNumber int  NOT NULL,
    Address int  NOT NULL,
    PhoneNumber int  NOT NULL,
    Vehicle_VehicleId int  NOT NULL,
    Violation_ViolationId int  NOT NULL,
    Vehicle_2_VehicleId int  NOT NULL,
    CONSTRAINT DriverId PRIMARY KEY (DriverId)
) COMMENT 'Stores driver information';

-- Table: FinePayment
CREATE TABLE FinePayment (
    PaymentId int  NOT NULL,
    ViolationId int  NOT NULL,
    PaymentDate DATETIME  NOT NULL,
    PaymentMethod ENUM('Cash', 'Card', 'Online')  NOT NULL,
    AmountPaid decimal(10,2)  NOT NULL,
    UNIQUE INDEX ViolationId (ViolationId),
    CONSTRAINT FinePayment_pk PRIMARY KEY (PaymentId)
) COMMENT 'Manages fine payments.';

-- Table: Officer
CREATE TABLE Officer (
    OfficerId int  NOT NULL,
    BadgeNumber int  NOT NULL,
    FirstName varchar(50)  NOT NULL,
    LastName varchar(50)  NOT NULL,
    OffRank varchar(20)  NOT NULL,
    CONSTRAINT OfficerId PRIMARY KEY (OfficerId)
) COMMENT 'Tracks Law Enforcement Officers';

-- Table: Vehicle
CREATE TABLE Vehicle (
    VehicleId int  NOT NULL,
    LicensePlate int  NOT NULL,
    Make varchar(50)  NOT NULL,
    Model varchar(50)  NOT NULL,
    Year int  NOT NULL,
    OwnerId int  NOT NULL,
    UNIQUE INDEX OwnerId (OwnerId),
    CONSTRAINT VehicleId PRIMARY KEY (VehicleId)
) COMMENT 'Stores Vehicle Details';

-- Table: Violation
CREATE TABLE Violation (
    ViolationId int  NOT NULL,
    VehicleId int  NOT NULL,
    ViolationType varchar(50)  NOT NULL,
    ViolationDate DATETIME  NOT NULL,
    Location varchar(100)  NOT NULL,
    FineAmount decimal(10,2)  NOT NULL,
    Status ENUM ('Pending','Paid')  NOT NULL,
    DriverId int  NOT NULL,
    OfficerId int  NOT NULL,
    UNIQUE INDEX DriverId (DriverId),
    UNIQUE INDEX VehicleId (VehicleId),
    UNIQUE INDEX OfficerId (OfficerId),
    CONSTRAINT Violation_pk PRIMARY KEY (ViolationId)
) COMMENT 'Details Traffic Violations';

-- foreign keys
-- Reference: Driver_Vehicle (table: Vehicle)
ALTER TABLE Vehicle ADD CONSTRAINT Driver_Vehicle FOREIGN KEY Driver_Vehicle (OwnerId)
    REFERENCES Driver (DriverId);

-- Reference: Violation_Driver (table: Violation)
ALTER TABLE Violation ADD CONSTRAINT Violation_Driver FOREIGN KEY Violation_Driver (DriverId)
    REFERENCES Driver (DriverId);

-- Reference: Violation_FinePayment (table: FinePayment)
ALTER TABLE FinePayment ADD CONSTRAINT Violation_FinePayment FOREIGN KEY Violation_FinePayment (ViolationId)
    REFERENCES Violation (ViolationId);

-- Reference: Violation_Officer (table: Violation)
ALTER TABLE Violation ADD CONSTRAINT Violation_Officer FOREIGN KEY Violation_Officer (OfficerId)
    REFERENCES Officer (OfficerId);

-- Reference: Violation_Vehicle (table: Violation)
ALTER TABLE Violation ADD CONSTRAINT Violation_Vehicle FOREIGN KEY Violation_Vehicle (VehicleId)
    REFERENCES Vehicle (VehicleId);

-- End of file.

