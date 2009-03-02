DROP TABLE groceries;
CREATE TABLE groceries (pk INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, position INTEGER, complete INTEGER);

DROP TABLE quick_list;
CREATE TABLE quick_list (pk INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, position INTEGER);

-- seed quick list
INSERT INTO quick_list (pk, title, position)
	VALUES (1, 'Milk', 0);
INSERT INTO quick_list (pk, title, position)
	VALUES (2, 'Bread', 1);
INSERT INTO quick_list (pk, title, position)
	VALUES (3, 'Cereal', 2);
INSERT INTO quick_list (pk, title, position)
	VALUES (4, 'Fruit', 3);
INSERT INTO quick_list (pk, title, position)
	VALUES (5, 'Bottled Water', 4);
