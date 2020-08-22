#### Install [aries](https://github.com/darkchylde/aries-playground) ecosystem
1. Clone repository
2. Create a docker network `docker network create von_von` (If not already created)
3. Run `docker-compose up`, it will serve:
    * agent1.localhost
    * agent1.swagger.localhost (OPEN API)
    * agent2.localhost
    * agent2.swagger.localhost (OPEN API)

*Notes* : By default the agents are pointed to indy ledger hosted at https://indy.igrant.io, 
You can always change this to your ledger of choice by updating *GENESIS_URL* environment variable in docker-compose.yml file
