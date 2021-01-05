*Notes* : By default the agents are pointed to indy ledger hosted at https://indy.igrant.io 
You can always change this to your ledger of choice by updating *GENESIS_URL* environment variable in docker-compose.yml file

#### Install [aries](https://github.com/darkchylde/aries-playground) ecosystem
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

#### Webhooks

A webhook interceptor is provided to debug the webhook events. It can be accessed by tailing demo.log file.

1. `docker exec -it test-center.webhook tail -f demo.log` - For viewing webhook events for agent1
2. `docker exec -it data4life-user.webhook tail -f demo.log` - For viewing webhook events for agent2
3. `docker exec -it travel-company.webhook tail -f demo.log` - For viewing webhook events for agent3

Please refer the [user guide executing on the credential issue and verification](https://github.com/decentralised-dataexchange/aries-playground/blob/master/credential-issue-and-verification-api-user-guide.md) for the above reference system.

#### Configuring the agent startup

The startup.sh file inside cloud-agent folder contains the `aca-py` startup command. You can modify it according to your development needs.

#### Todo

1. Providing a web interface for webhook event interceptor

#### Resources

1. Docker images used in the aries-playground project is publicly available at https://hub.docker.com/u/igrantio
2. Dockerfile for building the docker image for aries-cloudagent-python with operator capabilities is available at https://github.com/decentralised-dataexchange/aries-cloudagent-python/blob/wip/igrantio-operator/docker/Dockerfile.scratch
