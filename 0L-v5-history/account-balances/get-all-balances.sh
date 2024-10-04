#!/bin/sh


total=0
num_accounts=0

printbalance() {
  balance=`ol --account $1 query | sed 's/.*[^0-9]\([0-9]\+\)$/\1/g'`
  account_not_found=`echo $balance | grep No`
  if [ "$account_not_found" != "" ] ; then
	coins="n/a"
  else
	#coins=`echo "scale=2;($balance+5000)/1000000"| bc` 
	coins=`echo "scale=6;$balance/1000000"| bc | sed 's/^\./0./'`
  	total=`expr $total + $balance`
  	num_accounts=`expr $num_accounts + 1`
  fi
  echo $1','$coins
}

for account in `cat ../input-data/all-v5-accounts.txt`
do
	printbalance $account
done

echo num accounts on chain,$num_accounts
#total_coins=`echo "scale=2;($total+5000)/1000000"| bc`
total_coins=`echo "scale=6;$total/1000000"| bc`
echo total amount,$total_coins

