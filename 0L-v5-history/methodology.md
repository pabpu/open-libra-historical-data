# Historical account balances of the open libra v5 network

The idea to get all historical account balances is to restore a snapshot from the epoch archive and then run a v5 open libra node.
As the v5 network is not running any longer, the node will just come up with the data from the snapshot and not start syncing to a newer state. So, when issuing a query command, the account balances will reflect the state as per the restored epoch-archive.

## epoch numbers

A mapping between epoch numbers and dates can be found here - unfortunately data in this mapping file is only available until march of 2023.

https://docs.google.com/spreadsheets/d/1_vEFRrWGKqqdn8pz68irq_iiNJrI1diDPDUxlw1jo4M/edit?pli=1#gid=0 - a copy is saved here: [0L-Inflation.ods](input-data/0L-Inflation.ods)

For simplicity, a csv transformation of date and epoch is stored in here: [epochs-and-dates.csv](input-data/epochs-and-dates.csv)

Further date to epoch mappings can be found in the epoch archive itself: [epoch-archive](https://github.com/OLSF/epoch-archive)

## account numbers

A dump of all account numbers that ever existed in the v5 network can be found here: [all-v5-accounts.txt](input-data/all-v5-accounts.txt). This file is based on a later dump of at the end of the v6 network, but only the old accounts beginning with 00000000000000000000000000000000 were extracted: https://raw.githubusercontent.com/0LNetworkCommunity/libra-framework/release-7.0.0/tools/storage/json/accounts_state_epoch_79_ver_33217173.795d.json . A copy of this file is also stored here: [accounts_state_epoch_79_ver_33217173.795d.json](input-data/accounts_state_epoch_79_ver_33217173.795d.json)


## preparing the open libra node

Standard setup of v5 libra according to docs in the libra repository in the [documentation](https://github.com/0LNetworkCommunity/libra-legacy-v6/tree/v5/ol/documentation) sub folder. Short version:

```
git clone https://github.com/0LNetworkCommunity/libra-legacy-v6
cd libra-legacy-v6
git checkout release-v5.2.0
make deps
make bins install
```

## restoring an epoch

Find the epoch number of interest in [epochs-and-dates.csv](input-data/epochs-and-dates.csv), fetch and extract the according tar.gz file from the epoch archive and call the restore-all make target:

```
git clone https://github.com/0LNetworkCommunity/epoch-archive-v5
cd epoch-archive
gzip -dc 415.tar.gz | tar xvf -
EPOCH=415 make restore-all
```

after restoring an epoch, the epoch and waypoint have to be added to the 0L.toml config file, e.g. :

```
[chain_info]
chain_id = "1"
base_epoch = 415
base_waypoint = "88531010:c87da5c0d5b0c0e35331b166102d510e4eaa84c73db87ed6fd3d026ed3019117"
```


## running a node

After setup and restoring an epoch archive, the node can be started:

```
diem-node -f ~/.0L/validator.node.yaml
```


## querying the balance

With a running node, balances of each account can be retrieved:

```
ol --account <account-number> query
```

The figure displayed divided by 1000000 shows the number of open libra coins for the given account.
A script to fetch all accounts data can be found here: [get-all-balances.sh](account-balances/get-all-balances.sh)

## result

Extracted account balances for some epochs are saved in the [account-balances](account-balances) folder.




