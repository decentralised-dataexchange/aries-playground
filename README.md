#### Install [aries](https://github.com/darkchylde/aries-playground) ecosystem
1. Clone repository
2. Create a docker network `docker network create von_von` (If not already created)
3. Run `docker-compose up`, it will serve:
    * agent1.localhost
    * agent1.swagger.localhost (OPEN API)
    * agent2.localhost
    * agent2.swagger.localhost (OPEN API)
    * agent1.webhook (For capturing webhook events)
    * agent2.webhook (For capturing webhook events)

*Notes* : By default the agents are pointed to indy ledger hosted at https://indy.igrant.io, 
You can always change this to your ledger of choice by updating *GENESIS_URL* environment variable in docker-compose.yml file

#### Webhooks

A webhook interceptor is provided to debug the webhook events. It can be accessed by tailing demo.log file.

1. `docker exec -it agent1.webhook tail -f demo.log` - For viewing webhook events for agent1
2. `docker exec -it agent2.webhook tail -f demo.log` - For viewing webhook events for agent2
