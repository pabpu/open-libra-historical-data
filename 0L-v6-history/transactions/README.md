# 0L-v6-transactions

Currently the transactions prior to v7 fork cannot be seen in the [open libra block explorer](https://scan.openlibra.world), but in the 0LNetworkCommunity githup project a [dump of historical transactions can be found](https://raw.githubusercontent.com/0LNetworkCommunity/flying-fortress/refs/heads/main/db_snapshot/neo4j-2025-02-07T21-52-32.backup). A copy of this file can also be found here in the current repository: [neo4j-2025-02-07T21-52-32.backup](neo4j-2025-02-07T21-52-32.backup)

This file can be imported into neo4j-enterprise: 
```
sudo neo4j neo4j-admin database load --verbose --overwrite-destination=true --from-path=path-to-dump neo4j
```

...and then be evaluated by basic neoj4 expressions:

```
MATCH (s:Account)-[t:Tx]->(e:Account) 
order by t.block_datetime
RETURN s.address,t.block_datetime,t.function,t.coins,e.address;
```

A csv export of all transactions of the v6 network can be found here: [all-transactions-v6.csv](all-transactions-v6.csv)

