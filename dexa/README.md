
<p align="center">
  <a href="#about">About</a> •
  <a href="#release-status">Release Status</a> •
  <a href="#contributing">Contributing</a> •
  <a href="#licensing">Licensing</a>
</p>

# About 

The Aries playground environment is setup for developers to perform API call flows during a [DEXA](https://github.com/decentralised-dataexchange/data-exchange-agreements) enabled verified data exchange process using Hyperledger Indy as the distributed ledger registry and Hyperldger Aries agent as the client application.

# Developer Instructions

*Notes* : By default the agents are pointed to indy ledger hosted at https://indy.igrant.io 

## Install aries ecosystem
1. Clone repository
2. Create a docker network `docker network create aries-playground-nw` (If not already created)
3. Run `cd dexa` to change directory to data agreement enabled aries playground
4. Run `docker-compose up` to start the agents.


| Actor                                        | Agent URL                                         |
| -------------------------------------------- | ------------------------------------------------- |
| Credit Reporting Agency (Data Using Service) | http://credit-reporting-agency.swagger.localhost/ |
| ABC Bank (Data Source)                       | http://abc-bank.swagger.localhost/                |
| Finance Marketplace (Data Marketplace)       | http://finance-marketplace.swagger.localhost/     |
| Individual (Data Subject)                    | http://individual.swagger.localhost/              |


Please refer the [user guide executing data exchange flows](https://github.com/decentralised-dataexchange/aries-playground/blob/master/dexa/dexa-user-guide.md) for the above reference system.


## Release Status

Released

## Contributing

Feel free to improve the playground and send us a pull request. If you found any problems, please create an issue in this repo.

## Licensing
Copyright (c) 2021 LCubed AB (iGrant.io), Sweden

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.

You may obtain a copy of the License at https://www.apache.org/licenses/LICENSE-2.0.

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the LICENSE for the specific language governing permissions and limitations under the License.
