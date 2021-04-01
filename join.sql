-- join sql

CREATE VIEW HomeOwner as
  SELECT * from Property 
  JOIN PropertyClient USING (propertyID)
  WHERE clientSellerID = (select clientID from Client where lName LIKE 'Squarepants')
;

create view 
