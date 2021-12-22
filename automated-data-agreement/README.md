
<p align="center">
  <a href="#about">About</a> •
  <a href="#release-status">Release Status</a> •
  <a href="#contributing">Contributing</a> •
  <a href="#licensing">Licensing</a>
</p>

# About 

The Aries playground environment is setup for developers to perform API call flows during a [data agreement](https://github.com/decentralised-dataexchange/automated-data-agreements) enabled verified data exchange process using Hyperledger Indy as the distributed ledger registry and Hyperldger Aries agent as the client application.

# Developer Instructions

*Notes* : By default the agents are pointed to indy ledger hosted at https://indy.igrant.io 

## Install aries ecosystem
1. Clone repository
2. Create a docker network `docker network create aries-playground-nw` (If not already created)
3. Run `cd automated-data-agreement` to change directory to data agreement enabled aries playground
4. Run `docker-compose up` if your host machine is x86 architecture, if it is arm64 architecture Run `docker-compose -f docker-compose-aarch64.yml up`, it will serve:
    * testcenter.localhost (Agent1 service endpoint)
    * testcenter.swagger.localhost (Administration API(s) with swagger UI)
    * travelcompany.localhost (Agent2 service endpoint)
    * travelcompany.swagger.localhost (Administration API(s) with swagger UI)
    * individual.localhost (Agent3 service endpoint)
    * individual.swagger.localhost (Administration API(s) with swagger UI)
    * didregistry.localhost (Agent4 service endpoint)
    * didregistry.swagger.localhost (Administration API(s) with swagger UI)
    * auditor.localhost (Agent5 service endpoint)
    * auditor.swagger.localhost (Administration API(s) with swagger UI)

Please refer the [user guide executing data agreement enabled credential issue and verification](https://github.com/decentralised-dataexchange/aries-playground/blob/master/automated-data-agreement/credential-issue-and-verification-api-user-guide.md) for the above reference system.


## Release Status

Released

## Contributing

Feel free to improve the playground and send us a pull request. If you found any problems, please create an issue in this repo.

## Licensing
Copyright (c) 2021 LCubed AB (iGrant.io), Sweden

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.

You may obtain a copy of the License at https://www.apache.org/licenses/LICENSE-2.0.

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the LICENSE for the specific language governing permissions and limitations under the License.
