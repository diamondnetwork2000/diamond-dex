#!/bin/bash

set -e

if [ ! -f "$GOPATH/bin/cetd" ]; then
    echo "Make sure cetd compiled by (make tools install) and currently can be find in PATH"
    exit 1
fi

if [ -d "${HOME}/.cetd" ]; then
    echo "Please backup and delete ~/.cetd, before run this script. Exiting..."
    exit 1
fi

if [ -d "${HOME}/.cetcli" ]; then
    echo "Please backup and delete ~/.cetcli, before run this script. Exiting..."
    exit 1
fi

cetd init diamonddex --chain-id=diamonddex
cetcli keys add bob <<<$'12345678\n12345678\n'
cetd add-genesis-account $(cetcli keys show bob -a) 100000000000000000dgss
cetd add-genesis-token --name="Diamond Chain Native Token" \
	--symbol="dgss" \
	--owner=$(cetcli keys show bob -a)  \
	--total-supply=1000000000000000000 \
	--mintable=true \
	--burnable=true \
	--addr-forbiddable=false \
	--token-forbiddable=false \
	--total-burn=0 \
	--total-mint=900000000000000000 \
	--is-forbidden=false \
	--url="www.diamondnetwork.org" \
	--description="A public chain built for the decentralized exchange" \
        --identity="552A83BA62F9B1F8"
cetd gentx --amount=50000000000000000dgss --min-self-delegation=50000000000000000 --name bob <<<$'12345678\n12345678\n'
cetd collect-gentxs

echo DONE!
