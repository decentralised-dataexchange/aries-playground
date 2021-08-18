<p align="center">
    <a href="/../../commits/" title="Last Commit"><img src="https://img.shields.io/github/last-commit/decentralised-dataexchange/automated-data-agreements?style=flat"></a>
    <a href="/../../issues" title="Open Issues"><img src="https://img.shields.io/github/issues/decentralised-dataexchange/automated-data-agreements?style=flat"></a>
    <a href="./LICENSE" title="License"><img src="https://img.shields.io/badge/License-Apache%202.0-green.svg?style=flat"></a>
</p>


<p align="center">
  <a href="#about">About</a> •
  <a href="#release-status">Release Status</a> •
  <a href="#contributing">Contributing</a> •
  <a href="#licensing">Licensing</a>
</p>

# About 

The Aries playground environment is setup for developers to perform API call flows during a verified data exchange process using Hyperledger Indy as the distributed ledger registry and Hyperldger Aries agent as the client application.

For developers to try out the Aries agent, iGrant.io Aries agents are pointed to the indy ledger hosted at https://indy.igrant.io. This can be changed to any ledger of choice by updating GENESIS_URL environment variable in docker-compose.yml file.

More info at: https://docs.igrant.io/ssi/ssi-apg

# Developer Instructions

*Notes* : By default the agents are pointed to indy ledger hosted at https://indy.igrant.io 
You can always change this to your ledger of choice by updating *GENESIS_URL* environment variable in docker-compose.yml file

## Install [aries](https://github.com/darkchylde/aries-playground) ecosystem
1. Clone repository
2. Create a docker network `docker network create aries-playground-nw` (If not already created)
3. Run `docker-compose up`, it will serve:
    * test-center.localhost (Agent1 service endpoint)
    * test-center.swagger.localhost (Administration API(s) with swagger UI)
    * data4life-user.localhost (Agent2 service endpoint)
    * data4life-user.swagger.localhost (Administration API(s) with swagger UI)
    * travel-company.localhost (Agent3 service endpoint)
    * travel-company.swagger.localhost (Administration API(s) with swagger UI)
    * test-center.webhook (For capturing webhook events)
    * data4life-user.webhook (For capturing webhook events)
    * travel-company.webhook (For capturing webhook events)

## Webhooks

A webhook interceptor is provided to debug the webhook events. It can be accessed by tailing demo.log file.

1. `docker exec -it test-center.webhook tail -f demo.log` - For viewing webhook events for agent1
2. `docker exec -it data4life-user.webhook tail -f demo.log` - For viewing webhook events for agent2
3. `docker exec -it travel-company.webhook tail -f demo.log` - For viewing webhook events for agent3

Please refer the [user guide executing on the credential issue and verification](https://github.com/decentralised-dataexchange/aries-playground/blob/master/credential-issue-and-verification-api-user-guide.md) for the above reference system.

## Configuring the agent startup

The startup.sh file inside cloud-agent folder contains the `aca-py` startup command. You can modify it according to your development needs.

## Todo

1. Provide a web interface for webhook event interceptor

## Resources

1. Docker images used in the aries-playground project is publicly available at https://hub.docker.com/u/igrantio
2. Dockerfile for building the docker image for aries-cloudagent-python with operator capabilities is available at https://github.com/decentralised-dataexchange/aries-cloudagent-python/blob/wip/igrantio-operator/docker/Dockerfile.scratch

## Release Status

Released

## Contributing

Feel free to improve the plugin and send us a pull request. If you found any problems, please create an issue in this repo.

## Licensing
Copyright (c) 2021 LCubed AB (iGrant.io), Sweden

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.

You may obtain a copy of the License at https://www.apache.org/licenses/LICENSE-2.0.

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the LICENSE for the specific language governing permissions and limitations under the License.
