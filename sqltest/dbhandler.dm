dbhandler
	var
		database/db = new(DEFAULT_DB+".db")
		database/query/qry = new
		last_error = ""
	proc
		use(dbname as text)
			db.Open(dbname+".db")
		exec()
			if(!qry.Execute(db))
				last_error = qry.ErrorMsg()
				world << "<b><tt><font color=red>" + last_error + "</font></tt></b>"
				return FALSE
			return TRUE
		query(q as text)
			qry.Add(q)
		fetch()
			var/list/rows = list()
			while(qry.NextRow())
				rows += list(qry.GetRowData())
			return rows
		tableExists(table as text)
			query("SELECT 1 FROM [table]")
			return exec()