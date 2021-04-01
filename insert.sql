-- insert.sq

DROP CONSTRAINT 

-- 
INSERT INTO Property
  VALUES ( 1, 'Yonge st.', 'Toronto', 'ON', 'M3H3Z4', 2, 2, 10, 10, 'Remax')
;

-- seller
INSERT INTO Client
  (clientID, fName, lName, phone, email) 
  VALUES( 1, 'Spongebob', 'Squarepants', '416-666-5454', 'bob@sponga.com')
;

-- buyer
insert into Client
  (clientID, fName, lName, phone, email)
values(2, 'Patrick', 'Star', '345-345-3455', 'patrick@.ca');

-- bridge (add seller)
insert into PropertyClient 
  (propertyID, clientSellerID)
  Values (1, 1);

-- insert area
insert into Area 
  VALUES(1, 'North York', 'derp')
;

-- insert school
insert into school 
  values( 1, 'elementary', 'E', 1)
;

insert into school 
  values (2, 'middle', 'M', 1)
;

insert into school
  values (3, 'high school', 'H', 1)
;
