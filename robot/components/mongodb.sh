#!/bin/bash

```bash
# curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo
```

Install Mongo & Start Service.

```bash
# yum install -y mongodb-org
# systemctl enable mongod
# systemctl start mongod
```
Update Listen IP address from 127.0.0.1 to 0.0.0.0 in the config file, so that MongoDB can be accessed by other services.

Config file:   `# vim /etc/mongod.conf`

```bash
systemctl restart mongod
```

  

- Every Database needs the schema to be loaded for the application to work.

---

      `Download the schema and inject it.`

```
# curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"

# cd /tmp
# unzip mongodb.zip
# cd mongodb-main
# mongo < catalogue.js
# mongo < users.js
```