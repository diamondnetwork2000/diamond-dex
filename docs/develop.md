#### go dependencies
set `go module`:
```bash
export GO111MODULE=on
```
make vendored copy of dependencies

```bash
go mod vendor
```

Add missing and remove unused modules
```
 go mod tidy 
```

verify dependencies have expected content
```bash
go mod verify
```
get dependencies
```bash
go get -u
```

### GolangCI-Lint

```bash
go get  github.com/golangci/golangci-lint/cmd/golangci-lint
```


* Block commit interval

Change the value of 'timeout_commit' in config/config.toml.

### FAQs

* I got 'make: statik: No such file or directory' message during make run.
Please run the following command to install statik and make sure GOPATH/bin is in your PATH. 

```
go get -d github.com/rakyll/statik
go install github.com/rakyll/statik
```

* I got 'fatal error: 'rocksdb/c.h' file not found' message during make run

Please install RocksDB before building dex. You may run into issue described here [https://github.com/Homebrew/homebrew-core/issues/8392]

* insufficient fees

It looks like the fee amount in your tx is less than (gas price * gas limit)

* gas price too low


It looks like the calculated gas price (fee / gas limit) in your tx is less than the minimal gas price limit (min_gas_price_limit in the genesis.json).

Note: Update method ConsumeGas in file ${GOPATH}/pkg/mod/github.com/cosmos-sdk/store/types/gas.go
to 'g.consumed = Gas(100000)' because we don't want to calcuate gas dynamically.

### configurations

Update the following paramters in config/genesis.json before starting cetd.

* activation_fee
* create_market_fee
* issue_token_fee
* min_gas_price_limit

* Start cetd with required parameters

```
cetd start --minimum-gas-prices="0.1cet"
```
* Start HTTP server

```
cetcli rest-server --chain-id=coinexdex-test1 --laddr=tcp://0.0.0.0:1317 --node tcp://localhost:26657 --trust-node=true
```

* Block commit interval

Change the value of 'timeout_commit' in config/config.toml.

### FAQs

* I got 'make: statik: No such file or directory' message during make run.
Please run the following command to install statik and make sure GOPATH/bin is in your PATH. 

```
go get -d github.com/rakyll/statik
go install github.com/rakyll/statik
```

* I got 'fatal error: 'rocksdb/c.h' file not found' message during make run

Please install RocksDB before building dex. You may run into issue described here [https://github.com/Homebrew/homebrew-core/issues/8392]

* insufficient fees

It looks like the fee amount in your tx is less than (gas price * gas limit)

* gas price too low

It looks like the calculated gas price (fee / gas limit) in your tx is less than the minimal gas price limit (min_gas_price_limit in the genesis.json).

## Install RocksDB on CentOS 7.x

### Install depends

```
yum install zstd zstd-devel libzstd libzstd-devel snappy snappy-devel gflags \
cmake zlib zlib-devel bzip2 bzip2-devel lz4-devel libasan gcc gcc-c++
```

### Build RocksDB

```
git clone https://github.com/facebook/rocksdb.git
git checkout v5.18.4  (the master branch can not be compiled with gcc 4.8)
cd rocksdb
make shared_lib
cp librocksdb.so* /usr/lib
cp librocksdb.so* /usr/lib64
```

### Build gorocksdb

```
CGO_CFLAGS="-I/path/to/rocksdb/include" \
CGO_LDFLAGS="-L/path/to/rocksdb -lrocksdb -lstdc++ -lm -lz -lbz2 -lsnappy -llz4 -lzstd" \
  go get github.com/tecbot/gorocksdb
```

## Build block

CreateProposalBlock -> state.MakeBlock

## Fees

Fee goes to validator can be queryed through distribution/validators.

For example, if community_tax in genesis.json is 0.02, and fee is 100000, then validator received 100000 * (1 - 0.02) = 98000.

the tax (100000 * 0.02 = 2000) is go to community pool, can be spent by calling /gov/proposals/community_pool_spend


##

reactor.poolRoutine start goroutine and waiting for stop signal

get block from pool
reactor.processBlock -> execution.ApplyBlock -> Commit

peer.newPeer -> peer.createMConnection, when a block is return by peer
call reactor.Receive -> pool.AddBlock add block to poll


replay.ReplayBlocks

app.initMsgQue -> msg_queue.NewProducer
-> producer.init create writer for each brokers:
-> msg_wirter.createMsgWriter
