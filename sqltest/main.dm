world
	name = "SQL Test"
	mob = /player



player
	parent_type = /mob
	var
		dbhandle/sql = new/dbhandler
	verb


dbhandler
	var
		database/db
		database/query/qry
	proc
		use(dbname as text)
			del db
			db = new(dbname+".db")
		exec()
			if(!qry.Execute(db))
				world << qry.ErrorMsg
				return false
			return true
		query(q as text)
			qry.Add(q)
		fetch()
			var/list/rows = list()
			while(qry.NextRow())
				rows += qry.GetRowData()
			return rows