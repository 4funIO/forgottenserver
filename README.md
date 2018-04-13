forgottenserver [![Build Status](https://travis-ci.org/otland/forgottenserver.svg?branch=master)](https://travis-ci.org/otland/forgottenserver) [![Build status](https://ci.appveyor.com/api/projects/status/599x38f3a0luessl?svg=true)](https://ci.appveyor.com/project/kornholi/forgottenserver)
===============

The Forgotten Server is a free and open-source MMORPG server emulator written in C++. It is a fork of the [OpenTibia Server](https://github.com/opentibia/server) project. To connect to the server, you can use [OTClient](https://github.com/edubart/otclient).

### Getting Started

* [Compiling](https://github.com/otland/forgottenserver/wiki/Compiling), alternatively download [AppVeyor builds for Windows](https://ci.appveyor.com/project/kornholi/forgottenserver)
* [Scripting Reference](https://github.com/otland/forgottenserver/wiki/Script-Interface)

### Support

If you need help, please visit the [support forum on OTLand](https://otland.net/forums/support.16/). Our issue tracker is not a support forum, and using it as one will result in your issue being closed. If you were unable to get assistance in the support forum, you should consider [becoming a premium user on OTLand](https://otland.net/account/upgrades) which grants you access to the premium support forum and supports OTLand financially.

### Issues

We use the [issue tracker on GitHub](https://github.com/otland/forgottenserver/issues). Keep in mind that everyone who is watching the repository gets notified by e-mail when there is activity, so be thoughtful and avoid writing comments that aren't meaningful for an issue (e.g. "+1"). If you'd like for an issue to be fixed faster, you should either fix it yourself and submit a pull request, or place a bounty on the issue.

### Run using docker-compose

```
cp config.lua.dist config.lua
sed -i -e 's|mysqlHost = "127.0.0.1"|mysqlHost = "mysql"|' config.lua
sed -i -e 's|mysqlUser = "forgottenserver"|mysqlUser = "root"|' config.lua
sed -i -e 's|mysqlPass = ""|mysqlPass = "root"|' config.lua
docker-compose up -d mysql
sleep 10 && mysql -h 127.0.0.1 -u root -proot forgottenserver < schema.sql
docker-compose up -d
```
