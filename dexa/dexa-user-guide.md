# Data Agreement enabled Credential Issue and Verification API User Guide

# 1.0 Introduction

This describes the API call flows during a data exchange agreement enabled verified data exchange process using Hyperledger Indy for anchoring identity schemas, Ethereum for anchoring root hash of data exchange agreements and Hyperledger Aries for agents. 

The indy network is up and running at https://indy.igrant.io/. The aries agents are connected to this network and configured locally as described [here](https://github.com/decentralised-dataexchange/aries-playground/blob/master/dexa/README.md). Executing the sequence of operations described creates the reference system described [below](#Reference-system).

# 2.0 Reference system

In our reference implementation, we have an Individual whose account transaction history is being stored at ABC Bank. The Credit Reporting Agency would like to determine the Credit Score of the Individual, in order to do so they require pulling account transaction history of the Individual from ABC Bank on periodic basis. This verified exchange of data is enabled by data exchange agreement workflow described [here](https://github.com/decentralised-dataexchange/data-exchange-agreements).

A reference image to the data exchange agreement workflow in SSI is given below.


<img src="https://raw.githubusercontent.com/decentralised-dataexchange/data-exchange-agreements/main/docs/images/data-exchange-landscape.svg" alt="Data exchange landscape">


Once the reference system is up and running, in your browser you can start four tabs to execute the APIs using swagger.

| Actor                                        | Agent URL                                         |
| -------------------------------------------- | ------------------------------------------------- |
| Credit Reporting Agency (Data Using Service) | http://credit-reporting-agency.swagger.localhost/ |
| ABC Bank (Data Source)                       | http://abc-bank.swagger.localhost/                |
| Finance Marketplace (Data Marketplace)       | http://finance-marketplace.swagger.localhost/     |
| Individual (Data Subject)                    | http://individual.swagger.localhost/              |

# 3.0 Use case Scenario

Individual is a customer of ABC Bank. A Credit Reporting Agency determines the credit score of the Individual by pulling account transaction history from the ABC Bank on periodic basis. This enables the ABC Bank to determine the credibility of Individual if in-case they apply for a loan.


# 4.0 Pre-requisite workflows

## 4.1 ABC Bank

### 4.1.1 Establish connection between ABC Bank and Finance Marketplace

1. Fetch the invitation from well-known endpoint hosted at Finance Marketplace.

Perform [**HTTP GET** http://finance-marketplace.swagger.localhost/v1/.well-known/did-configuration.json](http://finance-marketplace.swagger.localhost/v1/.well-known/did-configuration.json). Sample response is given below.

```json
{
  "ServiceEndpoint": "http://finance-marketplace.localhost",
  "RoutingKey": "",
  "Invitation": {
    "label": "Finance Marketplace",
    "serviceEndpoint": "http://finance-marketplace.localhost",
    "routingKeys": [],
    "recipientKeys": [
      "6bkr7AyhbdB8eo1tyqwzg2Tjapx13bEvMotbfSzRKQ1X"
    ],
    "@id": "f17ccdd1-001e-4930-9fd9-6e6a8960d0ab",
    "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/connections/1.0/invitation"
  }
}
```

2. ABC Bank receives the connection invitation.

Receive a new connection invitation by copying the invitation from response in step 1 and passing it as request body to [**HTTP POST** http://abc-bank.swagger.localhost/connections/receive-invitation?auto_accept=true](http://abc-bank.swagger.localhost/api/doc#/connection/post_connections_receive_invitation). Sample response is given below.

```json
{
  "request_id": "034c858a-3371-4ed3-bc58-6b3894b737df",
  "initiator": "external",
  "updated_at": "2022-09-24 06:40:44.456483Z",
  "connection_id": "037061d1-45a3-474b-bddf-5da4ba2058cf",
  "state": "request",
  "routing_state": "none",
  "their_label": "Finance Marketplace",
  "my_did": "X5dsgJmdJ12FH6TjYnQg43",
  "invitation_key": "6bkr7AyhbdB8eo1tyqwzg2Tjapx13bEvMotbfSzRKQ1X",
  "accept": "auto",
  "invitation_mode": "once",
  "created_at": "2022-09-24 06:40:44.312192Z"
}
```

3. ABC Bank configures the connection as Data Marketplace


Perform [**HTTP POST** http://abc-bank.swagger.localhost/v1/data-marketplace/connections/{connection_id}](http://abc-bank.swagger.localhost/api/doc#/Data%20Marketplace/post_v1_data_marketplace_connections__connection_id_).

Sample response is given below.

```json
{
  "connection_id": "037061d1-45a3-474b-bddf-5da4ba2058cf",
  "created_at": "2022-09-24 06:43:02.640729Z",
  "updated_at": "2022-09-24 06:43:02.640729Z"
}
```


### 4.1.2 Establish connection between Credit Reporting Agency and Finance Marketplace

1. Fetch the invitation from well-known endpoint hosted at Finance Marketplace.

Perform [**HTTP GET** http://finance-marketplace.swagger.localhost/v1/.well-known/did-configuration.json](http://finance-marketplace.swagger.localhost/v1/.well-known/did-configuration.json). Sample response is given below.

```json
{
  "ServiceEndpoint": "http://finance-marketplace.localhost",
  "RoutingKey": "",
  "Invitation": {
    "label": "Finance Marketplace",
    "serviceEndpoint": "http://finance-marketplace.localhost",
    "routingKeys": [],
    "recipientKeys": [
      "Fc4dk8WGBqGCwPhiMGaF6hs1FWwPimT33NpVFhQNkXNT"
    ],
    "@id": "4ef4478e-4172-4f5e-b8d1-058da574a3a1",
    "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/connections/1.0/invitation"
  }
}
```

2. Credit Reporting Agency receives the connection invitation.

Receive a new connection invitation by copying the invitation from response in step 1 and passing it as request body to [**HTTP POST** http://credit-reporting-agency.swagger.localhost/connections/receive-invitation?auto_accept=true](http://credit-reporting-agency.swagger.localhost/api/doc#/connection/post_connections_receive_invitation). Sample response is given below.

```json
{
  "invitation_mode": "once",
  "initiator": "external",
  "connection_id": "c444cc91-c214-4bd4-be12-51519d0d9bf7",
  "request_id": "1cb6648b-aa41-4422-9daa-9474fff78721",
  "state": "request",
  "routing_state": "none",
  "my_did": "Dk74BQiVKD73PXuu2sbFLe",
  "their_label": "Finance Marketplace",
  "accept": "auto",
  "invitation_key": "Fc4dk8WGBqGCwPhiMGaF6hs1FWwPimT33NpVFhQNkXNT",
  "updated_at": "2022-09-24 06:48:10.219870Z",
  "created_at": "2022-09-24 06:48:10.044428Z"
}
```

3. ABC Bank configures the connection as Data Marketplace


Perform [**HTTP POST** http://credit-reporting-agency.swagger.localhost/v1/data-marketplace/connections/{connection_id}](http://credit-reporting-agency.swagger.localhost/api/doc#/Data%20Marketplace/post_v1_data_marketplace_connections__connection_id_).

Sample response is given below.

```json
{
  "updated_at": "2022-09-24 06:50:53.384029Z",
  "connection_id": "c444cc91-c214-4bd4-be12-51519d0d9bf7",
  "created_at": "2022-09-24 06:50:53.384029Z"
}
```

## 4.2 Individual

### 4.2.1 Establish connection between Individual and ABC Bank


1. Fetch the invitation from well-known endpoint hosted at ABC Bank.

Perform [**HTTP GET** http://abc-bank.swagger.localhost/v1/.well-known/did-configuration.json](http://abc-bank.swagger.localhost/api/doc#/connection/get_v1__well_known_did_configuration_json). Sample response is given below.

```json
{
  "ServiceEndpoint": "http://abc-bank.localhost",
  "RoutingKey": "",
  "Invitation": {
    "label": "ABC Bank",
    "serviceEndpoint": "http://abc-bank.localhost",
    "routingKeys": [],
    "recipientKeys": [
      "DknddGkZz4DwPc1EJ7PWLiBdya3vupShYBxCBbDArAxc"
    ],
    "@id": "2b5b2ce5-7450-4e28-80ed-f2e37eafb783",
    "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/connections/1.0/invitation"
  }
}
```

2. Receive a new connection invitation by Individual.

Receive a new connection invitation by copying the invitation from response in step 1 and passing it as request body to [**HTTP POST** http://individual.swagger.localhost/connections/receive-invitation?auto_accept=true](http://individual.swagger.localhost/api/doc#/connection/post_connections_receive_invitation). Sample response is given below.

```json
{
  "invitation_key": "DknddGkZz4DwPc1EJ7PWLiBdya3vupShYBxCBbDArAxc",
  "state": "request",
  "request_id": "7e6c3e57-451a-4571-9125-cf50221c67f6",
  "routing_state": "none",
  "accept": "auto",
  "invitation_mode": "once",
  "updated_at": "2022-09-24 06:59:22.304327Z",
  "their_label": "ABC Bank",
  "initiator": "external",
  "my_did": "HQ3RJqKPY8RtXn2eZWadU3",
  "created_at": "2022-09-24 06:59:22.104917Z",
  "connection_id": "0d885cf2-f97b-4f46-a0dd-ed985be5857d"
}
```
