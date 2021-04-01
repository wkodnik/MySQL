-- Assigment 2 DBS301
DROP TABLE PropertyClient;
DROP TABLE Property;
DROP TABLE Client;

DROP TABLE School;
DROP TABLE Area;

CREATE TABLE Property (
  propertyID NUMBER(10) PRIMARY KEY,
  street VARCHAR2(38),
  city VARCHAR2(38),
  state VARCHAR2(38),
  postal VARCHAR2(7),
  beds NUMBER(2),
  baths NUMBER(2),
  listPrice NUMBER(5, 2),
  sellPrice NUMBER(5, 2),
  agency VARCHAR2(38),
  areaID NUMBER(10),
  CONSTRAINT property_areaid_fk FOREIGN KEY (areaID) REFERENCES Area(areaID)
);

CREATE TABLE Client (
  clientID NUMBER(10) PRIMARY KEY,
  fName VARCHAR2(38),
  lName VARCHAR2(38),
  phone VARCHAR2(38),
  email VARCHAR2(38),
  percentOwnership NUMBER(3, 2)
);

CREATE TABLE PropertyClient (
  propertyID NUMBER(10),
  clientBuyerID NUMBER(10),
  clientSellerID NUMBER(10),
  CONSTRAINT propertyID_FK FOREIGN KEY (propertyID) REFERENCES Property(propertyID),
  CONSTRAINT clientBuyerID_FK FOREIGN KEY (clientBuyerID) REFERENCES Client(clientID), 
  CONSTRAINT pc_clientSellerID_FK FOREIGN KEY (clientSellerID) REFERENCES Client(clientID), 
    PRIMARY KEY(propertyID, clientBuyerID, clientSellerID)
);


CREATE TABLE Area (
  areaID NUMBER(10) PRIMARY KEY, 
  areaName VARCHAR2(38), 
  areaComments VARCHAR2(38)
);

CREATE TABLE School (
  schoolID NUMBER(10) PRIMARY KEY,
  schoolName VARCHAR2(38),
  schoolLevel VARCHAR2(38),
  area NUMBER(10), 
  CONSTRAINT school_area_fk FOREIGN KEY (area) REFERENCES Area(areaID) 
);
