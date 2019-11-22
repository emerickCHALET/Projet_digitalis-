-- story 1 

CREATE DATABASE LeroyMerlu CHARACTER SET 'utf8_unicode_ci';

-- story 2

CREATE USER 'root2'@'localhost' IDENTIFIED BY 'password2'; -- creation 
GRANT ALL PRIVILLEGES ON *.* TO 'root2'@'localhost' WITH GRANT OPTION; --  attribution de tous les privillège

-- story 3

CREATE TABLE consumer(
    idConsumer INT UNSIGNED NOT NULL AUTO_INCREMENT,
    surname VARCHAR (80) NOT NULL,
    name VARCHAR (80) NOT NULL,
    mail VARCHAR (200) NOT NULL,
    mdp VARCHAR (200) NOT NULL,
    phone INT (10), 
    address VARCHAR (200),
    postalCode VARCHAR (8),
    nearestHeadquarters VARCHAR (120),
    distanceHomeHeadquarters INT (3),
    userRole BOOLEAN, -- 1 client et 0 administrateur
    PRIMARY KEY (idConsumer)
    )
    ENGINE = INNODB; 

CREATE TABLE project (
    idProject INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nameProject VARCHAR (80) NOT NULL,
    creationDate DATE NOT NULL,
    descriptionProject TEXT NOT NULL, 
    endDateProject DATE,
    idConsumer INT (10),
    PRIMARY KEY (idProject), 
    CONSTRAINT fr_key1 FOREIGN KEY (idConsumer) REFERENCES consumer (id) ON DELETE CASCADE ON UPDATE CASCADE
    )
    ENGINE = INNODB; 

CREATE TABLE product (
    idProduct INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nameProduct TEXT NOT NULL,
    dateProductAddition DATE NOT NULL,
    PRIMARY KEY (idProduct)
    )
    ENGINE = INNODB; 

    CREATE TABLE productProject (
    idProductProject INT UNSIGNED NOT NULL AUTO_INCREMENT,
    idProject INT UNSIGNED NOT NULL, 
    idProduct INT UNSIGNED NOT NULL,
    totalWidth FLOAT(10,2) NOT NULL,
    totalLenght FLOAT(10,2) NOT NULL,
    totalThickness FLOAT(10,2) NOT NULL,
    priceWithoutVAT FLOAT(10,2) NOT NULL,
    priceWithVAT FLOAT(10,2) NOT NULL,
    PRIMARY KEY (idProductProject),
    CONSTRAINT fr_key2 FOREIGN KEY (idProject) REFERENCES project(idProject) ON DELETE CASCADE,
    CONSTRAINT fr_key3 FOREIGN KEY (idProduct) REFERENCES product(idProduct) ON DELETE CASCADE
    )
    ENGINE = INNODB; 

CREATE TABLE customizationModuleDoor (
    idcustomizationModuleDoor INT UNSIGNED NOT NULL AUTO_INCREMENT,
    idProductProject INT UNSIGNED NOT NULL, 
    idMaterial INT(10) UNSIGNED NOT NULL,
    moduleColor VARCHAR(10) NOT NULL,
    moduleWidth FLOAT(10,2) NOT NULL,
    moduleLenght FLOAT(10,2) NOT NULL,
    PRIMARY KEY (idcustomizationModuleDoor),
    CONSTRAINT fr_key4 FOREIGN KEY (idProductProject) REFERENCES productProject(idProductProject) ON DELETE CASCADE,
    CONSTRAINT fr_key6 FOREIGN KEY (idMaterial) REFERENCES material(idMaterial) ON DELETE CASCADE
    )
    ENGINE = INNODB; 

CREATE TABLE material (
    idMaterial INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nameProductMaterial text NOT NULL, 
    pricePerM2WithoutVAT FLOAT(10,2) NOT NULL,
    pricePerM2WithVAT FLOAT(10,2) NOT NULL,
    PRIMARY KEY (idMaterial)
    )
    ENGINE = INNODB; 

CREATE TABLE invoice (
    idInvoice INT UNSIGNED NOT NULL AUTO_INCREMENT,
    idProject INT UNSIGNED NOT NULL, 
    dateCreationInvoice datetime not null, 
    paymentMethod text NOT NULL,
    invoiceStatus boolean not null, -- 1 factures payés et 0 facture impayés
    paymentDate date not null, 
    PRIMARY KEY (idInvoice),
    CONSTRAINT fr_key5 FOREIGN KEY (idProject) REFERENCES project(idProject) on DELETE CASCADE
    )
    ENGINE = INNODB; 

-- Story 4

INSERT INTO consumer (surname, name, mail, mdp, phone, address, postalCode, nearestHeadquarters, distanceHomeHeadquarters, userRole)
VALUES ('Cressac', 'Laurene', 'LaureneCressac@teleworm.us', 'gie6Eishee', '0300152154', '5 Chemin Challet', '62800', 'Lens', '12', '1'), 
('Duplessis', 'Chirstian', 'ChristianDuplessis@dayrep.com', 'Ez3PheX0ai', '0230704204', '72 avenue Jean Portalis', '45510', 'Tours Sud', '149', '1'), 
('Théberge', 'Ray', 'RayTheberge@dayrep.com', 'ahyaBae4o', '0448282237', '71 avenue de Provence', '06220', 'Nantes', '632', '1'),
('Cloutier', 'Claire', 'ClaireCloutier@teleworm.us', 'ohl0Aeghei', '0274967438', '16 rue Charles Corbeau', '76400', 'Le Mans', '256', '1')
    
INSERT INTO consumer (surname, name, mail, mdp, phone, address, postalCode, nearestHeadquarters, distanceHomeHeadquarters, userRole)
VALUES ('Tearlach', 'Brunault', 'TearlachBrunault@teleworm.us', 'uvahCiY1oh', NULL, NULL, NULL, NULL, NULL, '0')

-- story 5 

INSERT INTO project (nameProject, creationDate, descriptionProject, endDateProject, idConsumer)
VALUES ('renovation energetique', '2019-11-13', 'changement des vitrages pour consommer moins', '2020-01-26', '1'),
('nouveaux vitrages', '2020-02-13', 'changement des vitrages pour des doubles vitrages', '2020-05-15',  '2' ),
('porte design', '2018-10-30', 'avoir une jolie porte de garage', '2018-12-26', '2'),
('remplacer mes vitraux', '2020-03-25', 'changement des vitraux de mon usine', '2020-06-05', '3' ),
('remplacer mes portes', '2020-09-25', 'changement des portes de mon usine', '2020-11-25', '3' ),
('changement portes', '2020-02-01', 'changement des portes de garages et de maisons', '2020-05-03', '1'), 
('retape ma ruine 1', '2018-06-05', 'je retape mon chateau et souhaite changer les fenetres des dependences et des ecuries', '2018-11-06', '4'),
('retape ma ruine 2', '2019-07-03', 'je retape mon chateau et souhaite changer les fenetres des dependences et des ecuries', '2019-11-06', '4'),
('retape ma ruine 3', '2020-03-10', 'retape un chateau, je souhaite changer les fenetres de l etage', '2020-07-10', '4'), 
('retape ma ruine 4', '2020-08-03', 'retape toujours mon chateau, je souhaite remplacer les fenetres des etages superieurs', '2020-12-27', '4')

-- story 6

INSERT INTO product (nameProduct, dateProductAddition)
VALUES ('Les portes', '2018-01-01'),
('Les baies vitres', '2018-01-01')

-- story 7

INSERT INTO productProject (idProduct,idProject,priceWithoutVAT,priceWithVAT,totalLenght,totalThickness,totalWidth)
VALUES(1,6,400,475,1200,80,2100),(1,6,400,475,1200,70,2100),(1,6,700,780,3000,50,2500);

-- story 8 

INSERT INTO customizationModuleDoor (idProductProject, moduleColor, idMaterial, moduleWidth, moduleLenght)
VALUES (1, 'bleu', 1, 960, 2180), 
(1, 'orange', 2, 250, 120), 
(1, 'vert', 2, 250, 120)

-- story 9 

INSERT INTO material (nameProductMaterial, pricePerM2WithoutVAT, pricePerM2WithVAT)
VALUES ('Bois',9.69,12.12),
('PVC', 18.4, 23),
('Alu', 11.97,14.97),
('PVC et Bois', 14.04, 17.56)

-- story 10

INSERT INTO invoice (idProject, dateCreationInvoice, paymentMethod, invoiceStatus, paymentDate)
VALUES (6, '2020-05-03', 'cb', '0', '2020-06-03'), 
(1, '2020-01-26', 'bitcoin', '0', '2020-02-26'), 
(3, '2018-12-26', 'espece', '1', '2019-01-26'), 
(9, '2020-07-10', 'cheque', '0', '2020-08-10')

-- story 11

UPDATE LeroyMerlu.consumer 
SET mdp = md5(mdp); 
SELECT id, mail, mdp
FROM consumer

-- story 12

SELECT nameProject, creationDate, descriptionProject
FROM project ORDER BY creationDate DESC; 

-- story 12 bis 

SELECT nameProject, creationDate, descriptionProject, idConsumer
FROM project 
WHERE idConsumer = 4
ORDER BY creationDate ASC; 

-- story 13

SELECT name, surname ,mail, phone, address, postalCode, id, COUNT(idConsumer)AS nombreProjets
FROM consumer
LEFT JOIN project
ON consumer.id = project.idConsumer
WHERE project.idConsumer = 4

-- story 14

UPDATE consumer 
set surname = 'Cressac' , name = 'Laurene', mail = 'LaureneCressac@teleworm.us', mdp = 'gie6Eishee', phone = '300152154', address = '5 Chemin Challet', postalCode = '62800', nearestHeadquarters = 'Lens', distanceHomeHeadquarters = '12'
where idConsumer = 1; 

-- story 15 

SELECT nameProject, creationDate, descriptionProject, nameProduct, dateProductAddition
FROM project
LEFT JOIN productProject
ON project.idProject = productProject.idProject
LEFT JOIN product
ON productProject.idProduct = product.idProduct
where project.idProject = 6 

-- story 16

SELECT nameProduct, moduleColor, nameProductMaterial, moduleWidth, moduleLenght
FROM product
LEFT JOIN productProject
ON product.idProduct = productProject.idProduct
LEFT JOIN customizationModuleDoor
ON productProject.idProductProject = customizationModuleDoor.idProductProject
LEFT JOIN material
ON customizationModuleDoor.idMaterial = material.idMaterial
WHERE productProject.idProject = 6

-- story 17

SELECT nameProject, descriptionProject, creationDate
FROM project
WHERE project.idConsumer = 4

-- story 18 

SELECT nameProject, descriptionProject, SUM(priceWithoutVAT) as priceWithoutVAT, SUM(priceWithVAT) as priceWithVAT
FROM project
LEFT JOIN productProject
ON project.idProject = productProject.idProject
WHERE project.idProject = 6 

-- story 19 

SELECT name, surname, nameProject, creationDate, 
(CASE 
WHEN distanceHomeHeadquarters < 100 THEN 'pas de majoration'
WHEN distanceHomeHeadquarters >= 100 AND distanceHomeHeadquarters < 250 THEN '20'
WHEN distanceHomeHeadquarters >= 250 AND distanceHomeHeadquarters < 350 THEN '75'
WHEN distanceHomeHeadquarters >= 350 AND distanceHomeHeadquarters < 450 THEN '125'
ELSE 'projet non rentable et non réalisable'
END) as majoration
FROM consumer
LEFT JOIN project
ON consumer.id = project.idConsumer

-- story 20 

SELECT nameProject, descriptionProject, SUM(priceWithoutVAT) as priceWithoutVAT, SUM(priceWithVAT) as priceWithVAT, (CASE 
WHEN distanceHomeHeadquarters < 100 THEN 'pas de majoration' AND SUM(priceWithVAT)
WHEN distanceHomeHeadquarters >= 100 AND distanceHomeHeadquarters < 250 THEN '20' AND SUM(priceWithVAT)
WHEN distanceHomeHeadquarters >= 250 AND distanceHomeHeadquarters < 350 THEN '75' AND SUM(priceWithVAT)
WHEN distanceHomeHeadquarters >= 350 AND distanceHomeHeadquarters < 450 THEN '125' AND SUM(priceWithVAT)
ELSE 'projet non rentable et non réalisable' 
END) as majoration, endDateProject
FROM productProject
LEFT JOIN project
ON productProject.idProject = project.idProject
LEFT JOIN consumer
ON project.idConsumer = consumer.id
WHERE endDateProject < NOW()

-- story 20 bis la requete ne fonctionne pas 

SELECT moduleColor, nameProductMaterial, moduleWidth, moduleLenght, productPorject.priceWithVAT, priceWithoutVAT, (CASE 
WHEN distanceHomeHeadquarters < 100 THEN '0' 
WHEN distanceHomeHeadquarters >= 100 AND distanceHomeHeadquarters < 250 THEN '20' 
WHEN distanceHomeHeadquarters >= 250 AND distanceHomeHeadquarters < 350 THEN '75' 
WHEN distanceHomeHeadquarters >= 350 AND distanceHomeHeadquarters < 450 THEN '125' 
ELSE 'projet non rentable et non réalisable' 
END) as majorationWithoutVAT, (CASE 
WHEN distanceHomeHeadquarters < 100 THEN '0' 
WHEN distanceHomeHeadquarters >= 100 AND distanceHomeHeadquarters < 250 THEN '20' 
WHEN distanceHomeHeadquarters >= 250 AND distanceHomeHeadquarters < 350 THEN '75' 
WHEN distanceHomeHeadquarters >= 350 AND distanceHomeHeadquarters < 450 THEN '125' 
ELSE 'projet non rentable et non réalisable' 
END) as majorationWithVAT
FROM material
LEFT JOIN customizationModuleDoor
ON material.idMaterial = customizationModuleDoor.idMaterial
LEFT JOIN productProject
ON  productProject.idProductProject = customizationModuleDoor.idProductProject
LEFT JOIN project
ON productProject.idProject = project.idProject
LEFT JOIN consumer
ON project.idConsumer = consumer.id
WHERE consumer.id = 1
GROUP BY moduleColor

-- story 21 modification de la consigne car avec l'ID du projet ce n'était pas possible, car c'est le matériel que l'on modifie et non la couleur du module

UPDATE customizationModuleDoor
SET customizationModuleDoor.idMaterial = 3
WHERE customizationModuleDoor.idcustomizationModuleDoor = 2;

-- story 22

SELECT '06/2018' AS Month, COUNT(DISTINCT project.idProject) AS totalProject, SUM(productProject.priceWithVAT) AS totalPrice
FROM project 
LEFT JOIN productProject 
ON project.idProject = productProject.idProject
WHERE ((project.endDateProject >= '2018-06-01') AND (project.endDateProject <='2018-07-01'))

UNION 

SELECT '07/2018' AS Month, COUNT(DISTINCT project.idProject) AS totalProject, SUM(productProject.priceWithVAT) AS totalPrice
FROM project 
LEFT JOIN productProject 
ON project.idProject = productProject.idProject
WHERE ((project.endDateProject >= '2018-07-01') AND (project.endDateProject <='2018-08-01'))

UNION

SELECT '08/2018' AS Month, COUNT(DISTINCT project.idProject) AS totalProject, SUM(productProject.priceWithVAT) AS totalPrice
FROM project 
LEFT JOIN productProject 
ON project.idProject = productProject.idProject
WHERE ((project.endDateProject >= '2018-08-01') AND (project.endDateProject <='2018-09-01'))

UNION

SELECT '09/2018' AS Month, COUNT(DISTINCT project.idProject) AS totalProject, SUM(productProject.priceWithVAT) AS totalPrice
FROM project 
LEFT JOIN productProject 
ON project.idProject = productProject.idProject
WHERE ((project.endDateProject >= '2018-09-01') AND (project.endDateProject <='2018-10-01'))

UNION

SELECT '10/2018' AS Month, COUNT(DISTINCT project.idProject) AS totalProject, SUM(productProject.priceWithVAT) AS totalPrice
FROM project 
LEFT JOIN productProject 
ON project.idProject = productProject.idProject
WHERE ((project.endDateProject >= '2018-10-01') AND (project.endDateProject <='2018-11-01'))

UNION

SELECT '11/2018' AS Month, COUNT(DISTINCT project.idProject) AS totalProject, SUM(productProject.priceWithVAT) AS totalPrice
FROM project 
LEFT JOIN productProject 
ON project.idProject = productProject.idProject
WHERE ((project.endDateProject >= '2018-11-01') AND (project.endDateProject <='2018-12-01'))

UNION

SELECT '12/2018' AS Month, COUNT(DISTINCT project.idProject) AS totalProject, SUM(productProject.priceWithVAT) AS totalPrice
FROM project 
LEFT JOIN productProject 
ON project.idProject = productProject.idProject
WHERE ((project.endDateProject >= '2018-12-01') AND (project.endDateProject <='2018-12-31'))

UNION

SELECT '01/2019' AS Month, COUNT(DISTINCT project.idProject) AS totalProject, SUM(productProject.priceWithVAT) AS totalPrice
FROM project 
LEFT JOIN productProject 
ON project.idProject = productProject.idProject
WHERE ((project.endDateProject >= '2019-01-01') AND (project.endDateProject <='2019-02-01'))

UNION

SELECT '02/2019' AS Month, COUNT(DISTINCT project.idProject) AS totalProject, SUM(productProject.priceWithVAT) AS totalPrice
FROM project 
LEFT JOIN productProject 
ON project.idProject = productProject.idProject
WHERE ((project.endDateProject >= '2019-02-01') AND (project.endDateProject <='2019-03-01'))

UNION

SELECT '03/2019' AS Month, COUNT(DISTINCT project.idProject) AS totalProject, SUM(productProject.priceWithVAT) AS totalPrice
FROM project 
LEFT JOIN productProject 
ON project.idProject = productProject.idProject
WHERE ((project.endDateProject >= '2019-03-01') AND (project.endDateProject <='2019-04-01'))

UNION

SELECT '04/2019' AS Month, COUNT(DISTINCT project.idProject) AS totalProject, SUM(productProject.priceWithVAT) AS totalPrice
FROM project 
LEFT JOIN productProject 
ON project.idProject = productProject.idProject
WHERE ((project.endDateProject >= '2019-04-01') AND (project.endDateProject <='2019-05-01'))

UNION

SELECT '05/2019' AS Month, COUNT(DISTINCT project.idProject) AS totalProject, SUM(productProject.priceWithVAT) AS totalPrice
FROM project 
LEFT JOIN productProject 
ON project.idProject = productProject.idProject
WHERE ((project.endDateProject >= '2019-05-01') AND (project.endDateProject <='2019-06-01'))

UNION  

SELECT '06/2019' AS Month, COUNT(DISTINCT project.idProject) AS totalProject, SUM(productProject.priceWithVAT) AS totalPrice
FROM project 
LEFT JOIN productProject 
ON project.idProject = productProject.idProject
WHERE ((project.endDateProject >= '2019-06-01') AND (project.endDateProject <='2019-07-01'))

UNION 

SELECT '07/2019' AS Month, COUNT(DISTINCT project.idProject) AS totalProject, SUM(productProject.priceWithVAT) AS totalPrice
FROM project 
LEFT JOIN productProject 
ON project.idProject = productProject.idProject
WHERE ((project.endDateProject >= '2019-07-01') AND (project.endDateProject <='2019-08-01'))

UNION

SELECT '08/2019' AS Month, COUNT(DISTINCT project.idProject) AS totalProject, SUM(productProject.priceWithVAT) AS totalPrice
FROM project 
LEFT JOIN productProject 
ON project.idProject = productProject.idProject
WHERE ((project.endDateProject >= '2019-08-01') AND (project.endDateProject <='2019-09-01'))

UNION

SELECT '09/2019' AS Month, COUNT(DISTINCT project.idProject) AS totalProject, SUM(productProject.priceWithVAT) AS totalPrice
FROM project 
LEFT JOIN productProject 
ON project.idProject = productProject.idProject
WHERE ((project.endDateProject >= '2019-09-01') AND (project.endDateProject <='2019-10-01'))

UNION

SELECT '10/2019' AS Month, COUNT(DISTINCT project.idProject) AS totalProject, SUM(productProject.priceWithVAT) AS totalPrice
FROM project 
LEFT JOIN productProject 
ON project.idProject = productProject.idProject
WHERE ((project.endDateProject >= '2019-10-01') AND (project.endDateProject <='2019-11-01'))

UNION

SELECT '11/2019' AS Month, COUNT(DISTINCT project.idProject) AS totalProject, SUM(productProject.priceWithVAT) AS totalPrice
FROM project 
LEFT JOIN productProject 
ON project.idProject = productProject.idProject
WHERE ((project.endDateProject >= '2019-11-01') AND (project.endDateProject <='2019-12-01'))

UNION

SELECT '12/2019' AS Month, COUNT(DISTINCT project.idProject) AS totalProject, SUM(productProject.priceWithVAT) AS totalPrice
FROM project 
LEFT JOIN productProject 
ON project.idProject = productProject.idProject
WHERE ((project.endDateProject >= '2019-12-01') AND (project.endDateProject <='2019-12-31'))

UNION 

SELECT '01/2020' AS Month, COUNT(DISTINCT project.idProject) AS totalProject, SUM(productProject.priceWithVAT) AS totalPrice
FROM project 
LEFT JOIN productProject 
ON project.idProject = productProject.idProject
WHERE ((project.endDateProject >= '2020-01-01') AND (project.endDateProject <='2020-02-01'))

UNION

SELECT '02/2020' AS Month, COUNT(DISTINCT project.idProject) AS totalProject, SUM(productProject.priceWithVAT) AS totalPrice
FROM project 
LEFT JOIN productProject 
ON project.idProject = productProject.idProject
WHERE ((project.endDateProject >= '2020-02-01') AND (project.endDateProject <='2020-03-01'))

UNION

SELECT '03/2020' AS Month, COUNT(DISTINCT project.idProject) AS totalProject, SUM(productProject.priceWithVAT) AS totalPrice
FROM project 
LEFT JOIN productProject 
ON project.idProject = productProject.idProject
WHERE ((project.endDateProject >= '2020-03-01') AND (project.endDateProject <='2020-04-01'))

UNION

SELECT '04/2020' AS Month, COUNT(DISTINCT project.idProject) AS totalProject, SUM(productProject.priceWithVAT) AS totalPrice
FROM project 
LEFT JOIN productProject 
ON project.idProject = productProject.idProject
WHERE ((project.endDateProject >= '2020-04-01') AND (project.endDateProject <='2020-05-01'))

UNION

SELECT '05/2020' AS Month, COUNT(DISTINCT project.idProject) AS totalProject, SUM(productProject.priceWithVAT) AS totalPrice
FROM project 
LEFT JOIN productProject 
ON project.idProject = productProject.idProject
WHERE ((project.endDateProject >= '2020-05-01') AND (project.endDateProject <='2020-06-01'))

UNION  

SELECT '06/2020' AS Month, COUNT(DISTINCT project.idProject) AS totalProject, SUM(productProject.priceWithVAT) AS totalPrice
FROM project 
LEFT JOIN productProject 
ON project.idProject = productProject.idProject
WHERE ((project.endDateProject >= '2020-06-01') AND (project.endDateProject <='2020-07-01'))

UNION 

SELECT '07/2020' AS Month, COUNT(DISTINCT project.idProject) AS totalProject, SUM(productProject.priceWithVAT) AS totalPrice
FROM project 
LEFT JOIN productProject 
ON project.idProject = productProject.idProject
WHERE ((project.endDateProject >= '2020-07-01') AND (project.endDateProject <='2020-08-01'))

UNION

SELECT '08/2020' AS Month, COUNT(DISTINCT project.idProject) AS totalProject, SUM(productProject.priceWithVAT) AS totalPrice
FROM project 
LEFT JOIN productProject 
ON project.idProject = productProject.idProject
WHERE ((project.endDateProject >= '2020-08-01') AND (project.endDateProject <='2020-09-01'))

UNION

SELECT '09/2020' AS Month, COUNT(DISTINCT project.idProject) AS totalProject, SUM(productProject.priceWithVAT) AS totalPrice
FROM project 
LEFT JOIN productProject 
ON project.idProject = productProject.idProject
WHERE ((project.endDateProject >= '2020-09-01') AND (project.endDateProject <='2020-10-01'))

UNION

SELECT '10/2020' AS Month, COUNT(DISTINCT project.idProject) AS totalProject, SUM(productProject.priceWithVAT) AS totalPrice
FROM project 
LEFT JOIN productProject 
ON project.idProject = productProject.idProject
WHERE ((project.endDateProject >= '2020-10-01') AND (project.endDateProject <='2020-11-01'))

UNION

SELECT '11/2020' AS Month, COUNT(DISTINCT project.idProject) AS totalProject, SUM(productProject.priceWithVAT) AS totalPrice
FROM project 
LEFT JOIN productProject 
ON project.idProject = productProject.idProject
WHERE ((project.endDateProject >= '2020-11-01') AND (project.endDateProject <='2020-12-01'))

UNION

SELECT '12/2020' AS Month, COUNT(DISTINCT project.idProject) AS totalProject, SUM(productProject.priceWithVAT) AS totalPrice
FROM project 
LEFT JOIN productProject 
ON project.idProject = productProject.idProject
WHERE ((project.endDateProject >='2020-12-01') AND (project.endDateProject <='2020-12-31'))

-- story 23 

SELECT nameProductMaterial,customizationModuleDoor.idMaterial, COUNT(*) AS TOP3
FROM customizationModuleDoor
LEFT JOIN material
ON customizationModuleDoor.idMaterial = material.idMaterial
GROUP BY idMaterial DESC;





























