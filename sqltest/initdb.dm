proc
	initDB()
		var/dbhandler/dbh = new

		//Check if the tables exist first
		if(!dbh.tableExists("Players"))
			world << "Initializing Players table..."
			dbh.query("	CREATE TABLE Players(\
							PlayerID INTEGER PRIMARY KEY AUTOINCREMENT,\
							Username TEXT,\
							AccountStatus INTEGER DEFAULT 0,\
							Active TINYINT DEFAULT 1\
						)")
			if(dbh.exec())
				if(!dbh.tableExists("Players")) world << dbh.last_error
			else
				world << dbh.last_error

		if(!dbh.tableExists("Characters"))
			world << "Initializing Characters table..."
			dbh.query("	CREATE TABLE Characters(\
							CharacterID INTEGER PRIMARY KEY AUTOINCREMENT,\
							PlayerID INTEGER NOT NULL,\
							Name TEXT,\
							Level INTEGER DEFAULT 1,\
							Active TINYINT DEFAULT 1\
						)")
			if(dbh.exec())
				if(!dbh.tableExists("Players")) world << dbh.last_error
			else
				world << dbh.last_error

		if(!dbh.tableExists("Items"))
			world << "Initializing Items table..."
			dbh.query("	CREATE TABLE Items(\
							ItemID INTEGER PRIMARY KEY AUTOINCREMENT,\
							Name TEXT,\
							MaxStack INTEGER DEFAULT 1,\
							Active TINYINT DEFAULT 1\
						)")
			if(dbh.exec())
				if(!dbh.tableExists("Players")) world << dbh.last_error
			else
				world << dbh.last_error

		if(!dbh.tableExists("CharacterItem_xref"))
			world << "Initializing CharacterItem_xref table..."
			dbh.query("	CREATE TABLE CharacterItem_xref(\
							ItemID INTEGER NOT NULL,\
							CharacterID INTEGER NOT NULL,\
							Stack INTEGER DEFAULT 0,\
							Active TINYINT DEFAULT 1\
						)")
			if(dbh.exec())
				if(!dbh.tableExists("Players")) world << dbh.last_error
			else
				world << dbh.last_error