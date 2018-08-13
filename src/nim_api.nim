import jester, asyncdispatch, json, db_mysql


# set db
let db = open("your_ip_address", "root", "hogehoge", "nim_api")

# router
routes:

  # root
  get "/":
    resp "Hello World!"

  # information of all users
  get "/users":

    # query
    var rows = db.getAllRows(sql"select * from memberlist")

    # format row datas
    var users: seq[JsonNode]
    users = @[]
    for row in rows:
      users.add(%*{
        "id": row[0],
        "name": row[1],
        "place": row[2],
        "age": row[3],
      })
    
    # set to data
    var data = %*{
      "total": users.len,
      "users": users,
    }

    resp $data, "application/json"

  # information of a user
  get "/users/@username":

    # query
    var row = db.getRow(sql"select * from memberlist where name = ?", @"username")

    # set to object
    var data = %*{
      "id": row[0],
      "name": row[1],
      "place": row[2],
      "age": row[3],
    }
    resp $data, "application/json"

runForever()
