# Diamond DEX
A high performance public blockchain with built-in DEX based on Cosmos SDK

[![Language](https://img.shields.io/badge/Language-Go-blue.svg)](https://golang.org/)
[![License](https://img.shields.io/badge/License-BSD%202--Clause-orange.svg)](https://github.com/coinexchain/dex/blob/master/LICENSE)
[![Build Status](https://api.travis-ci.com/coinexchain/dex.svg?token=SzpkQ9pqByb4D3AFKW7z&branch=master)](https://travis-ci.com/coinexchain/dex) 
[![Coverage Status](https://coveralls.io/repos/github/coinexchain/dex/badge.svg?&t=PngCUj)](https://coveralls.io/github/coinexchain/dex?branch=master&service=github)

A public chain built for the decentralized exchange

* In control of your own private keys; asset security 100% guaranteed
* Blocks generated in seconds and transactions confirmed instantly
* Assets, orders on chain with full data transparency
* Permissionless one-click token issuing
* Highly-performing trading process and extremely low transaction fees
* Multi-platform clients with superb user experience
* Professional blockchain R&D team; completely open source code
* Smart contracts and open public chain ecosystem

### build


Reference [quick start](docs/quickstart.md)

### configurations

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
