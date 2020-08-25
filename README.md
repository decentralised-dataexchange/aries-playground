#### Install [aries](https://github.com/darkchylde/aries-playground) ecosystem
1. Clone repository
2. Create a docker network `docker network create von_von` (If not already created)
3. Run `docker-compose up`, it will serve:
    * agent1.localhost (Agent1 service endpoint)
    * agent1.swagger.localhost (Administration API(s) with swagger UI)
    * agent2.localhost (Agent2 service endpoint)
    * agent2.swagger.localhost (Administration API(s) with swagger UI)
    * agent3.localhost (Agent3 service endpoint)
    * agent3.swagger.localhost (Administration API(s) with swagger UI)
    * agent1.webhook (For capturing webhook events)
    * agent2.webhook (For capturing webhook events)
    * agent3.webhook (For capturing webhook events)

*Notes* : By default the agents are pointed to indy ledger hosted at https://indy.igrant.io, 

You can always change this to your ledger of choice by updating *GENESIS_URL* environment variable in docker-compose.yml file

#### Webhooks

A webhook interceptor is provided to debug the webhook events. It can be accessed by tailing demo.log file.

1. `docker exec -it agent1.webhook tail -f demo.log` - For viewing webhook events for agent1
2. `docker exec -it agent2.webhook tail -f demo.log` - For viewing webhook events for agent2
3. `docker exec -it agent3.webhook tail -f demo.log` - For viewing webhook events for agent3

Please refer the [user guide executing on the credential issue and verification](https://github.com/decentralised-dataexchange/aries-playground/blob/credential-issue-and-verification-ug/credential-issue-and-verification-api-user-guide.md) for the above reference system.

#### Configuring the agent startup

The startup.sh file inside cloud-agent folder contains the `aca-py` startup command. You can modify it according to your development needs.

#### Todo

1. Providing a web interface for webhook event interceptor
