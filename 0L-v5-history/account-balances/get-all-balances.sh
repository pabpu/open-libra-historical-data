#!/bin/sh


total=0
num_accounts=0

printbalance() {
  balance=`ol --account $1 query | sed 's/.*[^0-9]\([0-9]\+\)$/\1/g'`
  account_not_found=`echo $balance | grep No`
  if [ "$account_not_found" != "" ] ; then
	  balance=0
  fi
  coins=`expr $balance / 1000000`
  total=`expr $total + $coins`
  num_accounts=`expr $num_accounts + 1`
  echo $1','$coins
}

for account in `cat ../input-data/all-v5-accounts.txt`
do
	printbalance $account
done

echo num accounts,$num_accounts
echo total amount,$total
