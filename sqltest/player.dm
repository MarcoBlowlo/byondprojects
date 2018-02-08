player
	parent_type = /mob
	var
		dbhandler/sql = new
	verb
		New_Character()
			var/name = input("Character Name") as text
			//set player by menu
			sql.query("SELECT PlayerID, Username FROM players")
			sql.exec()
			var/list/players = sql.fetch()
			var/list/choices = list()
			for(var/p in players) choices += p["Username"]
			var/user = input("Player this character belongs to") in choices as text
			var/playerid
			for(var/i=1; i<=players.len; i++)
				if(players[i]["Username"] == user)
					playerid = players[i]["PlayerID"]
					break
			sql.query("INSERT INTO Characters (Name, PlayerID) VALUES ('[name]', [playerid])")
			if(sql.exec()) world << "Query successfull"

		New_Player()
			var/username = input("Username") as text
			sql.query("INSERT INTO Players (Username) VALUES ('[username]')")
			if(sql.exec()) world << "Query successfull"

		New_Item()
		Query(qry as message)
			set category = "SQL"
			Queue(qry)
			Execute()
		Queue(qry as message)
			set category = "SQL"
			world << "<b><tt>" + qry + "</tt></b>"
			qry += ";"
			sql.query(qry)
		Execute()
			set category = "SQL"
			if(!sql.exec()) return
			var/list/data = sql.fetch()
			world << "([data.len] rows returned)"
			if(!data.len) return
			for(var/col in data[1])
				world << "<tt>[col]\t</tt>\..."
			world << ""
			for(var/i=0; i<length(data[1]); i++)
				world << "<tt>-----------</tt>\..."
			world << ""
			for(var/list/row in data)
				for(var/col in row)
					world << "<tt>[row[col]]\t</tt>\..."
				world << ""
			world << ""

	proc
		addToDatabase()
			sql.query("SELECT 1 FROM Players WHERE Username = [key]")

	Login()
		..()