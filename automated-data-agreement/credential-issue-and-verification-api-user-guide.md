# Data Agreement enabled Credential Issue and Verification API User Guide
## Table of Contents

- [Data Agreement enabled Credential Issue and Verification API User Guide](#data-agreement-enabled-credential-issue-and-verification-api-user-guide)
  - [Table of Contents](#table-of-contents)
- [1.0 Introduction](#10-introduction)
- [2.0 Reference system](#20-reference-system)
- [3.0 Use case Scenario](#30-use-case-scenario)
- [4.0 Pre-requisite workflows](#40-pre-requisite-workflows)
  - [4.1 Test center](#41-test-center)
    - [4.1.1 Establish connection between Test Center and MyData DID Registry](#411-establish-connection-between-test-center-and-mydata-did-registry)
    - [4.1.2 Create DID in the wallet](#412-create-did-in-the-wallet)
    - [4.1.3 Register DID to the blockchain](#413-register-did-to-the-blockchain)
    - [4.1.4 Register DID to the MyData DID Registry](#414-register-did-to-the-mydata-did-registry)
    - [4.1.5 Establish connection between Test Center and Auditor](#415-establish-connection-between-test-center-and-auditor)
  - [4.2 Individual](#42-individual)
    - [4.2.1 Establish connection between Individual and MyData DID Registry](#421-establish-connection-between-individual-and-mydata-did-registry)
    - [4.2.2 Establish connection between Individual and Auditor](#422-establish-connection-between-individual-and-auditor)
  - [4.3 Travel company](#43-travel-company)
    - [4.3.1 Establish connection between Travel Company and MyData DID Registry](#431-establish-connection-between-travel-company-and-mydata-did-registry)
    - [4.3.2 Create DID in the wallet](#432-create-did-in-the-wallet)
    - [4.3.3 Register DID to the MyData DID Registry](#433-register-did-to-the-mydata-did-registry)
    - [4.3.4 Establish connection between Travel Company and Auditor](#434-establish-connection-between-travel-company-and-auditor)
  - [4.4 MyData DID registry](#44-mydata-did-registry)
  - [4.5 Auditor](#45-auditor)
    - [4.5.1 Establish connection between Auditor and MyData DID Registry](#451-establish-connection-between-auditor-and-mydata-did-registry)
- [5.0 SSI enabled data exchange workflows enhanced with data agreements](#50-ssi-enabled-data-exchange-workflows-enhanced-with-data-agreements)
  - [5.1 Issue credential by the test center to the individual](#51-issue-credential-by-the-test-center-to-the-individual)
    - [5.1.1 Data Agreement definition and preparation workflow](#511-data-agreement-definition-and-preparation-workflow)
    - [5.1.2 Data Agreement capture workflow (includes issue credential by SSI)](#512-data-agreement-capture-workflow-includes-issue-credential-by-ssi)
      - [5.1.2.1 Establish connection between Test Center and the Individual](#5121-establish-connection-between-test-center-and-the-individual)
      - [5.1.2.2 Test Center offers a credential to the individual](#5122-test-center-offers-a-credential-to-the-individual)
      - [5.1.2.3 Individual receives the credential offer](#5123-individual-receives-the-credential-offer)
      - [5.1.2.4 Individual rejects the data agreement](#5124-individual-rejects-the-data-agreement)
      - [5.1.2.5 Individual accepts the data agreement](#5125-individual-accepts-the-data-agreement)
    - [5.1.3 Data Agreement terminate workflow](#513-data-agreement-terminate-workflow)
  - [5.2 Proof presentation by the individual to the travel company](#52-proof-presentation-by-the-individual-to-the-travel-company)
    - [5.2.1 Data Agreement definition and preparation workflow](#521-data-agreement-definition-and-preparation-workflow)
    - [5.2.2 Data Agreement capture workflow (includes present proof by SSI)](#522-data-agreement-capture-workflow-includes-present-proof-by-ssi)
      - [5.2.2.1 Establish connection between Travel Company and the Individual](#5221-establish-connection-between-travel-company-and-the-individual)
      - [5.2.2.2 Travel Company sends proof presentation request to the Individual](#5222-travel-company-sends-proof-presentation-request-to-the-individual)
      - [5.2.2.3 Individual receives the proof presentation request](#5223-individual-receives-the-proof-presentation-request)
      - [5.2.2.4 Individual rejects the data agreement](#5224-individual-rejects-the-data-agreement)
      - [5.2.2.5 Individual accepts the data agreement](#5225-individual-accepts-the-data-agreement)
    - [5.2.3 Data Agreement terminate workflow](#523-data-agreement-terminate-workflow)
  - [5.3 Data Agreement audit workflow](#53-data-agreement-audit-workflow)

# 1.0 Introduction

This describes the API call flows during a data agreement enabled verified data exchange process using hyperledger Indy as the distributed ledger registry and hyperldge aries agent for client application. 

The indy network is up and running at https://indy.igrant.io/. The aries agents are connected to this network and configured locally as described [here](https://github.com/decentralised-dataexchange/aries-playground/blob/master/automated-data-agreement/README.md). Executing the sequence of operations described creates the reference system described [below](#Reference-system).

# 2.0 Reference system

In our reference implementation, we have an individual holding health data i.e. issued by a Test Center in the data wallet app. This health data could be used by the individual to prove health status to a travel company. The legal entity ensures that the test center follows the schema and governance. This verified exchange of data is enabled by data agreement workflow described [here](https://github.com/decentralised-dataexchange/automated-data-agreements/blob/main/docs/functional_specification.md#31automated-data-agreement-workflow-in-ssi).

A reference image to the data agreement workflow in SSI is given below.


<img src="https://github.com/decentralised-dataexchange/automated-data-agreements/raw/main/docs/images/data-agreement-workflow-to-ssi.png" alt="Data Agreement Workflow for SSI">


Once the reference system is up and running, in your browser you can start five tabs to execute the APIs using swagger.

| Agent                       | Swagger API endpoint admin UI                                             |
| --------------------------- | ------------------------------------------------------------------------- |
| Test Center (Issuer)        | [testcenter.swagger.localhost](http://testcenter.swagger.localhost)       |
| Travel Company (Verifier)   | [travelcompany.swagger.localhost](http://travelcompany.swagger.localhost) |
| Individual (Alice) (Holder) | [individual.swagger.localhost](http://individual.swagger.localhost)       |
| MyData DID Registry         | [didregistry.swagger.localhost](http://didregistry.swagger.localhost)     |
| Auditor                     | [auditor.swagger.localhost](http://auditor.swagger.localhost)             |

# 3.0 Use case Scenario

Alice is a travel vloger, Her next destination is dubai but, due to covid pandemic, she has to prove to a travel agent, that her result is negative. So that she will be allowed to travel. 

Above described use case scenario can be realised by performing the workflows in [Section 4.0 Pre-requisite workflows](#40-pre-requisite-workflows) and [Section 5.0 SSI enabled data exchange workflows enhanced with data agreements](#50-ssi-enabled-data-exchange-workflows-enhanced-with-data-agreements) in sequential order.

# 4.0 Pre-requisite workflows

## 4.1 Test center

### 4.1.1 Establish connection between Test Center and MyData DID Registry

1. Fetch the invitation from well-known endpoint hosted at MyData DID Registry.

Perform [**HTTP GET** http://didregistry.swagger.localhost/.well-known/did-configuration.json](http://didregistry.swagger.localhost/.well-known/did-configuration.json). Sample response is given below.

```
{
  "ServiceEndpoint": "http://didregistry.localhost",
  "RoutingKey": "",
  "Invitation": {
    "label": "DID-Registry",
    "serviceEndpoint": "http://didregistry.localhost",
    "routingKeys": [],
    "recipientKeys": [
      "9i4H4CgwTXKESMnbxXoZB36nQPPUXGWeFNDDUEWQhz5i"
    ],
    "@id": "5ae54c60-f223-4ceb-96c2-d2f4de2b62e8",
    "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/connections/1.0/invitation"
  }
}
```

2. Receive a new connection invitation by Test Center.

Receive a new connection invitation by copying the invitation from response in step 1 and passing it as request body to [**HTTP POST** http://testcenter.swagger.localhost/connections/receive-invitation](http://testcenter.swagger.localhost/api/doc#/connection/post_connections_receive_invitation). Sample response is given below.

```
{
  "accept": "manual",
  "connection_id": "600e82f7-dfe5-4f1b-a932-8e7a8f632aa1",
  "their_label": "DID-Registry",
  "initiator": "external",
  "invitation_key": "9i4H4CgwTXKESMnbxXoZB36nQPPUXGWeFNDDUEWQhz5i",
  "state": "invitation",
  "updated_at": "2021-12-22 05:26:21.097530Z",
  "routing_state": "none",
  "invitation_mode": "once",
  "created_at": "2021-12-22 05:26:21.097530Z"
}
```

3. Accept received connection invitation by Test Center.

Perform [**HTTP POST** http://testcenter.swagger.localhost/connections/{conn_id}/accept-invitation](http://testcenter.swagger.localhost/api/doc#/connection/post_connections__conn_id__accept_invitation). Sample response is given below.

```
{
  "accept": "manual",
  "connection_id": "600e82f7-dfe5-4f1b-a932-8e7a8f632aa1",
  "their_label": "DID-Registry",
  "my_did": "K2fJcrNWeBHt1iLVeGtYGA",
  "initiator": "external",
  "invitation_key": "9i4H4CgwTXKESMnbxXoZB36nQPPUXGWeFNDDUEWQhz5i",
  "state": "request",
  "updated_at": "2021-12-22 05:32:51.155489Z",
  "routing_state": "none",
  "invitation_mode": "once",
  "created_at": "2021-12-22 05:26:21.097530Z",
  "request_id": "3d4220b2-f906-4236-b446-42ddf2ee8b1d"
}
```

4. Mark a connection as MyData DID Registry.


Perform [**HTTP POST** http://testcenter.swagger.localhost/mydata-did/set-did-registry-connection/{connection_id}](http://testcenter.swagger.localhost/api/doc#/Data%20Agreement%20-%20MyData%20DID%20Operations/post_mydata_did_set_did_registry_connection__connection_id_).

HTTP 204 No Content response is given on success.


### 4.1.2 Create DID in the wallet

Create a local DID for the agent using [**HTTP POST** http://testcenter.swagger.localhost/wallet/did/create](http://testcenter.swagger.localhost/api/doc#/wallet/post_wallet_did_create) This generates the DID and verification key. Sample response is given below.

```
{
  "result": {
    "did": "8zn9iWuZUc8jsy6BCYK42b",
    "verkey": "5MmxAnbo4ezoTpTaa6YumJ9N5xhjJTYeHtugwphyCU6Q",
    "posture": "wallet_only"
  }
}
```

### 4.1.3 Register DID to the blockchain

After creating local DID, you need to register it with ledger at [https://indy.igrant.io](https://indy.igrant.io) by performing cURL request as given below.

```
curl -X POST https://indy.igrant.io/register\?ca\=true --header "Content-Type: application/json" --data '{"did": "8zn9iWuZUc8jsy6BCYK42b", "verkey":"5MmxAnbo4ezoTpTaa6YumJ9N5xhjJTYeHtugwphyCU6Q", "role": "TRUSTEE"}'
```

Replace the request body (--data parameter in the cURL command) with the DID and verification key generated in the earlier step. 

### 4.1.4 Register DID to the MyData DID Registry

1. DID is converted to MyData DID internally and recorded in the MyData DID Registry by performing [**HTTP POST** http://testcenter.swagger.localhost/mydata-did/didcomm/create-did/{did}](http://testcenter.swagger.localhost/api/doc#/Data%20Agreement%20-%20MyData%20DID%20Operations/post_mydata_did_didcomm_create_did__did_) by passing the blockchain anchored DID in the previous step. Internally the test center constructs a DIDComm message of type `mydata-did/1.0/create-did` and sends it to the MyData DID Registry agent.


Sample response is given below.

```
{
  "thread_id": "4a0ece99-5ed0-470b-975f-2772c28595ff",
  "connection_id": "56e67bb0-a605-4209-afb6-0af56daaf105",
  "message_type": "create-did",
  "updated_at": "2021-12-22 06:21:41.721905Z",
  "created_at": "2021-12-22 06:21:41.721905Z",
  "mydata_did_registry_didcomm_transaction_record_id": "88590004-c52d-4929-b6ff-b4eb28f646d0",
  "messages_list": [
    {
      "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/mydata-did/1.0/create-did",
      "@id": "4a0ece99-5ed0-470b-975f-2772c28595ff",
      "from": "did:mydata:z6MkfAUb25mpwiMNHxdQkoHAEEueemKd5mdJwCxdv5AMPey5",
      "created_time": "1640154101",
      "to": "did:mydata:z6MkgAEmL6V6vVGEbm91TkGwhNypAMqgBmGnAPDdBHb5EdvR",
      "body~sig": {
        "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/signature/1.0/ed25519Sha512_single",
        "signature": "JQzleWPcZboIz9W4MccPkzQWviH893Jzsxz-d_AHjX1LXM4sjzrRH_zZ83mcECB_cvGVSu_szGPbF13Er37AAg==",
        "sig_data": "AAAAAGHCw_V7IkBjb250ZXh0IjogImh0dHBzOi8vdzNpZC5vcmcvZGlkL3YxIiwgImlkIjogImRpZDpteWRhdGE6ejZNa2lwMnptMnJFUUNWR2FLSkhGZldrY1BoTXVYeWFpTG56eXVwY242Zno3Z3NuIiwgInZlcmlmaWNhdGlvbl9tZXRob2QiOiBbeyJpZCI6ICJkaWQ6bXlkYXRhOno2TWtpcDJ6bTJyRVFDVkdhS0pIRmZXa2NQaE11WHlhaUxuenl1cGNuNmZ6N2dzbiMxIiwgInR5cGUiOiAiRWQyNTUxOVZlcmlmaWNhdGlvbktleTIwMTgiLCAiY29udHJvbGxlciI6ICJkaWQ6bXlkYXRhOno2TWtpcDJ6bTJyRVFDVkdhS0pIRmZXa2NQaE11WHlhaUxuenl1cGNuNmZ6N2dzbiIsICJwdWJsaWNLZXlCYXNlNTgiOiAiejZNa2lwMnptMnJFUUNWR2FLSkhGZldrY1BoTXVYeWFpTG56eXVwY242Zno3Z3NuIn1dLCAiYXV0aGVudGljYXRpb24iOiBbeyJ0eXBlIjogIkVkMjU1MTlTaWduYXR1cmVBdXRoZW50aWNhdGlvbjIwMTgiLCAicHVibGljS2V5IjogImRpZDpteWRhdGE6ejZNa2lwMnptMnJFUUNWR2FLSkhGZldrY1BoTXVYeWFpTG56eXVwY242Zno3Z3NuIzEifV0sICJzZXJ2aWNlIjogW3siaWQiOiAiZGlkOm15ZGF0YTp6Nk1raXAyem0yckVRQ1ZHYUtKSEZmV2tjUGhNdVh5YWlMbnp5dXBjbjZmejdnc247ZGlkY29tbSIsICJ0eXBlIjogIkRJRENvbW0iLCAicHJpb3JpdHkiOiAwLCAicmVjaXBpZW50S2V5cyI6IFsiejZNa2lwMnptMnJFUUNWR2FLSkhGZldrY1BoTXVYeWFpTG56eXVwY242Zno3Z3NuIl0sICJzZXJ2aWNlRW5kcG9pbnQiOiAiaHR0cDovL3Rlc3RjZW50ZXIubG9jYWxob3N0In1dfQ==",
        "signer": "5MmxAnbo4ezoTpTaa6YumJ9N5xhjJTYeHtugwphyCU6Q"
      }
    }
  ],
  "trace": false
}
```

2. Copy the `thread_id` from the response of above HTTP API call and query the response of `mydata-did/1.0/create-did` didcomm message by performing [**HTTP GET**  http://testcenter.swagger.localhost/mydata-did/didcomm/transaction-records?thread_id={thread_id}](http://testcenter.swagger.localhost/api/doc#/Data%20Agreement%20-%20MyData%20DID%20Operations/get_mydata_did_didcomm_transaction_records) by passing the `thread_id` as a query parameter. Sample response is given below.

```
{
  "results": [
    {
      "thread_id": "4a0ece99-5ed0-470b-975f-2772c28595ff",
      "connection_id": "56e67bb0-a605-4209-afb6-0af56daaf105",
      "message_type": "create-did",
      "updated_at": "2021-12-22 06:21:41.958405Z",
      "created_at": "2021-12-22 06:21:41.721905Z",
      "mydata_did_registry_didcomm_transaction_record_id": "88590004-c52d-4929-b6ff-b4eb28f646d0",
      "messages_list": [
        {
          "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/mydata-did/1.0/create-did",
          "@id": "4a0ece99-5ed0-470b-975f-2772c28595ff",
          "from": "did:mydata:z6MkfAUb25mpwiMNHxdQkoHAEEueemKd5mdJwCxdv5AMPey5",
          "created_time": "1640154101",
          "to": "did:mydata:z6MkgAEmL6V6vVGEbm91TkGwhNypAMqgBmGnAPDdBHb5EdvR",
          "body~sig": {
            "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/signature/1.0/ed25519Sha512_single",
            "signature": "JQzleWPcZboIz9W4MccPkzQWviH893Jzsxz-d_AHjX1LXM4sjzrRH_zZ83mcECB_cvGVSu_szGPbF13Er37AAg==",
            "sig_data": "AAAAAGHCw_V7IkBjb250ZXh0IjogImh0dHBzOi8vdzNpZC5vcmcvZGlkL3YxIiwgImlkIjogImRpZDpteWRhdGE6ejZNa2lwMnptMnJFUUNWR2FLSkhGZldrY1BoTXVYeWFpTG56eXVwY242Zno3Z3NuIiwgInZlcmlmaWNhdGlvbl9tZXRob2QiOiBbeyJpZCI6ICJkaWQ6bXlkYXRhOno2TWtpcDJ6bTJyRVFDVkdhS0pIRmZXa2NQaE11WHlhaUxuenl1cGNuNmZ6N2dzbiMxIiwgInR5cGUiOiAiRWQyNTUxOVZlcmlmaWNhdGlvbktleTIwMTgiLCAiY29udHJvbGxlciI6ICJkaWQ6bXlkYXRhOno2TWtpcDJ6bTJyRVFDVkdhS0pIRmZXa2NQaE11WHlhaUxuenl1cGNuNmZ6N2dzbiIsICJwdWJsaWNLZXlCYXNlNTgiOiAiejZNa2lwMnptMnJFUUNWR2FLSkhGZldrY1BoTXVYeWFpTG56eXVwY242Zno3Z3NuIn1dLCAiYXV0aGVudGljYXRpb24iOiBbeyJ0eXBlIjogIkVkMjU1MTlTaWduYXR1cmVBdXRoZW50aWNhdGlvbjIwMTgiLCAicHVibGljS2V5IjogImRpZDpteWRhdGE6ejZNa2lwMnptMnJFUUNWR2FLSkhGZldrY1BoTXVYeWFpTG56eXVwY242Zno3Z3NuIzEifV0sICJzZXJ2aWNlIjogW3siaWQiOiAiZGlkOm15ZGF0YTp6Nk1raXAyem0yckVRQ1ZHYUtKSEZmV2tjUGhNdVh5YWlMbnp5dXBjbjZmejdnc247ZGlkY29tbSIsICJ0eXBlIjogIkRJRENvbW0iLCAicHJpb3JpdHkiOiAwLCAicmVjaXBpZW50S2V5cyI6IFsiejZNa2lwMnptMnJFUUNWR2FLSkhGZldrY1BoTXVYeWFpTG56eXVwY242Zno3Z3NuIl0sICJzZXJ2aWNlRW5kcG9pbnQiOiAiaHR0cDovL3Rlc3RjZW50ZXIubG9jYWxob3N0In1dfQ==",
            "signer": "5MmxAnbo4ezoTpTaa6YumJ9N5xhjJTYeHtugwphyCU6Q"
          }
        },
        {
          "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/mydata-did/1.0/create-did-response",
          "@id": "9c6b0e18-d60e-440b-a1fa-f6eef8160a36",
          "~thread": {
            "thid": "4a0ece99-5ed0-470b-975f-2772c28595ff"
          },
          "from": "did:mydata:z6MkgAEmL6V6vVGEbm91TkGwhNypAMqgBmGnAPDdBHb5EdvR",
          "body": {
            "did_doc": {
              "@context": "https://w3id.org/did/v1",
              "id": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn",
              "verification_method": [
                {
                  "id": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn#1",
                  "type": "Ed25519VerificationKey2018",
                  "controller": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn",
                  "publicKeyBase58": "z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn"
                }
              ],
              "authentication": [
                {
                  "type": "Ed25519SignatureAuthentication2018",
                  "publicKey": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn#1"
                }
              ],
              "service": [
                {
                  "id": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn;didcomm",
                  "type": "DIDComm",
                  "priority": 0,
                  "recipientKeys": [
                    "z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn"
                  ],
                  "serviceEndpoint": "http://testcenter.localhost"
                }
              ]
            },
            "version": "1",
            "status": "active"
          },
          "created_time": "1640154101",
          "to": "did:mydata:z6MkfAUb25mpwiMNHxdQkoHAEEueemKd5mdJwCxdv5AMPey5"
        }
      ],
      "trace": false
    }
  ]
}
```

`messages_list` key in the response above contains the list of didcomm messages exchanged between the Test Center and MyData DID Registry. Second entry in the list is the response to the `mydata-did/1.0/create-did` didcomm message sent by the Test Center. Since the message type of the second entry is `mydata-did/1.0/create-did-response`, this would mean the MyData DID Registry has recorded the DID.


### 4.1.5 Establish connection between Test Center and Auditor

1. Fetch the invitation from well-known endpoint hosted at Auditor.

Perform [**HTTP GET** http://auditor.swagger.localhost/.well-known/did-configuration.json](http://auditor.swagger.localhost/.well-known/did-configuration.json). Sample response is given below.

```
{
  "ServiceEndpoint": "http://auditor.localhost",
  "RoutingKey": "",
  "Invitation": {
    "label": "Auditor",
    "serviceEndpoint": "http://auditor.localhost",
    "routingKeys": [],
    "recipientKeys": [
      "GV4iWXZ7we1koKqPU4UyfrYTde22Gf4EuLjjc1ogRGj3"
    ],
    "@id": "0853faca-185e-48e8-b160-bcbafe65db44",
    "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/connections/1.0/invitation"
  }
}
```

2. Receive a new connection invitation by Test Center.

Receive a new connection invitation by copying the invitation from response in step 1 and passing it as request body to [**HTTP POST** http://testcenter.swagger.localhost/connections/receive-invitation](http://testcenter.swagger.localhost/api/doc#/connection/post_connections_receive_invitation). Sample response is given below.

```
{
  "accept": "manual",
  "connection_id": "cb8b35db-8a20-4692-8ccd-ec9117f64e55",
  "their_label": "Auditor",
  "initiator": "external",
  "invitation_key": "GV4iWXZ7we1koKqPU4UyfrYTde22Gf4EuLjjc1ogRGj3",
  "state": "invitation",
  "updated_at": "2021-12-22 06:37:13.961909Z",
  "routing_state": "none",
  "invitation_mode": "once",
  "created_at": "2021-12-22 06:37:13.961909Z"
}
```

3. Accept received connection invitation by Test Center.

Perform [**HTTP POST** http://testcenter.swagger.localhost/connections/{conn_id}/accept-invitation](http://testcenter.swagger.localhost/api/doc#/connection/post_connections__conn_id__accept_invitation). Sample response is given below.

```
{
  "accept": "manual",
  "connection_id": "cb8b35db-8a20-4692-8ccd-ec9117f64e55",
  "their_label": "Auditor",
  "my_did": "VJDHn4u9eKnFvotyWx34RE",
  "initiator": "external",
  "invitation_key": "GV4iWXZ7we1koKqPU4UyfrYTde22Gf4EuLjjc1ogRGj3",
  "state": "request",
  "updated_at": "2021-12-22 06:37:39.125316Z",
  "routing_state": "none",
  "invitation_mode": "once",
  "created_at": "2021-12-22 06:37:13.961909Z",
  "request_id": "a64089a4-5ae5-46d8-bbcc-3d767256397a"
}
```

4. Mark a connection as Auditor.

Perform [**HTTP POST** http://testcenter.swagger.localhost/auditor/set-auditor-connection/{connection_id}](http://testcenter.swagger.localhost/api/doc#/Data%20Agreement%20-%20Auditor%20Functions/post_auditor_set_auditor_connection__connection_id_) by passing the connection id from the above.

HTTP 204 No Content response is given on success.

## 4.2 Individual

### 4.2.1 Establish connection between Individual and MyData DID Registry


1. Fetch the invitation from well-known endpoint hosted at MyData DID Registry.

Perform [**HTTP GET** http://didregistry.swagger.localhost/.well-known/did-configuration.json](http://didregistry.swagger.localhost/.well-known/did-configuration.json). Sample response is given below.

```
{
  "ServiceEndpoint": "http://didregistry.localhost",
  "RoutingKey": "",
  "Invitation": {
    "label": "DID-Registry",
    "serviceEndpoint": "http://didregistry.localhost",
    "routingKeys": [],
    "recipientKeys": [
      "4Z2hG2b8FkVkfhKxaV2Ea6aFZpijCZnmKsvDTihydZ12"
    ],
    "@id": "2656d0ac-876c-43d3-9d70-7918a59e1b7b",
    "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/connections/1.0/invitation"
  }
}
```

2. Receive a new connection invitation by Individual.

Receive a new connection invitation by copying the invitation from response in step 1 and passing it as request body to [**HTTP POST** http://individual.swagger.localhost/connections/receive-invitation](http://individual.swagger.localhost/api/doc#/connection/post_connections_receive_invitation). Sample response is given below.

```
{
  "created_at": "2021-12-22 06:45:33.793535Z",
  "updated_at": "2021-12-22 06:45:33.793535Z",
  "invitation_mode": "once",
  "their_label": "DID-Registry",
  "connection_id": "5dae4b8e-3bd4-47d2-8c87-385155c4304b",
  "accept": "manual",
  "routing_state": "none",
  "invitation_key": "4Z2hG2b8FkVkfhKxaV2Ea6aFZpijCZnmKsvDTihydZ12",
  "initiator": "external",
  "state": "invitation"
}
```

3. Accept received connection invitation by Individual.

Perform [**HTTP POST** http://individual.swagger.localhost/connections/{conn_id}/accept-invitation](http://individual.swagger.localhost/api/doc#/connection/post_connections__conn_id__accept_invitation). Sample response is given below.

```
{
  "created_at": "2021-12-22 06:45:33.793535Z",
  "request_id": "bdacd907-d1bb-4f88-af5e-37a5d72a9e7d",
  "updated_at": "2021-12-22 06:46:29.886233Z",
  "my_did": "CQBLkdoAf74LPCBPehTqDa",
  "invitation_mode": "once",
  "their_label": "DID-Registry",
  "connection_id": "5dae4b8e-3bd4-47d2-8c87-385155c4304b",
  "accept": "manual",
  "routing_state": "none",
  "invitation_key": "4Z2hG2b8FkVkfhKxaV2Ea6aFZpijCZnmKsvDTihydZ12",
  "initiator": "external",
  "state": "request"
}
```

4. Mark a connection as MyData DID Registry.


Perform [**HTTP POST** http://individual.swagger.localhost/mydata-did/set-did-registry-connection/{connection_id}](http://individual.swagger.localhost/api/doc#/Data%20Agreement%20-%20MyData%20DID%20Operations/post_mydata_did_set_did_registry_connection__connection_id_).

HTTP 204 No Content response is given on success.


### 4.2.2 Establish connection between Individual and Auditor

1. Fetch the invitation from well-known endpoint hosted at Auditor.

Perform [**HTTP GET** http://auditor.swagger.localhost/.well-known/did-configuration.json](http://auditor.swagger.localhost/.well-known/did-configuration.json). Sample response is given below.

```
{
  "ServiceEndpoint": "http://auditor.localhost",
  "RoutingKey": "",
  "Invitation": {
    "label": "Auditor",
    "serviceEndpoint": "http://auditor.localhost",
    "routingKeys": [],
    "recipientKeys": [
      "Aa2rD8ayiT3isMbGCKPENSPTderGqKFM3wkcsyZKZk5b"
    ],
    "@id": "59f2232d-b84f-4183-9b86-56960d1649f8",
    "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/connections/1.0/invitation"
  }
}
```

2. Receive a new connection invitation by Individual.

Receive a new connection invitation by copying the invitation from response in step 1 and passing it as request body to [**HTTP POST** http://individual.swagger.localhost/connections/receive-invitation](http://individual.swagger.localhost/api/doc#/connection/post_connections_receive_invitation). Sample response is given below.

```
{
  "created_at": "2021-12-22 06:49:04.304948Z",
  "updated_at": "2021-12-22 06:49:04.304948Z",
  "invitation_mode": "once",
  "their_label": "Auditor",
  "connection_id": "78a360d9-5831-4824-9ea3-6f0583c78d97",
  "accept": "manual",
  "routing_state": "none",
  "invitation_key": "Aa2rD8ayiT3isMbGCKPENSPTderGqKFM3wkcsyZKZk5b",
  "initiator": "external",
  "state": "invitation"
}
```

1. Accept received connection invitation by Individual.

Perform [**HTTP POST** http://individual.swagger.localhost/connections/{conn_id}/accept-invitation](http://individual.swagger.localhost/api/doc#/connection/post_connections__conn_id__accept_invitation). Sample response is given below.

```
{
  "created_at": "2021-12-22 06:49:04.304948Z",
  "request_id": "e1b6acf5-d088-4b95-959c-ee286f4e95c7",
  "updated_at": "2021-12-22 06:49:45.035435Z",
  "my_did": "EA6JJjDu1cR5unia4vzTfJ",
  "invitation_mode": "once",
  "their_label": "Auditor",
  "connection_id": "78a360d9-5831-4824-9ea3-6f0583c78d97",
  "accept": "manual",
  "routing_state": "none",
  "invitation_key": "Aa2rD8ayiT3isMbGCKPENSPTderGqKFM3wkcsyZKZk5b",
  "initiator": "external",
  "state": "request"
}
```

4. Mark a connection as Auditor.

Perform [**HTTP POST** http://individual.swagger.localhost/auditor/set-auditor-connection/{connection_id}](http://individual.swagger.localhost/api/doc#/Data%20Agreement%20-%20Auditor%20Functions/post_auditor_set_auditor_connection__connection_id_) by passing the connection id from the above.

HTTP 204 No Content response is given on success.

## 4.3 Travel company

### 4.3.1 Establish connection between Travel Company and MyData DID Registry


1. Fetch the invitation from well-known endpoint hosted at MyData DID Registry.

Perform [**HTTP GET** http://didregistry.swagger.localhost/.well-known/did-configuration.json](http://didregistry.swagger.localhost/.well-known/did-configuration.json). Sample response is given below.

```
{
  "ServiceEndpoint": "http://didregistry.localhost",
  "RoutingKey": "",
  "Invitation": {
    "label": "DID-Registry",
    "serviceEndpoint": "http://didregistry.localhost",
    "routingKeys": [],
    "recipientKeys": [
      "2xEEGG2x6f3E3RbiWdqgmdc8YAWot5EMPMobLEeCesbm"
    ],
    "@id": "a1707ec4-2c1c-4377-a617-c31261c5d947",
    "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/connections/1.0/invitation"
  }
}
```

2. Receive a new connection invitation by Travel Company.

Receive a new connection invitation by copying the invitation from response in step 1 and passing it as request body to [**HTTP POST** http://travelcompany.swagger.localhost/connections/receive-invitation](http://travelcompany.swagger.localhost/api/doc#/connection/post_connections_receive_invitation). Sample response is given below.

```
{
  "state": "invitation",
  "connection_id": "28f85f41-e770-444f-8c7c-8032065f0d04",
  "their_label": "DID-Registry",
  "invitation_mode": "once",
  "routing_state": "none",
  "updated_at": "2021-12-22 06:52:56.523255Z",
  "initiator": "external",
  "invitation_key": "2xEEGG2x6f3E3RbiWdqgmdc8YAWot5EMPMobLEeCesbm",
  "accept": "manual",
  "created_at": "2021-12-22 06:52:56.523255Z"
}
```

3. Accept received connection invitation by Travel Company.

Perform [**HTTP POST** http://travelcompany.swagger.localhost/connections/{conn_id}/accept-invitation](http://travelcompany.swagger.localhost/api/doc#/connection/post_connections__conn_id__accept_invitation). Sample response is given below.

```
{
  "request_id": "9b6781c3-08b9-412e-8833-17ef49eebd67",
  "state": "request",
  "connection_id": "28f85f41-e770-444f-8c7c-8032065f0d04",
  "their_label": "DID-Registry",
  "invitation_mode": "once",
  "my_did": "KaHUsZuNmPWbrmQVD6HjJi",
  "routing_state": "none",
  "updated_at": "2021-12-22 06:53:45.278216Z",
  "initiator": "external",
  "invitation_key": "2xEEGG2x6f3E3RbiWdqgmdc8YAWot5EMPMobLEeCesbm",
  "accept": "manual",
  "created_at": "2021-12-22 06:52:56.523255Z"
}
```

4. Mark a connection as MyData DID Registry.


Perform [**HTTP POST** http://travelcompany.swagger.localhost/mydata-did/set-did-registry-connection/{connection_id}](http://travelcompany.swagger.localhost/api/doc#/Data%20Agreement%20-%20MyData%20DID%20Operations/post_mydata_did_set_did_registry_connection__connection_id_).

HTTP 204 No Content response is given on success.



### 4.3.2 Create DID in the wallet


Create a local DID for the agent using [**HTTP POST** http://travelcompany.swagger.localhost/wallet/did/create](http://travelcompany.swagger.localhost/api/doc#/wallet/post_wallet_did_create) This generates the DID and verification key. Sample response is given below.

```
{
  "result": {
    "did": "JWXysDYbHP4TugFhDBF8EQ",
    "verkey": "AYW37HsMEtZuruRs8dySuJ5MvcSEMBNXefgKmwDrxZcH",
    "posture": "wallet_only"
  }
}
```



### 4.3.3 Register DID to the MyData DID Registry


1. DID is converted to MyData DID internally and recorded in the MyData DID Registry by performing [**HTTP POST** http://travelcompany.swagger.localhost/mydata-did/didcomm/create-did/{did}](http://travelcompany.swagger.localhost/api/doc#/Data%20Agreement%20-%20MyData%20DID%20Operations/post_mydata_did_didcomm_create_did__did_) by passing the generated DID in the previous step. Internally the travel company constructs a DIDComm message of type `mydata-did/1.0/create-did` and sends it to the MyData DID Registry agent.


Sample response is given below.

```
{
  "thread_id": "fb7f0551-4495-42be-bade-2ca9441078b8",
  "connection_id": "28f85f41-e770-444f-8c7c-8032065f0d04",
  "messages_list": [
    {
      "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/mydata-did/1.0/create-did",
      "@id": "fb7f0551-4495-42be-bade-2ca9441078b8",
      "to": "did:mydata:z6MkqYpea4TrDD5d2xMx4P48d7eLFet2puGtxFVKxB5zWoKJ",
      "from": "did:mydata:z6MkpaR7yi4pMbzCF89LtVCTJiq4XkJcDP2AXj9CigMo1itH",
      "created_time": "1640156273",
      "body~sig": {
        "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/signature/1.0/ed25519Sha512_single",
        "signature": "P46NUWivtPxBDNobMaejsIU2IqsjZWUPnmYWlytMliyt7GawKDovW_cuYzppO_leYWyhp6ngSV-dvi3SSlmiAg==",
        "sig_data": "AAAAAGHCzHF7IkBjb250ZXh0IjogImh0dHBzOi8vdzNpZC5vcmcvZGlkL3YxIiwgImlkIjogImRpZDpteWRhdGE6ejZNa296bTVoWTduYVM0TnlRR1pwQ3dIa1BkTWtCaTVtNGN0TGdiRmNEQnNzblBmIiwgInZlcmlmaWNhdGlvbl9tZXRob2QiOiBbeyJpZCI6ICJkaWQ6bXlkYXRhOno2TWtvem01aFk3bmFTNE55UUdacEN3SGtQZE1rQmk1bTRjdExnYkZjREJzc25QZiMxIiwgInR5cGUiOiAiRWQyNTUxOVZlcmlmaWNhdGlvbktleTIwMTgiLCAiY29udHJvbGxlciI6ICJkaWQ6bXlkYXRhOno2TWtvem01aFk3bmFTNE55UUdacEN3SGtQZE1rQmk1bTRjdExnYkZjREJzc25QZiIsICJwdWJsaWNLZXlCYXNlNTgiOiAiejZNa296bTVoWTduYVM0TnlRR1pwQ3dIa1BkTWtCaTVtNGN0TGdiRmNEQnNzblBmIn1dLCAiYXV0aGVudGljYXRpb24iOiBbeyJ0eXBlIjogIkVkMjU1MTlTaWduYXR1cmVBdXRoZW50aWNhdGlvbjIwMTgiLCAicHVibGljS2V5IjogImRpZDpteWRhdGE6ejZNa296bTVoWTduYVM0TnlRR1pwQ3dIa1BkTWtCaTVtNGN0TGdiRmNEQnNzblBmIzEifV0sICJzZXJ2aWNlIjogW3siaWQiOiAiZGlkOm15ZGF0YTp6Nk1rb3ptNWhZN25hUzROeVFHWnBDd0hrUGRNa0JpNW00Y3RMZ2JGY0RCc3NuUGY7ZGlkY29tbSIsICJ0eXBlIjogIkRJRENvbW0iLCAicHJpb3JpdHkiOiAwLCAicmVjaXBpZW50S2V5cyI6IFsiejZNa296bTVoWTduYVM0TnlRR1pwQ3dIa1BkTWtCaTVtNGN0TGdiRmNEQnNzblBmIl0sICJzZXJ2aWNlRW5kcG9pbnQiOiAiaHR0cDovL3RyYXZlbGNvbXBhbnkubG9jYWxob3N0In1dfQ==",
        "signer": "AYW37HsMEtZuruRs8dySuJ5MvcSEMBNXefgKmwDrxZcH"
      }
    }
  ],
  "mydata_did_registry_didcomm_transaction_record_id": "c3ecb7fb-eb3d-49cf-b47c-d8d0e769f6ce",
  "message_type": "create-did",
  "updated_at": "2021-12-22 06:57:53.978410Z",
  "trace": false,
  "created_at": "2021-12-22 06:57:53.978410Z"
}
Response headers

```

2. Copy the `thread_id` from the response of above HTTP API call and query the response of `mydata-did/1.0/create-did` didcomm message by performing [**HTTP GET**  http://travelcompany.swagger.localhost/mydata-did/didcomm/transaction-records?thread_id={thread_id}](http://travelcompany.swagger.localhost/api/doc#/Data%20Agreement%20-%20MyData%20DID%20Operations/get_mydata_did_didcomm_transaction_records) by passing the `thread_id` as a query parameter. Sample response is given below.

```
{
  "results": [
    {
      "thread_id": "fb7f0551-4495-42be-bade-2ca9441078b8",
      "connection_id": "28f85f41-e770-444f-8c7c-8032065f0d04",
      "messages_list": [
        {
          "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/mydata-did/1.0/create-did",
          "@id": "fb7f0551-4495-42be-bade-2ca9441078b8",
          "to": "did:mydata:z6MkqYpea4TrDD5d2xMx4P48d7eLFet2puGtxFVKxB5zWoKJ",
          "from": "did:mydata:z6MkpaR7yi4pMbzCF89LtVCTJiq4XkJcDP2AXj9CigMo1itH",
          "created_time": "1640156273",
          "body~sig": {
            "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/signature/1.0/ed25519Sha512_single",
            "signature": "P46NUWivtPxBDNobMaejsIU2IqsjZWUPnmYWlytMliyt7GawKDovW_cuYzppO_leYWyhp6ngSV-dvi3SSlmiAg==",
            "sig_data": "AAAAAGHCzHF7IkBjb250ZXh0IjogImh0dHBzOi8vdzNpZC5vcmcvZGlkL3YxIiwgImlkIjogImRpZDpteWRhdGE6ejZNa296bTVoWTduYVM0TnlRR1pwQ3dIa1BkTWtCaTVtNGN0TGdiRmNEQnNzblBmIiwgInZlcmlmaWNhdGlvbl9tZXRob2QiOiBbeyJpZCI6ICJkaWQ6bXlkYXRhOno2TWtvem01aFk3bmFTNE55UUdacEN3SGtQZE1rQmk1bTRjdExnYkZjREJzc25QZiMxIiwgInR5cGUiOiAiRWQyNTUxOVZlcmlmaWNhdGlvbktleTIwMTgiLCAiY29udHJvbGxlciI6ICJkaWQ6bXlkYXRhOno2TWtvem01aFk3bmFTNE55UUdacEN3SGtQZE1rQmk1bTRjdExnYkZjREJzc25QZiIsICJwdWJsaWNLZXlCYXNlNTgiOiAiejZNa296bTVoWTduYVM0TnlRR1pwQ3dIa1BkTWtCaTVtNGN0TGdiRmNEQnNzblBmIn1dLCAiYXV0aGVudGljYXRpb24iOiBbeyJ0eXBlIjogIkVkMjU1MTlTaWduYXR1cmVBdXRoZW50aWNhdGlvbjIwMTgiLCAicHVibGljS2V5IjogImRpZDpteWRhdGE6ejZNa296bTVoWTduYVM0TnlRR1pwQ3dIa1BkTWtCaTVtNGN0TGdiRmNEQnNzblBmIzEifV0sICJzZXJ2aWNlIjogW3siaWQiOiAiZGlkOm15ZGF0YTp6Nk1rb3ptNWhZN25hUzROeVFHWnBDd0hrUGRNa0JpNW00Y3RMZ2JGY0RCc3NuUGY7ZGlkY29tbSIsICJ0eXBlIjogIkRJRENvbW0iLCAicHJpb3JpdHkiOiAwLCAicmVjaXBpZW50S2V5cyI6IFsiejZNa296bTVoWTduYVM0TnlRR1pwQ3dIa1BkTWtCaTVtNGN0TGdiRmNEQnNzblBmIl0sICJzZXJ2aWNlRW5kcG9pbnQiOiAiaHR0cDovL3RyYXZlbGNvbXBhbnkubG9jYWxob3N0In1dfQ==",
            "signer": "AYW37HsMEtZuruRs8dySuJ5MvcSEMBNXefgKmwDrxZcH"
          }
        },
        {
          "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/mydata-did/1.0/create-did-response",
          "@id": "4ad78ac6-dd3e-40ea-9c08-5b03dca04cee",
          "~thread": {
            "thid": "fb7f0551-4495-42be-bade-2ca9441078b8"
          },
          "to": "did:mydata:z6MkpaR7yi4pMbzCF89LtVCTJiq4XkJcDP2AXj9CigMo1itH",
          "from": "did:mydata:z6MkqYpea4TrDD5d2xMx4P48d7eLFet2puGtxFVKxB5zWoKJ",
          "body": {
            "did_doc": {
              "@context": "https://w3id.org/did/v1",
              "id": "did:mydata:z6Mkozm5hY7naS4NyQGZpCwHkPdMkBi5m4ctLgbFcDBssnPf",
              "verification_method": [
                {
                  "id": "did:mydata:z6Mkozm5hY7naS4NyQGZpCwHkPdMkBi5m4ctLgbFcDBssnPf#1",
                  "type": "Ed25519VerificationKey2018",
                  "controller": "did:mydata:z6Mkozm5hY7naS4NyQGZpCwHkPdMkBi5m4ctLgbFcDBssnPf",
                  "publicKeyBase58": "z6Mkozm5hY7naS4NyQGZpCwHkPdMkBi5m4ctLgbFcDBssnPf"
                }
              ],
              "authentication": [
                {
                  "type": "Ed25519SignatureAuthentication2018",
                  "publicKey": "did:mydata:z6Mkozm5hY7naS4NyQGZpCwHkPdMkBi5m4ctLgbFcDBssnPf#1"
                }
              ],
              "service": [
                {
                  "id": "did:mydata:z6Mkozm5hY7naS4NyQGZpCwHkPdMkBi5m4ctLgbFcDBssnPf;didcomm",
                  "type": "DIDComm",
                  "priority": 0,
                  "recipientKeys": [
                    "z6Mkozm5hY7naS4NyQGZpCwHkPdMkBi5m4ctLgbFcDBssnPf"
                  ],
                  "serviceEndpoint": "http://travelcompany.localhost"
                }
              ]
            },
            "version": "1",
            "status": "active"
          },
          "created_time": "1640156274"
        }
      ],
      "mydata_did_registry_didcomm_transaction_record_id": "c3ecb7fb-eb3d-49cf-b47c-d8d0e769f6ce",
      "message_type": "create-did",
      "updated_at": "2021-12-22 06:57:54.201990Z",
      "trace": false,
      "created_at": "2021-12-22 06:57:53.978410Z"
    }
  ]
}
```

`messages_list` key in the response above contains the list of didcomm messages exchanged between the Travel Company and MyData DID Registry. Second entry in the list is the response to the `mydata-did/1.0/create-did` didcomm message sent by the Travel Company. Since the message type of the second entry is `mydata-did/1.0/create-did-response`, this would mean the MyData DID Registry has recorded the DID.


### 4.3.4 Establish connection between Travel Company and Auditor


1. Fetch the invitation from well-known endpoint hosted at Auditor.

Perform [**HTTP GET** http://auditor.swagger.localhost/.well-known/did-configuration.json](http://auditor.swagger.localhost/.well-known/did-configuration.json). Sample response is given below.

```
{
  "ServiceEndpoint": "http://auditor.localhost",
  "RoutingKey": "",
  "Invitation": {
    "label": "Auditor",
    "serviceEndpoint": "http://auditor.localhost",
    "routingKeys": [],
    "recipientKeys": [
      "275stuPq8zUXbjov5ZkTwz6ESqu2wcePZLA5XNQRpHqT"
    ],
    "@id": "10568454-6764-4d4c-896a-bc238aff3e1d",
    "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/connections/1.0/invitation"
  }
}
```

2. Receive a new connection invitation by Travel Company.

Receive a new connection invitation by copying the invitation from response in step 1 and passing it as request body to [**HTTP POST** http://travelcompany.swagger.localhost/connections/receive-invitation](http://travelcompany.swagger.localhost/api/doc#/connection/post_connections_receive_invitation). Sample response is given below.

```
{
  "state": "invitation",
  "connection_id": "290490b8-299e-48b6-8047-cded570f6359",
  "their_label": "Auditor",
  "invitation_mode": "once",
  "routing_state": "none",
  "updated_at": "2021-12-22 07:02:37.429952Z",
  "initiator": "external",
  "invitation_key": "275stuPq8zUXbjov5ZkTwz6ESqu2wcePZLA5XNQRpHqT",
  "accept": "manual",
  "created_at": "2021-12-22 07:02:37.429952Z"
}
```

3. Accept received connection invitation by Travel Company.

Perform [**HTTP POST** http://travelcompany.swagger.localhost/connections/{conn_id}/accept-invitation](http://travelcompany.swagger.localhost/api/doc#/connection/post_connections__conn_id__accept_invitation). Sample response is given below.

```
{
  "request_id": "d915d87f-1f21-4938-9446-623b8e8f3b0e",
  "state": "request",
  "connection_id": "290490b8-299e-48b6-8047-cded570f6359",
  "their_label": "Auditor",
  "invitation_mode": "once",
  "my_did": "NFBxmTayDja16jpJBw8TyJ",
  "routing_state": "none",
  "updated_at": "2021-12-22 07:03:33.664660Z",
  "initiator": "external",
  "invitation_key": "275stuPq8zUXbjov5ZkTwz6ESqu2wcePZLA5XNQRpHqT",
  "accept": "manual",
  "created_at": "2021-12-22 07:02:37.429952Z"
}
```

4. Mark a connection as Auditor.

Perform [**HTTP POST** http://travelcompany.swagger.localhost/auditor/set-auditor-connection/{connection_id}](http://travelcompany.swagger.localhost/api/doc#/Data%20Agreement%20-%20Auditor%20Functions/post_auditor_set_auditor_connection__connection_id_) by passing the connection id from the above.

HTTP 204 No Content response is given on success.



## 4.4 MyData DID registry

No pre-requisite workflows are required to be performed.


## 4.5 Auditor

### 4.5.1 Establish connection between Auditor and MyData DID Registry


1. Fetch the invitation from well-known endpoint hosted at MyData DID Registry.

Perform [**HTTP GET** http://didregistry.swagger.localhost/.well-known/did-configuration.json](http://didregistry.swagger.localhost/.well-known/did-configuration.json). Sample response is given below.

```
{
  "ServiceEndpoint": "http://didregistry.localhost",
  "RoutingKey": "",
  "Invitation": {
    "label": "DID-Registry",
    "serviceEndpoint": "http://didregistry.localhost",
    "routingKeys": [],
    "recipientKeys": [
      "4EJY4hKtbWE1ENvp82kV7PfR6ehsQn96oAiRkNeDW3i5"
    ],
    "@id": "fabdc0dd-7903-48d5-89cd-41d91be002a2",
    "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/connections/1.0/invitation"
  }
}
```

2. Receive a new connection invitation by Auditor.

Receive a new connection invitation by copying the invitation from response in step 1 and passing it as request body to [**HTTP POST** http://auditor.swagger.localhost/connections/receive-invitation](http://auditor.swagger.localhost/api/doc#/connection/post_connections_receive_invitation). Sample response is given below.

```
{
  "their_label": "DID-Registry",
  "invitation_mode": "once",
  "routing_state": "none",
  "updated_at": "2021-12-22 07:06:51.161847Z",
  "connection_id": "7ce97df8-140e-4ce8-9c0e-b06e54c868bd",
  "created_at": "2021-12-22 07:06:51.161847Z",
  "accept": "manual",
  "state": "invitation",
  "invitation_key": "4EJY4hKtbWE1ENvp82kV7PfR6ehsQn96oAiRkNeDW3i5",
  "initiator": "external"
}
```

3. Accept received connection invitation by Auditor.

Perform [**HTTP POST** http://auditor.swagger.localhost/connections/{conn_id}/accept-invitation](http://auditor.swagger.localhost/api/doc#/connection/post_connections__conn_id__accept_invitation). Sample response is given below.

```
{
  "their_label": "DID-Registry",
  "invitation_mode": "once",
  "routing_state": "none",
  "updated_at": "2021-12-22 07:07:34.657265Z",
  "connection_id": "7ce97df8-140e-4ce8-9c0e-b06e54c868bd",
  "request_id": "ed80f9eb-47fb-4382-8a74-e5a4418d5d95",
  "created_at": "2021-12-22 07:06:51.161847Z",
  "my_did": "CwPdUW9u3ukN9sunKYZXVw",
  "accept": "manual",
  "state": "request",
  "invitation_key": "4EJY4hKtbWE1ENvp82kV7PfR6ehsQn96oAiRkNeDW3i5",
  "initiator": "external"
}
```

4. Mark a connection as MyData DID Registry.


Perform [**HTTP POST** http://auditor.swagger.localhost/mydata-did/set-did-registry-connection/{connection_id}](http://auditor.swagger.localhost/api/doc#/Data%20Agreement%20-%20MyData%20DID%20Operations/post_mydata_did_set_did_registry_connection__connection_id_).

HTTP 204 No Content response is given on success.

# 5.0 SSI enabled data exchange workflows enhanced with data agreements

## 5.1 Issue credential by the test center to the individual

### 5.1.1 Data Agreement definition and preparation workflow

1. Choose a data agreement defintion.

JSON-LD context document for version 1.0 data agreement is available at https://github.com/decentralised-dataexchange/automated-data-agreements/blob/main/interface-specs/data-agreement-schema/v1/data-agreement-schema-context.jsonld

2. Create personal data (attributes) for the data agreement preparation.

As mentioned in the use case scenario, Test Center issues Covid-19 test results to the individual. Covid-19 Test Result contains 3 personal data (attributes). They are:

   - Test Result
   - Beneficiary Name
   - Certificate Issuer


Perform [**HTTP POST** http://testcenter.swaggger.localhost/data-agreements/personal-data](http://testcenter.swagger.localhost/api/doc#/Data%20Agreement%20-%20Core%20Functions/post_data_agreements_personal_data) to create the personal data.

Sample request body for creating Test Result personal data is given below:

```json
{
  "attribute_category": "Health Certificate",
  "attribute_description": "Result of the Covid-19 Test conducted by the Test Center",
  "attribute_name": "Test Result",
  "attribute_sensitive": true
}
```

Sample response is given below:

```json
{
  "attribute_name": "Test Result",
  "attribute_description": "Result of the Covid-19 Test conducted by the Test Center",
  "attribute_category": "Health Certificate",
  "updated_at": "2021-12-22 07:30:34.636771Z",
  "attribute_sensitive": "True",
  "created_at": "2021-12-22 07:30:34.636771Z",
  "data_agreement_personal_data_record_id": "437b0b94-78ba-475c-a20b-26b44de095ab",
  "trace": false
}
```

Sample request body for creating Beneficiary Name personal data is given below:

```json
{
  "attribute_category": "Health Certificate",
  "attribute_description": "Full name of the individual",
  "attribute_name": "Beneficiary Name",
  "attribute_sensitive": true
}
```

Sample response is given below:

```json
{
  "attribute_name": "Beneficiary Name",
  "attribute_description": "Full name of the individual",
  "attribute_category": "Health Certificate",
  "updated_at": "2021-12-22 07:31:04.591542Z",
  "attribute_sensitive": "True",
  "created_at": "2021-12-22 07:31:04.591542Z",
  "data_agreement_personal_data_record_id": "0f391930-c933-48aa-9af4-5388b98b4fa5",
  "trace": false
}
```

Sample request body for creating Certificate Issuer personal data is given below:

```json
{
  "attribute_category": "Health Certificate",
  "attribute_description": "The issuer of the certificate, e.g. Swedish e-Health Agency",
  "attribute_name": "Certificate Issuer",
  "attribute_sensitive": true
}
```

Sample response is given below:

```json
{
  "attribute_name": "Certificate Issuer",
  "attribute_description": "The issuer of the certificate, e.g. Swedish e-Health Agency",
  "attribute_category": "Health Certificate",
  "updated_at": "2021-12-22 07:32:08.284992Z",
  "attribute_sensitive": "True",
  "created_at": "2021-12-22 07:32:08.284992Z",
  "data_agreement_personal_data_record_id": "1b978aa6-d633-4029-b626-4ea38e760dd4",
  "trace": false
}
```


3. Prepare and record the data agreement.

Prepare the data agreement in accordance with the data agreement definition. A sample data agreement for the issuance of Covid19 Test Results is given below.

```json
{
  "@context": "https://raw.githubusercontent.com/decentralised-dataexchange/automated-data-agreements/main/interface-specs/data-agreement-schema/v1/data-agreement-schema-context.jsonld",
  "data_controller_name": "Test Center AB",
  "data_controller_url": "https://www.testcenter.se",
  "data_policy": {
    "data_retention_period": 365,
    "geographic_restriction": "Europe",
    "industry_sector": "Healthcare",
    "jurisdiction": "Sweden",
    "policy_URL": "https://testcenter.se/privacy-policy/",
    "storage_location": "Europe"
  },
  "lawful_basis": "consent",
  "method_of_use": "data-source",
  "personal_data": [
    {
      "attribute_id": "437b0b94-78ba-475c-a20b-26b44de095ab"
    },
    {
      "attribute_id": "0f391930-c933-48aa-9af4-5388b98b4fa5"
    },
    {
      "attribute_id": "1b978aa6-d633-4029-b626-4ea38e760dd4"
    }
  ],
  "purpose": "Covid-19 Test Results",
  "purpose_description": "Release of Covid-19 Test Results to individual."
}
```

**Note**: `personal_data` key in the above data agreement contains the list of personal data (attributes) that are to be issued to the individual. The list contains personal data identifiers (`data_agreement_personal_data_record_id`) obtained from the previous step.

Perform [**HTTP POST** http://testcenter.swagger.localhost/data-agreements](http://testcenter.swagger.localhost/api/doc#/Data%20Agreement%20-%20Core%20Functions/post_data_agreements) with the above prepared data agreement as request payload to record the data agreement.

Sample response is given below.

```json
{
  "data_agreement": {
    "@context": "https://raw.githubusercontent.com/decentralised-dataexchange/automated-data-agreements/main/interface-specs/data-agreement-schema/v1/data-agreement-schema-context.jsonld",
    "template_id": "b329ff24-076c-4ac4-ba36-723b422f1dfc",
    "template_version": 1,
    "data_controller_name": "Test Center AB",
    "data_controller_url": "https://www.testcenter.se",
    "purpose": "Covid19 Test Results",
    "purpose_description": "Release of Covid19 Test Results to individual.",
    "lawful_basis": "consent",
    "method_of_use": "data-source",
    "data_policy": {
      "data_retention_period": 365,
      "policy_URL": "https://testcenter.se/privacy-policy/",
      "jurisdiction": "Sweden",
      "industry_sector": "Healthcare",
      "geographic_restriction": "Europe",
      "storage_location": "Europe"
    },
    "personal_data": [
      {
        "attribute_id": "437b0b94-78ba-475c-a20b-26b44de095ab",
        "attribute_name": "Test Result",
        "attribute_sensitive": true,
        "attribute_category": "Health Certificate",
        "attribute_description": "Result of the Covid-19 Test conducted by the Test Center"
      },
      {
        "attribute_id": "0f391930-c933-48aa-9af4-5388b98b4fa5",
        "attribute_name": "Beneficiary Name",
        "attribute_sensitive": true,
        "attribute_category": "Health Certificate",
        "attribute_description": "Full name of the individual"
      },
      {
        "attribute_id": "1b978aa6-d633-4029-b626-4ea38e760dd4",
        "attribute_name": "Certificate Issuer",
        "attribute_sensitive": true,
        "attribute_category": "Health Certificate",
        "attribute_description": "The issuer of the certificate, e.g. Swedish e-Health Agency"
      }
    ]
  },
  "published_flag": "True",
  "data_agreement_record_id": "08318a82-0342-4c81-bd6e-b2eb8cae4c8c",
  "cred_def_id": "8zn9iWuZUc8jsy6BCYK42b:3:CL:55:default",
  "state": "PREPARATION",
  "updated_at": "2021-12-22 07:46:44.291808Z",
  "data_agreement_id": "b329ff24-076c-4ac4-ba36-723b422f1dfc",
  "method_of_use": "data-source",
  "schema_id": "8zn9iWuZUc8jsy6BCYK42b:2:Covid19 Test Results:1.0.0",
  "created_at": "2021-12-22 07:46:44.291808Z",
  "delete_flag": "False",
  "trace": false
}
```

`data_agreement_id` in the response is the identifier of the data agreement. This identifier is used in subsequest operations like **UPDATE**, **DELETE** and **READ**.

Data agreements can be queried (**READ**) by performing [**HTTP GET** http://testcenter.swagger.localhost/data-agreements](http://testcenter.swagger.localhost/api/doc#/Data%20Agreement%20-%20Core%20Functions/get_data_agreements) by passing `data_agreement_id` as query parameter.

**UPDATE** to data agreements can be performed by performing [**HTTP PUT** http://testcenter.swagger.localhost/data-agreements/{data_agreement_id}](http://testcenter.swagger.localhost/api/doc#/Data%20Agreement%20-%20Core%20Functions/put_data_agreements__data_agreement_id_) by passing updated data agreement as request payload and `data_agreement_id` as path parameter.

Once a data agreement is updated, old data agreements is no longer published. The new data agreement supercedes the old one and is marked as published. **Version history** of the data agreement can be accessed by performing [**HTTP GET** http://testcenter.swagger.localhost/data-agreements/version-history/{data_agreement_id}](http://testcenter.swagger.localhost/api/doc#/Data%20Agreement%20-%20Core%20Functions/get_data_agreements_version_history__data_agreement_id_) by passing `data_agreement_id` as path parameter.

Data agreement can be deleted by performing [**HTTP DELETE** http://testcenter.swagger.localhost/data-agreements/{data_agreement_id}](http://testcenter.swagger.localhost/api/doc#/Data%20Agreement%20-%20Core%20Functions/delete_data_agreements__data_agreement_id_) by passing `data_agreement_id` as path parameter.


### 5.1.2 Data Agreement capture workflow (includes issue credential by SSI)

#### 5.1.2.1 Establish connection between Test Center and the Individual


1. Create invitation by Test Center and send the invitation to the individual through OOB channel.

Perform [**HTTP POST** http://testcenter.swagger.localhost/connections/create-invitation](http://testcenter.swagger.localhost/api/doc#/connection/post_connections_create_invitation). Sample response is given below.

```json
{
  "connection_id": "422eea09-195a-4c1c-b9da-db0b44620b8d",
  "invitation": {
    "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/connections/1.0/invitation",
    "@id": "7e223aa0-f768-49be-af0d-487e28c9ae0e",
    "recipientKeys": [
      "6Sg63zYtfD2AkeYcjQc9T6X4gafwfLAQHHYMXUAUwgay"
    ],
    "serviceEndpoint": "http://testcenter.localhost",
    "label": "Test-Center"
  },
  "invitation_url": "http://testcenter.localhost?c_i=eyJAdHlwZSI6ICJkaWQ6c292OkJ6Q2JzTlloTXJqSGlxWkRUVUFTSGc7c3BlYy9jb25uZWN0aW9ucy8xLjAvaW52aXRhdGlvbiIsICJAaWQiOiAiN2UyMjNhYTAtZjc2OC00OWJlLWFmMGQtNDg3ZTI4YzlhZTBlIiwgInJlY2lwaWVudEtleXMiOiBbIjZTZzYzell0ZkQyQWtlWWNqUWM5VDZYNGdhZndmTEFRSEhZTVhVQVV3Z2F5Il0sICJzZXJ2aWNlRW5kcG9pbnQiOiAiaHR0cDovL3Rlc3RjZW50ZXIubG9jYWxob3N0IiwgImxhYmVsIjogIlRlc3QtQ2VudGVyIn0="
}
```

Send the content of `invitation` to the individual through out-of-band means.

2. Receive a new connection invitation from the Test Center by the Individual.

Receive a new connection invitation by copying the invitation from response in step 1 and passing it as request body to [**HTTP POST** http://individual.swagger.localhost/connections/receive-invitation](http://individual.swagger.localhost/api/doc#/connection/post_connections_receive_invitation). Sample response is given below.

```json
{
  "created_at": "2021-12-22 12:23:38.469888Z",
  "updated_at": "2021-12-22 12:23:38.469888Z",
  "invitation_mode": "once",
  "their_label": "Test-Center",
  "connection_id": "73b2edc4-522b-4743-8d03-2907fa9ea991",
  "accept": "manual",
  "routing_state": "none",
  "invitation_key": "6Sg63zYtfD2AkeYcjQc9T6X4gafwfLAQHHYMXUAUwgay",
  "initiator": "external",
  "state": "invitation"
}
```

3. Accept received connection invitation by Individual.

Perform [**HTTP POST** http://individual.swagger.localhost/connections/{conn_id}/accept-invitation](http://individual.swagger.localhost/api/doc#/connection/post_connections__conn_id__accept_invitation) by passing `connection_id` from the above response. Sample response is given below.

```json
{
  "created_at": "2021-12-22 12:23:38.469888Z",
  "request_id": "7179d214-23be-4f15-a8f4-88dbb0892b75",
  "updated_at": "2021-12-22 12:25:55.233694Z",
  "my_did": "SrnCqbFxn38J94pABcrPZc",
  "invitation_mode": "once",
  "their_label": "Test-Center",
  "connection_id": "73b2edc4-522b-4743-8d03-2907fa9ea991",
  "accept": "manual",
  "routing_state": "none",
  "invitation_key": "6Sg63zYtfD2AkeYcjQc9T6X4gafwfLAQHHYMXUAUwgay",
  "initiator": "external",
  "state": "request"
}
```

#### 5.1.2.2 Test Center offers a credential to the individual


Perform [**HTTP POST** http://testcenter.swagger.localhost/issue-credential/send-offer](http://testcenter.swagger.localhost/api/doc#/issue-credential/post_issue_credential_send_offer).

Sample request body is given below.

```json
{
  "auto_issue": true,
  "auto_remove": false,
  "comment": "Issuance of Covid-19 Test Results",
  "connection_id": "422eea09-195a-4c1c-b9da-db0b44620b8d",
  "cred_def_id": "8zn9iWuZUc8jsy6BCYK42b:3:CL:55:default",
  "credential_preview": {
    "@type": "issue-credential/1.0/credential-preview",
    "attributes": [
      {
        "name": "Test Result",
        "value": "Negative"
      },
      {
        "name": "Beneficiary Name",
        "value": "Alice"
      },
      {
        "name": "Certificate Issuer",
        "value": "Swedish e-Health Agency"
      }
    ]
  },
  "data_agreement_id": "b329ff24-076c-4ac4-ba36-723b422f1dfc",
  "trace": false
}
```

- `connection_id`: Connection identifier is obtained from the response in [Section 5.1.2.1 Step 1](#5121-establish-connection-between-test-center-and-the-individual)
- `cred_def_id`: Credential definition identifier is obtained from the data agreement prepared in [Section 5.1.1 Step 3](#511-data-agreement-definition-and-preparation-workflow)
- `credential_preview`: Credential preview is constructed in accordance with personal data specified the data agreement.
- `data_agreement_id`: Data agreement identifier is obtained from the data agreement prepared in [Section 5.1.1 Step 3](#511-data-agreement-definition-and-preparation-workflow)

**Note**: Data agreement identifier is optional, if provided then the `offer-credential` didcomm message will carry the associated data agreement offer instance in `~data-agreement-context` decorator.

Send offer API might take some time to execute, since it is preparing the data agreement by generating the Linked Data Proofs. This process involves resolving the context in real time over the internet.

Sample response is given below.

```json
{
  "thread_id": "9168bf7e-6d08-40b7-910c-e4202992fb8c",
  "updated_at": "2021-12-22 12:47:16.524539Z",
  "created_at": "2021-12-22 12:47:05.741772Z",
  "credential_proposal_dict": {
    "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/issue-credential/1.0/propose-credential",
    "@id": "59ca7d52-e390-4b21-abdc-d67395cef187",
    "credential_proposal": {
      "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/issue-credential/1.0/credential-preview",
      "attributes": [
        {
          "name": "Test Result",
          "value": "Negative"
        },
        {
          "name": "Beneficiary Name",
          "value": "Alice"
        },
        {
          "name": "Certificate Issuer",
          "value": "Swedish e-Health Agency"
        }
      ]
    },
    "cred_def_id": "8zn9iWuZUc8jsy6BCYK42b:3:CL:55:default",
    "comment": "Issuance of Covid-19 Test Results"
  },
  "trace": false,
  "credential_offer": {
    "schema_id": "8zn9iWuZUc8jsy6BCYK42b:2:Covid19 Test Results:1.0.0",
    "cred_def_id": "8zn9iWuZUc8jsy6BCYK42b:3:CL:55:default",
    "key_correctness_proof": {
      "c": "105900000790982073928869529081277316084773227550282495741859568403966520137202",
      "xz_cap": "385098801946788524384919158495714573922908921436033697321641581934116568740321409807698548033738238536519213435140648277916783172592234889397340665130053551969204349916202582558465980371167311406736701991926022112378210541738098386802534596324109486975004371114335760512983936869162615334106225973773956719535780301160799815705126251071678338701351969104808748900579170658046216266264104545604950219408906663720182647088959830831695060548885525121489425097260775558676461908563572738109305605341538418878956409570306947059363187204805011137603530828563336134095707182090862432365463961933837836296201638799961291844985803871996881717391344764950765556963620507154532404514691875305743623602576",
      "xr_cap": [
        [
          "testresult",
          "615070135108421969806945783228928994392505982765760876476606524493951346942052063262862837967207761234881933515391729343083706614646241449754588635923537580368748643243908637168846802532513331348741861992934938893316172981408597717413073301143375108073847197244829382112456660698179816025995582157055232815563824783123001995966711808115308940194609577993188975389333085630578150554351315229358993282322059676280980486401772426790654264164829904937581720575868018784691418195692122878986796158122639665561837777767158509568108125662338063282104332035908553807203925173270902078820369251598808438911410946502065144806325597541036829662444657204143777805838778543222479056087826560831081086458800"
        ],
        [
          "certificateissuer",
          "820330245455844980350934665091267317971081391334672457861517466475237448395668005079143721665130102017719111004830882263848023662821829236216786396833385242870818260145146868834377622423047316858704265598225700894682777106941683455526335474832754819560627192660630541527158975265583839329336849795596173289545594991125479163997103843737962262839917450047728530341805189499590538112824466629455003255567515978089710760664567039431355265842900796491595629967007497437142117860992118600630916369363193017403739439918922946850401115778666068209583668415465613535605311496586869387332537586836542269055892202229772925755000965838393454126941872575643085271010327458339544588823742863288191178739047"
        ],
        [
          "beneficiaryname",
          "400472586207939969528803764354328601368214137305176176850827629435563017485807426838207942044003775614600681950011611772393493932054900178436181466958679697932571430119062572528635055551023268879000197775049762801375975094759836082619065354158979726718027015187398626336885571359396043341479163977865830154637193645666568610506582048304990386513746931308823080600370769459722365458027818825093709009100689889344559462188490982232528280014385221171747170890291026222357716998403574884273830091240729128823019265075572528809482751474867127175991758177437149290335721334125170361331699324074946086637239656950285528194915586508053749352352505950854981373077228631594236243488472193196923969622706"
        ],
        [
          "master_secret",
          "1900456721595957649393425561338652614068203789011692585806234976611276372517641284129075161384084966580170868624723139620712745591330660899350184576988941703054047415745831972690641400985328723683689145791020643886549057075692452317726972996590681004277363513744760489924129337590196836051400133571142107134327349371747399595012924630186994865589292602131522333614660015546463589291158192480644207056719519197603726530910964114461624337198784494932697076393672228305676891945188690841245856519327974407229749718870697228267788444508599822408510779789547284786468111581281883911594133560967750038428015295541199988943010465215414140746712441185739211853412503542990252165672088415631752387461085"
        ]
      ]
    },
    "nonce": "835466362367016278448021"
  },
  "initiator": "self",
  "credential_definition_id": "8zn9iWuZUc8jsy6BCYK42b:3:CL:55:default",
  "credential_offer_dict": {
    "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/issue-credential/1.0/offer-credential",
    "@id": "9168bf7e-6d08-40b7-910c-e4202992fb8c",
    "~thread": {},
    "~data-agreement-context": {
      "message_type": "protocol",
      "message": {
        "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/data-agreement-negotiation/1.0/offer",
        "@id": "54a6f263-8a99-4513-a313-b4ed6dfabc1d",
        "from": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn",
        "body": {
          "@context": [
            "https://raw.githubusercontent.com/decentralised-dataexchange/automated-data-agreements/main/interface-specs/data-agreement-schema/v1/data-agreement-schema-context.jsonld",
            "https://w3id.org/security/v2"
          ],
          "id": "a32bdfeb-65d4-4cf0-b004-4cdb833042b2",
          "version": 1,
          "template_id": "b329ff24-076c-4ac4-ba36-723b422f1dfc",
          "template_version": 1,
          "data_controller_name": "Test Center AB",
          "data_controller_url": "https://www.testcenter.se",
          "purpose": "Covid19 Test Results",
          "purpose_description": "Release of Covid19 Test Results to individual.",
          "lawful_basis": "consent",
          "method_of_use": "data-source",
          "data_policy": {
            "data_retention_period": 365,
            "policy_URL": "https://testcenter.se/privacy-policy/",
            "jurisdiction": "Sweden",
            "industry_sector": "Healthcare",
            "geographic_restriction": "Europe",
            "storage_location": "Europe"
          },
          "personal_data": [
            {
              "attribute_id": "437b0b94-78ba-475c-a20b-26b44de095ab",
              "attribute_name": "Test Result",
              "attribute_sensitive": true,
              "attribute_category": "Health Certificate",
              "attribute_description": "Result of the Covid-19 Test conducted by the Test Center"
            },
            {
              "attribute_id": "0f391930-c933-48aa-9af4-5388b98b4fa5",
              "attribute_name": "Beneficiary Name",
              "attribute_sensitive": true,
              "attribute_category": "Health Certificate",
              "attribute_description": "Full name of the individual"
            },
            {
              "attribute_id": "1b978aa6-d633-4029-b626-4ea38e760dd4",
              "attribute_name": "Certificate Issuer",
              "attribute_sensitive": true,
              "attribute_category": "Health Certificate",
              "attribute_description": "The issuer of the certificate, e.g. Swedish e-Health Agency"
            }
          ],
          "event": [
            {
              "id": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn#1",
              "time_stamp": "2021-12-22T12:47:05.816357+00:00",
              "did": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn",
              "state": "offer"
            }
          ],
          "proof": {
            "id": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn#1",
            "type": "Ed25519Signature2018",
            "created": "2021-12-22T12:47:05.817813+00:00",
            "verificationMethod": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn",
            "proofPurpose": "contractAgreement",
            "proofValue": "eyJhbGciOiAiRWREU0EiLCAiYjY0IjogZmFsc2UsICJjcml0IjogWyJiNjQiXX0..eEziRTJ10X_P1OzbH2wu44nvvNGcmp4DI6fLvG5ZAr5e38I4KXbEfnjCDy6b8ZaR3Ktk0UcJi0OVEJv_XwtbBA"
          },
          "data_subject_did": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW"
        },
        "created_time": "1640177236",
        "to": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW"
      }
    },
    "credential_preview": {
      "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/issue-credential/1.0/credential-preview",
      "attributes": [
        {
          "name": "Test Result",
          "value": "Negative"
        },
        {
          "name": "Beneficiary Name",
          "value": "Alice"
        },
        {
          "name": "Certificate Issuer",
          "value": "Swedish e-Health Agency"
        }
      ]
    },
    "offers~attach": [
      {
        "@id": "libindy-cred-offer-0",
        "mime-type": "application/json",
        "data": {
          "base64": "eyJzY2hlbWFfaWQiOiAiOHpuOWlXdVpVYzhqc3k2QkNZSzQyYjoyOkNvdmlkMTkgVGVzdCBSZXN1bHRzOjEuMC4wIiwgImNyZWRfZGVmX2lkIjogIjh6bjlpV3VaVWM4anN5NkJDWUs0MmI6MzpDTDo1NTpkZWZhdWx0IiwgImtleV9jb3JyZWN0bmVzc19wcm9vZiI6IHsiYyI6ICIxMDU5MDAwMDA3OTA5ODIwNzM5Mjg4Njk1MjkwODEyNzczMTYwODQ3NzMyMjc1NTAyODI0OTU3NDE4NTk1Njg0MDM5NjY1MjAxMzcyMDIiLCAieHpfY2FwIjogIjM4NTA5ODgwMTk0Njc4ODUyNDM4NDkxOTE1ODQ5NTcxNDU3MzkyMjkwODkyMTQzNjAzMzY5NzMyMTY0MTU4MTkzNDExNjU2ODc0MDMyMTQwOTgwNzY5ODU0ODAzMzczODIzODUzNjUxOTIxMzQzNTE0MDY0ODI3NzkxNjc4MzE3MjU5MjIzNDg4OTM5NzM0MDY2NTEzMDA1MzU1MTk2OTIwNDM0OTkxNjIwMjU4MjU1ODQ2NTk4MDM3MTE2NzMxMTQwNjczNjcwMTk5MTkyNjAyMjExMjM3ODIxMDU0MTczODA5ODM4NjgwMjUzNDU5NjMyNDEwOTQ4Njk3NTAwNDM3MTExNDMzNTc2MDUxMjk4MzkzNjg2OTE2MjYxNTMzNDEwNjIyNTk3Mzc3Mzk1NjcxOTUzNTc4MDMwMTE2MDc5OTgxNTcwNTEyNjI1MTA3MTY3ODMzODcwMTM1MTk2OTEwNDgwODc0ODkwMDU3OTE3MDY1ODA0NjIxNjI2NjI2NDEwNDU0NTYwNDk1MDIxOTQwODkwNjY2MzcyMDE4MjY0NzA4ODk1OTgzMDgzMTY5NTA2MDU0ODg4NTUyNTEyMTQ4OTQyNTA5NzI2MDc3NTU1ODY3NjQ2MTkwODU2MzU3MjczODEwOTMwNTYwNTM0MTUzODQxODg3ODk1NjQwOTU3MDMwNjk0NzA1OTM2MzE4NzIwNDgwNTAxMTEzNzYwMzUzMDgyODU2MzMzNjEzNDA5NTcwNzE4MjA5MDg2MjQzMjM2NTQ2Mzk2MTkzMzgzNzgzNjI5NjIwMTYzODc5OTk2MTI5MTg0NDk4NTgwMzg3MTk5Njg4MTcxNzM5MTM0NDc2NDk1MDc2NTU1Njk2MzYyMDUwNzE1NDUzMjQwNDUxNDY5MTg3NTMwNTc0MzYyMzYwMjU3NiIsICJ4cl9jYXAiOiBbWyJ0ZXN0cmVzdWx0IiwgIjYxNTA3MDEzNTEwODQyMTk2OTgwNjk0NTc4MzIyODkyODk5NDM5MjUwNTk4Mjc2NTc2MDg3NjQ3NjYwNjUyNDQ5Mzk1MTM0Njk0MjA1MjA2MzI2Mjg2MjgzNzk2NzIwNzc2MTIzNDg4MTkzMzUxNTM5MTcyOTM0MzA4MzcwNjYxNDY0NjI0MTQ0OTc1NDU4ODYzNTkyMzUzNzU4MDM2ODc0ODY0MzI0MzkwODYzNzE2ODg0NjgwMjUzMjUxMzMzMTM0ODc0MTg2MTk5MjkzNDkzODg5MzMxNjE3Mjk4MTQwODU5NzcxNzQxMzA3MzMwMTE0MzM3NTEwODA3Mzg0NzE5NzI0NDgyOTM4MjExMjQ1NjY2MDY5ODE3OTgxNjAyNTk5NTU4MjE1NzA1NTIzMjgxNTU2MzgyNDc4MzEyMzAwMTk5NTk2NjcxMTgwODExNTMwODk0MDE5NDYwOTU3Nzk5MzE4ODk3NTM4OTMzMzA4NTYzMDU3ODE1MDU1NDM1MTMxNTIyOTM1ODk5MzI4MjMyMjA1OTY3NjI4MDk4MDQ4NjQwMTc3MjQyNjc5MDY1NDI2NDE2NDgyOTkwNDkzNzU4MTcyMDU3NTg2ODAxODc4NDY5MTQxODE5NTY5MjEyMjg3ODk4Njc5NjE1ODEyMjYzOTY2NTU2MTgzNzc3Nzc2NzE1ODUwOTU2ODEwODEyNTY2MjMzODA2MzI4MjEwNDMzMjAzNTkwODU1MzgwNzIwMzkyNTE3MzI3MDkwMjA3ODgyMDM2OTI1MTU5ODgwODQzODkxMTQxMDk0NjUwMjA2NTE0NDgwNjMyNTU5NzU0MTAzNjgyOTY2MjQ0NDY1NzIwNDE0Mzc3NzgwNTgzODc3ODU0MzIyMjQ3OTA1NjA4NzgyNjU2MDgzMTA4MTA4NjQ1ODgwMCJdLCBbImNlcnRpZmljYXRlaXNzdWVyIiwgIjgyMDMzMDI0NTQ1NTg0NDk4MDM1MDkzNDY2NTA5MTI2NzMxNzk3MTA4MTM5MTMzNDY3MjQ1Nzg2MTUxNzQ2NjQ3NTIzNzQ0ODM5NTY2ODAwNTA3OTE0MzcyMTY2NTEzMDEwMjAxNzcxOTExMTAwNDgzMDg4MjI2Mzg0ODAyMzY2MjgyMTgyOTIzNjIxNjc4NjM5NjgzMzM4NTI0Mjg3MDgxODI2MDE0NTE0Njg2ODgzNDM3NzYyMjQyMzA0NzMxNjg1ODcwNDI2NTU5ODIyNTcwMDg5NDY4Mjc3NzEwNjk0MTY4MzQ1NTUyNjMzNTQ3NDgzMjc1NDgxOTU2MDYyNzE5MjY2MDYzMDU0MTUyNzE1ODk3NTI2NTU4MzgzOTMyOTMzNjg0OTc5NTU5NjE3MzI4OTU0NTU5NDk5MTEyNTQ3OTE2Mzk5NzEwMzg0MzczNzk2MjI2MjgzOTkxNzQ1MDA0NzcyODUzMDM0MTgwNTE4OTQ5OTU5MDUzODExMjgyNDQ2NjYyOTQ1NTAwMzI1NTU2NzUxNTk3ODA4OTcxMDc2MDY2NDU2NzAzOTQzMTM1NTI2NTg0MjkwMDc5NjQ5MTU5NTYyOTk2NzAwNzQ5NzQzNzE0MjExNzg2MDk5MjExODYwMDYzMDkxNjM2OTM2MzE5MzAxNzQwMzczOTQzOTkxODkyMjk0Njg1MDQwMTExNTc3ODY2NjA2ODIwOTU4MzY2ODQxNTQ2NTYxMzUzNTYwNTMxMTQ5NjU4Njg2OTM4NzMzMjUzNzU4NjgzNjU0MjI2OTA1NTg5MjIwMjIyOTc3MjkyNTc1NTAwMDk2NTgzODM5MzQ1NDEyNjk0MTg3MjU3NTY0MzA4NTI3MTAxMDMyNzQ1ODMzOTU0NDU4ODgyMzc0Mjg2MzI4ODE5MTE3ODczOTA0NyJdLCBbImJlbmVmaWNpYXJ5bmFtZSIsICI0MDA0NzI1ODYyMDc5Mzk5Njk1Mjg4MDM3NjQzNTQzMjg2MDEzNjgyMTQxMzczMDUxNzYxNzY4NTA4Mjc2Mjk0MzU1NjMwMTc0ODU4MDc0MjY4MzgyMDc5NDIwNDQwMDM3NzU2MTQ2MDA2ODE5NTAwMTE2MTE3NzIzOTM0OTM5MzIwNTQ5MDAxNzg0MzYxODE0NjY5NTg2Nzk2OTc5MzI1NzE0MzAxMTkwNjI1NzI1Mjg2MzUwNTU1NTEwMjMyNjg4NzkwMDAxOTc3NzUwNDk3NjI4MDEzNzU5NzUwOTQ3NTk4MzYwODI2MTkwNjUzNTQxNTg5Nzk3MjY3MTgwMjcwMTUxODczOTg2MjYzMzY4ODU1NzEzNTkzOTYwNDMzNDE0NzkxNjM5Nzc4NjU4MzAxNTQ2MzcxOTM2NDU2NjY1Njg2MTA1MDY1ODIwNDgzMDQ5OTAzODY1MTM3NDY5MzEzMDg4MjMwODA2MDAzNzA3Njk0NTk3MjIzNjU0NTgwMjc4MTg4MjUwOTM3MDkwMDkxMDA2ODk4ODkzNDQ1NTk0NjIxODg0OTA5ODIyMzI1MjgyODAwMTQzODUyMjExNzE3NDcxNzA4OTAyOTEwMjYyMjIzNTc3MTY5OTg0MDM1NzQ4ODQyNzM4MzAwOTEyNDA3MjkxMjg4MjMwMTkyNjUwNzU1NzI1Mjg4MDk0ODI3NTE0NzQ4NjcxMjcxNzU5OTE3NTgxNzc0MzcxNDkyOTAzMzU3MjEzMzQxMjUxNzAzNjEzMzE2OTkzMjQwNzQ5NDYwODY2MzcyMzk2NTY5NTAyODU1MjgxOTQ5MTU1ODY1MDgwNTM3NDkzNTIzNTI1MDU5NTA4NTQ5ODEzNzMwNzcyMjg2MzE1OTQyMzYyNDM0ODg0NzIxOTMxOTY5MjM5Njk2MjI3MDYiXSwgWyJtYXN0ZXJfc2VjcmV0IiwgIjE5MDA0NTY3MjE1OTU5NTc2NDkzOTM0MjU1NjEzMzg2NTI2MTQwNjgyMDM3ODkwMTE2OTI1ODU4MDYyMzQ5NzY2MTEyNzYzNzI1MTc2NDEyODQxMjkwNzUxNjEzODQwODQ5NjY1ODAxNzA4Njg2MjQ3MjMxMzk2MjA3MTI3NDU1OTEzMzA2NjA4OTkzNTAxODQ1NzY5ODg5NDE3MDMwNTQwNDc0MTU3NDU4MzE5NzI2OTA2NDE0MDA5ODUzMjg3MjM2ODM2ODkxNDU3OTEwMjA2NDM4ODY1NDkwNTcwNzU2OTI0NTIzMTc3MjY5NzI5OTY1OTA2ODEwMDQyNzczNjM1MTM3NDQ3NjA0ODk5MjQxMjkzMzc1OTAxOTY4MzYwNTE0MDAxMzM1NzExNDIxMDcxMzQzMjczNDkzNzE3NDczOTk1OTUwMTI5MjQ2MzAxODY5OTQ4NjU1ODkyOTI2MDIxMzE1MjIzMzM2MTQ2NjAwMTU1NDY0NjM1ODkyOTExNTgxOTI0ODA2NDQyMDcwNTY3MTk1MTkxOTc2MDM3MjY1MzA5MTA5NjQxMTQ0NjE2MjQzMzcxOTg3ODQ0OTQ5MzI2OTcwNzYzOTM2NzIyMjgzMDU2NzY4OTE5NDUxODg2OTA4NDEyNDU4NTY1MTkzMjc5NzQ0MDcyMjk3NDk3MTg4NzA2OTcyMjgyNjc3ODg0NDQ1MDg1OTk4MjI0MDg1MTA3Nzk3ODk1NDcyODQ3ODY0NjgxMTE1ODEyODE4ODM5MTE1OTQxMzM1NjA5Njc3NTAwMzg0MjgwMTUyOTU1NDExOTk5ODg5NDMwMTA0NjUyMTU0MTQxNDA3NDY3MTI0NDExODU3MzkyMTE4NTM0MTI1MDM1NDI5OTAyNTIxNjU2NzIwODg0MTU2MzE3NTIzODc0NjEwODUiXV19LCAibm9uY2UiOiAiODM1NDY2MzYyMzY3MDE2Mjc4NDQ4MDIxIn0="
        }
      }
    ],
    "comment": "Issuance of Covid-19 Test Results"
  },
  "data_agreement_template_id": "b329ff24-076c-4ac4-ba36-723b422f1dfc",
  "schema_id": "8zn9iWuZUc8jsy6BCYK42b:2:Covid19 Test Results:1.0.0",
  "auto_remove": false,
  "data_agreement_id": "a32bdfeb-65d4-4cf0-b004-4cdb833042b2",
  "credential_exchange_id": "2c1e4010-6f70-4143-8544-fe818e16c41f",
  "auto_issue": false,
  "data_agreement_status": "offer",
  "data_agreement": {
    "@context": [
      "https://raw.githubusercontent.com/decentralised-dataexchange/automated-data-agreements/main/interface-specs/data-agreement-schema/v1/data-agreement-schema-context.jsonld",
      "https://w3id.org/security/v2"
    ],
    "id": "a32bdfeb-65d4-4cf0-b004-4cdb833042b2",
    "version": 1,
    "template_id": "b329ff24-076c-4ac4-ba36-723b422f1dfc",
    "template_version": 1,
    "data_controller_name": "Test Center AB",
    "data_controller_url": "https://www.testcenter.se",
    "purpose": "Covid19 Test Results",
    "purpose_description": "Release of Covid19 Test Results to individual.",
    "lawful_basis": "consent",
    "method_of_use": "data-source",
    "data_policy": {
      "data_retention_period": 365,
      "policy_URL": "https://testcenter.se/privacy-policy/",
      "jurisdiction": "Sweden",
      "industry_sector": "Healthcare",
      "geographic_restriction": "Europe",
      "storage_location": "Europe"
    },
    "personal_data": [
      {
        "attribute_id": "437b0b94-78ba-475c-a20b-26b44de095ab",
        "attribute_name": "Test Result",
        "attribute_sensitive": true,
        "attribute_category": "Health Certificate",
        "attribute_description": "Result of the Covid-19 Test conducted by the Test Center"
      },
      {
        "attribute_id": "0f391930-c933-48aa-9af4-5388b98b4fa5",
        "attribute_name": "Beneficiary Name",
        "attribute_sensitive": true,
        "attribute_category": "Health Certificate",
        "attribute_description": "Full name of the individual"
      },
      {
        "attribute_id": "1b978aa6-d633-4029-b626-4ea38e760dd4",
        "attribute_name": "Certificate Issuer",
        "attribute_sensitive": true,
        "attribute_category": "Health Certificate",
        "attribute_description": "The issuer of the certificate, e.g. Swedish e-Health Agency"
      }
    ],
    "event": [
      {
        "id": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn#1",
        "time_stamp": "2021-12-22T12:47:05.816357+00:00",
        "did": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn",
        "state": "offer"
      }
    ],
    "proof": {
      "id": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn#1",
      "type": "Ed25519Signature2018",
      "created": "2021-12-22T12:47:05.817813+00:00",
      "verificationMethod": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn",
      "proofPurpose": "contractAgreement",
      "proofValue": "eyJhbGciOiAiRWREU0EiLCAiYjY0IjogZmFsc2UsICJjcml0IjogWyJiNjQiXX0..eEziRTJ10X_P1OzbH2wu44nvvNGcmp4DI6fLvG5ZAr5e38I4KXbEfnjCDy6b8ZaR3Ktk0UcJi0OVEJv_XwtbBA"
    },
    "data_subject_did": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW"
  },
  "connection_id": "422eea09-195a-4c1c-b9da-db0b44620b8d",
  "state": "offer_sent",
  "auto_offer": false
}
```

- `credential_offer_dict` - Contains the `issue-credential/1.0/offer-credential` didcomm message send to the individual.
- `data_agreement_template_id` - Data agreement template identifier
- `data_agreement_id` - Data agreement instance identifer (Specific to the individual)
- `data_agreement_status` - Data agreement status
- `data_agreement` - Data agreement
- `thread_id` - Thread identifier (Parent didcomm message identifier)
- `credential_exchange_id` - Credential exchange record identifier

#### 5.1.2.3 Individual receives the credential offer

In a practical implementation, when the individual receives the credential offer, a notification is shown in the UI. 

For the sake of simplicity, the individual can query the credential offer by using the `data_agreement_id` (data agreement **instance** identifier) from response [above](#5122-test-center-offers-a-credential-to-the-individual).

Query the credential offer by performing [**HTTP GET** http://individual.swagger.localhost/issue-credential/records?data_agreement_id={data_agreement_id}](http://individual.swagger.localhost/api/doc#/issue-credential/get_issue_credential_records) by passing data_agreement_id as query parameter.

Sample response is given below.

```json
{
  "results": [
    {
      "credential_definition_id": "8zn9iWuZUc8jsy6BCYK42b:3:CL:55:default",
      "data_agreement_template_id": "b329ff24-076c-4ac4-ba36-723b422f1dfc",
      "credential_proposal_dict": {
        "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/issue-credential/1.0/propose-credential",
        "@id": "67787774-a9b2-4753-8f35-9d238979c473",
        "credential_proposal": {
          "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/issue-credential/1.0/credential-preview",
          "attributes": [
            {
              "name": "Test Result",
              "value": "Negative"
            },
            {
              "name": "Beneficiary Name",
              "value": "Alice"
            },
            {
              "name": "Certificate Issuer",
              "value": "Swedish e-Health Agency"
            }
          ]
        },
        "comment": "Issuance of Covid-19 Test Results",
        "cred_def_id": "8zn9iWuZUc8jsy6BCYK42b:3:CL:55:default",
        "schema_id": "8zn9iWuZUc8jsy6BCYK42b:2:Covid19 Test Results:1.0.0"
      },
      "auto_issue": false,
      "schema_id": "8zn9iWuZUc8jsy6BCYK42b:2:Covid19 Test Results:1.0.0",
      "role": "holder",
      "updated_at": "2021-12-22 12:47:25.677520Z",
      "thread_id": "9168bf7e-6d08-40b7-910c-e4202992fb8c",
      "data_agreement_id": "a32bdfeb-65d4-4cf0-b004-4cdb833042b2",
      "data_agreement_status": "offer",
      "created_at": "2021-12-22 12:47:16.898748Z",
      "connection_id": "73b2edc4-522b-4743-8d03-2907fa9ea991",
      "initiator": "external",
      "state": "offer_received",
      "credential_exchange_id": "da6dcc4f-2327-4686-824b-b6accb532664",
      "data_agreement": {
        "@context": [
          "https://raw.githubusercontent.com/decentralised-dataexchange/automated-data-agreements/main/interface-specs/data-agreement-schema/v1/data-agreement-schema-context.jsonld",
          "https://w3id.org/security/v2"
        ],
        "id": "a32bdfeb-65d4-4cf0-b004-4cdb833042b2",
        "version": 1,
        "template_id": "b329ff24-076c-4ac4-ba36-723b422f1dfc",
        "template_version": 1,
        "data_controller_name": "Test Center AB",
        "data_controller_url": "https://www.testcenter.se",
        "purpose": "Covid19 Test Results",
        "purpose_description": "Release of Covid19 Test Results to individual.",
        "lawful_basis": "consent",
        "method_of_use": "data-source",
        "data_policy": {
          "data_retention_period": 365,
          "policy_URL": "https://testcenter.se/privacy-policy/",
          "jurisdiction": "Sweden",
          "industry_sector": "Healthcare",
          "geographic_restriction": "Europe",
          "storage_location": "Europe"
        },
        "personal_data": [
          {
            "attribute_id": "437b0b94-78ba-475c-a20b-26b44de095ab",
            "attribute_name": "Test Result",
            "attribute_sensitive": true,
            "attribute_category": "Health Certificate",
            "attribute_description": "Result of the Covid-19 Test conducted by the Test Center"
          },
          {
            "attribute_id": "0f391930-c933-48aa-9af4-5388b98b4fa5",
            "attribute_name": "Beneficiary Name",
            "attribute_sensitive": true,
            "attribute_category": "Health Certificate",
            "attribute_description": "Full name of the individual"
          },
          {
            "attribute_id": "1b978aa6-d633-4029-b626-4ea38e760dd4",
            "attribute_name": "Certificate Issuer",
            "attribute_sensitive": true,
            "attribute_category": "Health Certificate",
            "attribute_description": "The issuer of the certificate, e.g. Swedish e-Health Agency"
          }
        ],
        "event": [
          {
            "id": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn#1",
            "time_stamp": "2021-12-22T12:47:05.816357+00:00",
            "did": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn",
            "state": "offer"
          }
        ],
        "proof": {
          "id": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn#1",
          "type": "Ed25519Signature2018",
          "created": "2021-12-22T12:47:05.817813+00:00",
          "verificationMethod": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn",
          "proofPurpose": "contractAgreement",
          "proofValue": "eyJhbGciOiAiRWREU0EiLCAiYjY0IjogZmFsc2UsICJjcml0IjogWyJiNjQiXX0..eEziRTJ10X_P1OzbH2wu44nvvNGcmp4DI6fLvG5ZAr5e38I4KXbEfnjCDy6b8ZaR3Ktk0UcJi0OVEJv_XwtbBA"
        },
        "data_subject_did": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW"
      },
      "trace": false,
      "auto_remove": false,
      "auto_offer": false,
      "credential_offer": {
        "schema_id": "8zn9iWuZUc8jsy6BCYK42b:2:Covid19 Test Results:1.0.0",
        "cred_def_id": "8zn9iWuZUc8jsy6BCYK42b:3:CL:55:default",
        "key_correctness_proof": {
          "c": "105900000790982073928869529081277316084773227550282495741859568403966520137202",
          "xz_cap": "385098801946788524384919158495714573922908921436033697321641581934116568740321409807698548033738238536519213435140648277916783172592234889397340665130053551969204349916202582558465980371167311406736701991926022112378210541738098386802534596324109486975004371114335760512983936869162615334106225973773956719535780301160799815705126251071678338701351969104808748900579170658046216266264104545604950219408906663720182647088959830831695060548885525121489425097260775558676461908563572738109305605341538418878956409570306947059363187204805011137603530828563336134095707182090862432365463961933837836296201638799961291844985803871996881717391344764950765556963620507154532404514691875305743623602576",
          "xr_cap": [
            [
              "testresult",
              "615070135108421969806945783228928994392505982765760876476606524493951346942052063262862837967207761234881933515391729343083706614646241449754588635923537580368748643243908637168846802532513331348741861992934938893316172981408597717413073301143375108073847197244829382112456660698179816025995582157055232815563824783123001995966711808115308940194609577993188975389333085630578150554351315229358993282322059676280980486401772426790654264164829904937581720575868018784691418195692122878986796158122639665561837777767158509568108125662338063282104332035908553807203925173270902078820369251598808438911410946502065144806325597541036829662444657204143777805838778543222479056087826560831081086458800"
            ],
            [
              "certificateissuer",
              "820330245455844980350934665091267317971081391334672457861517466475237448395668005079143721665130102017719111004830882263848023662821829236216786396833385242870818260145146868834377622423047316858704265598225700894682777106941683455526335474832754819560627192660630541527158975265583839329336849795596173289545594991125479163997103843737962262839917450047728530341805189499590538112824466629455003255567515978089710760664567039431355265842900796491595629967007497437142117860992118600630916369363193017403739439918922946850401115778666068209583668415465613535605311496586869387332537586836542269055892202229772925755000965838393454126941872575643085271010327458339544588823742863288191178739047"
            ],
            [
              "beneficiaryname",
              "400472586207939969528803764354328601368214137305176176850827629435563017485807426838207942044003775614600681950011611772393493932054900178436181466958679697932571430119062572528635055551023268879000197775049762801375975094759836082619065354158979726718027015187398626336885571359396043341479163977865830154637193645666568610506582048304990386513746931308823080600370769459722365458027818825093709009100689889344559462188490982232528280014385221171747170890291026222357716998403574884273830091240729128823019265075572528809482751474867127175991758177437149290335721334125170361331699324074946086637239656950285528194915586508053749352352505950854981373077228631594236243488472193196923969622706"
            ],
            [
              "master_secret",
              "1900456721595957649393425561338652614068203789011692585806234976611276372517641284129075161384084966580170868624723139620712745591330660899350184576988941703054047415745831972690641400985328723683689145791020643886549057075692452317726972996590681004277363513744760489924129337590196836051400133571142107134327349371747399595012924630186994865589292602131522333614660015546463589291158192480644207056719519197603726530910964114461624337198784494932697076393672228305676891945188690841245856519327974407229749718870697228267788444508599822408510779789547284786468111581281883911594133560967750038428015295541199988943010465215414140746712441185739211853412503542990252165672088415631752387461085"
            ]
          ]
        },
        "nonce": "835466362367016278448021"
      }
    }
  ]
}
```

- `data_agreement_template_id` - Data agreement template identifier
- `data_agreement_id` - Data agreement instance identifer (Specific to the individual)
- `data_agreement_status` - Data agreement status
- `data_agreement` - Data agreement
- `thread_id` - Thread identifier (Parent didcomm message identifier)
- `credential_exchange_id` - Credential exchange record identifier (data exchange record identifier)

Individual can decide to accept or reject the offer by inspecting the offer data and data agreement associated with it.

Individual can query the data agreement associated with a data exchange by `credential_exchange_id`. Perform [**HTTP GET** http://individual.swagger.localhost/data-agreement-instances?data_exchange_record_id={data_exchange_record_id}](http://individual.swagger.localhost/api/doc#/Data%20Agreement%20-%20Core%20Functions/get_data_agreement_instances) by passing the `data_exchange_record_id` as query parameter.

Sample response is given below.

```json
{
  "results": [
    {
      "data_exchange_record_id": "da6dcc4f-2327-4686-824b-b6accb532664",
      "data_agreement": {
        "@context": [
          "https://raw.githubusercontent.com/decentralised-dataexchange/automated-data-agreements/main/interface-specs/data-agreement-schema/v1/data-agreement-schema-context.jsonld",
          "https://w3id.org/security/v2"
        ],
        "id": "a32bdfeb-65d4-4cf0-b004-4cdb833042b2",
        "version": 1,
        "template_id": "b329ff24-076c-4ac4-ba36-723b422f1dfc",
        "template_version": 1,
        "data_controller_name": "Test Center AB",
        "data_controller_url": "https://www.testcenter.se",
        "purpose": "Covid19 Test Results",
        "purpose_description": "Release of Covid19 Test Results to individual.",
        "lawful_basis": "consent",
        "method_of_use": "data-source",
        "data_policy": {
          "data_retention_period": 365,
          "policy_URL": "https://testcenter.se/privacy-policy/",
          "jurisdiction": "Sweden",
          "industry_sector": "Healthcare",
          "geographic_restriction": "Europe",
          "storage_location": "Europe"
        },
        "personal_data": [
          {
            "attribute_id": "437b0b94-78ba-475c-a20b-26b44de095ab",
            "attribute_name": "Test Result",
            "attribute_sensitive": true,
            "attribute_category": "Health Certificate",
            "attribute_description": "Result of the Covid-19 Test conducted by the Test Center"
          },
          {
            "attribute_id": "0f391930-c933-48aa-9af4-5388b98b4fa5",
            "attribute_name": "Beneficiary Name",
            "attribute_sensitive": true,
            "attribute_category": "Health Certificate",
            "attribute_description": "Full name of the individual"
          },
          {
            "attribute_id": "1b978aa6-d633-4029-b626-4ea38e760dd4",
            "attribute_name": "Certificate Issuer",
            "attribute_sensitive": true,
            "attribute_category": "Health Certificate",
            "attribute_description": "The issuer of the certificate, e.g. Swedish e-Health Agency"
          }
        ],
        "event": [
          {
            "id": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn#1",
            "time_stamp": "2021-12-22T12:47:05.816357+00:00",
            "did": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn",
            "state": "offer"
          }
        ],
        "data_subject_did": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW",
        "proof": {
          "id": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn#1",
          "type": "Ed25519Signature2018",
          "created": "2021-12-22T12:47:05.817813+00:00",
          "verificationMethod": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn",
          "proofPurpose": "contractAgreement",
          "proofValue": "eyJhbGciOiAiRWREU0EiLCAiYjY0IjogZmFsc2UsICJjcml0IjogWyJiNjQiXX0..eEziRTJ10X_P1OzbH2wu44nvvNGcmp4DI6fLvG5ZAr5e38I4KXbEfnjCDy6b8ZaR3Ktk0UcJi0OVEJv_XwtbBA"
        }
      }
    }
  ]
}
```

#### 5.1.2.4 Individual rejects the data agreement

Individual decided to reject the data agreement.

Perform [**HTTP POST** http://individual.swagger.localhost/issue-credential/records/{cred_ex_id}/data-agreement-negotiation/reject](http://individual.swagger.localhost/api/doc#/issue-credential/post_issue_credential_records__cred_ex_id__data_agreement_negotiation_reject) by passing the `cred_ex_id` as path parameter. 

After rejection, individual can query the data agreement to see the `reject` event and it's proof updated. 

Individual can query the data agreement associated with a data exchange by `credential_exchange_id`. Perform [**HTTP GET** http://individual.swagger.localhost/data-agreement-instances?data_exchange_record_id={data_exchange_record_id}](http://individual.swagger.localhost/api/doc#/Data%20Agreement%20-%20Core%20Functions/get_data_agreement_instances) by passing the `data_exchange_record_id` as query parameter. 



Sample response is given below.

```json
{
  "results": [
    {
      "data_exchange_record_id": "da6dcc4f-2327-4686-824b-b6accb532664",
      "data_agreement": {
        "@context": [
          "https://raw.githubusercontent.com/decentralised-dataexchange/automated-data-agreements/main/interface-specs/data-agreement-schema/v1/data-agreement-schema-context.jsonld",
          "https://w3id.org/security/v2"
        ],
        "id": "a32bdfeb-65d4-4cf0-b004-4cdb833042b2",
        "version": 1,
        "template_id": "b329ff24-076c-4ac4-ba36-723b422f1dfc",
        "template_version": 1,
        "data_controller_name": "Test Center AB",
        "data_controller_url": "https://www.testcenter.se",
        "purpose": "Covid19 Test Results",
        "purpose_description": "Release of Covid19 Test Results to individual.",
        "lawful_basis": "consent",
        "method_of_use": "data-source",
        "data_policy": {
          "data_retention_period": 365,
          "policy_URL": "https://testcenter.se/privacy-policy/",
          "jurisdiction": "Sweden",
          "industry_sector": "Healthcare",
          "geographic_restriction": "Europe",
          "storage_location": "Europe"
        },
        "personal_data": [
          {
            "attribute_id": "437b0b94-78ba-475c-a20b-26b44de095ab",
            "attribute_name": "Test Result",
            "attribute_sensitive": true,
            "attribute_category": "Health Certificate",
            "attribute_description": "Result of the Covid-19 Test conducted by the Test Center"
          },
          {
            "attribute_id": "0f391930-c933-48aa-9af4-5388b98b4fa5",
            "attribute_name": "Beneficiary Name",
            "attribute_sensitive": true,
            "attribute_category": "Health Certificate",
            "attribute_description": "Full name of the individual"
          },
          {
            "attribute_id": "1b978aa6-d633-4029-b626-4ea38e760dd4",
            "attribute_name": "Certificate Issuer",
            "attribute_sensitive": true,
            "attribute_category": "Health Certificate",
            "attribute_description": "The issuer of the certificate, e.g. Swedish e-Health Agency"
          }
        ],
        "event": [
          {
            "id": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn#1",
            "time_stamp": "2021-12-22T12:47:05.816357+00:00",
            "did": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn",
            "state": "offer"
          },
          {
            "id": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW#2",
            "time_stamp": "2021-12-22T13:28:17.474965+00:00",
            "did": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW",
            "state": "reject"
          }
        ],
        "proofChain": [
          {
            "id": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn#1",
            "type": "Ed25519Signature2018",
            "created": "2021-12-22T12:47:05.817813+00:00",
            "verificationMethod": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn",
            "proofPurpose": "contractAgreement",
            "proofValue": "eyJhbGciOiAiRWREU0EiLCAiYjY0IjogZmFsc2UsICJjcml0IjogWyJiNjQiXX0..eEziRTJ10X_P1OzbH2wu44nvvNGcmp4DI6fLvG5ZAr5e38I4KXbEfnjCDy6b8ZaR3Ktk0UcJi0OVEJv_XwtbBA"
          },
          {
            "id": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW#2",
            "type": "Ed25519Signature2018",
            "created": "2021-12-22T13:28:17.478040+00:00",
            "verificationMethod": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW",
            "proofPurpose": "contractAgreement",
            "proofValue": "eyJhbGciOiAiRWREU0EiLCAiYjY0IjogZmFsc2UsICJjcml0IjogWyJiNjQiXX0..4hOT_VU2mfBEntodhGWvUqmtmkcc6_D7hjN5fms_0ja941SQ4mOu8O7a87ujhgVBVwYj6b9r8eH7DyhqjFCbDw"
          }
        ],
        "data_subject_did": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW"
      }
    }
  ]
}
```

The above data agreement contains `reject` event and it's proof.


#### 5.1.2.5 Individual accepts the data agreement

Accepting data agreeement would mean Individual is ready for the Test Center to send the actual credentials which can then be stored in the wallet. Individual should send `issue-credential/1.0/request-credential` message to the Test Center.

Perform [**HTTP POST** http://individual.swagger.localhost/issue-credential/records/{cred_ex_id}/send-request](http://individual.swagger.localhost/api/doc#/issue-credential/post_issue_credential_records__cred_ex_id__send_request) by passing the `cred_ex_id` as path parameter to request credential.

Sample response is given below.

```json
{
  "credential_definition_id": "8zn9iWuZUc8jsy6BCYK42b:3:CL:55:default",
  "data_agreement_template_id": "b329ff24-076c-4ac4-ba36-723b422f1dfc",
  "credential_proposal_dict": {
    "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/issue-credential/1.0/propose-credential",
    "@id": "e50d76be-7ed7-439c-afee-6679b2f8a661",
    "credential_proposal": {
      "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/issue-credential/1.0/credential-preview",
      "attributes": [
        {
          "name": "Test Result",
          "value": "Negative"
        },
        {
          "name": "Beneficiary Name",
          "value": "Alice"
        },
        {
          "name": "Certificate Issuer",
          "value": "Swedish e-Health Agency"
        }
      ]
    },
    "comment": "Issuance of Covid-19 Test Results",
    "cred_def_id": "8zn9iWuZUc8jsy6BCYK42b:3:CL:55:default",
    "schema_id": "8zn9iWuZUc8jsy6BCYK42b:2:Covid19 Test Results:1.0.0"
  },
  "auto_issue": false,
  "schema_id": "8zn9iWuZUc8jsy6BCYK42b:2:Covid19 Test Results:1.0.0",
  "role": "holder",
  "updated_at": "2021-12-22 13:58:26.503017Z",
  "credential_request_metadata": {
    "master_secret_blinding_data": {
      "v_prime": "33809551871075863230671987523265996634159406137153319893005946890367659559238226121045878959136025562881325238100010779096951164228500799302135474115733479173405013444191119699487091809339134328889000264709621436170831250175140655047381726692079112248943988475201066732629120600430022449673013536157958069879889376445080218735582520780902409059878996758777934313969668782479202344765119327918593716846165214175274126234101378219024012738443614425340694081194831398288780999791561828849402179452109974120769708222245888851792144302533529324977433451367581027255988291849360398001918446296004538911709102163798911979867295825807556822437597500",
      "vr_prime": null
    },
    "nonce": "1102318872769788879744434",
    "master_secret_name": "Individual"
  },
  "thread_id": "ad2671d4-5f0e-429c-a359-32e36d393244",
  "data_agreement_id": "183b8652-af4b-4fe5-a587-738e8d0beac0",
  "data_agreement_status": "accept",
  "created_at": "2021-12-22 13:51:47.562212Z",
  "connection_id": "73b2edc4-522b-4743-8d03-2907fa9ea991",
  "initiator": "external",
  "state": "request_sent",
  "credential_exchange_id": "fea25938-2c00-4814-b69b-87dc1e245918",
  "credential_request": {
    "prover_did": "SrnCqbFxn38J94pABcrPZc",
    "cred_def_id": "8zn9iWuZUc8jsy6BCYK42b:3:CL:55:default",
    "blinded_ms": {
      "u": "35662097033613076882324583588954484194446039396772618030438172894538191902575644840823588412625456755763639249274556357673377024457331390095187535962635056985807634558275198826921551030940713113981340893865220550443578089107196271813970744227037832881271469074392563565805070844023056008816632921435078257182597721822783330924338617680993602779237123467657201409619136205384532032764522844873984293152199688047010580589594634103005487982431108863646697962856419508905738767550932599252164710140933254366814615525432461322660089813260480121617244657490026675025379122421057764797642122600353587073215881580326591956464",
      "ur": null,
      "hidden_attributes": [
        "master_secret"
      ],
      "committed_attributes": {}
    },
    "blinded_ms_correctness_proof": {
      "c": "68935678956215054121806331749889465855305788683026777219129210629727208095758",
      "v_dash_cap": "2330684413437985693476468944260873974362912795297421244209222250382125716159458125986086198141383359767485469729577910250074475718248063220341804417236963187003910422088477635795141807619233024225604249249829973230771970528977652247204749394106866673531534445474599782934664123352968172470263872092297995377322943619742538882058754784404154032000487009085170752244938423972516860365019769448512279675716838669426308005352993538765850585521769975530657904970127982991297017724447272787859986030488859722102733196599650447719245963883534275068448855047467871778526929341107195911701802928518032084572777934825400291309759832147045206079518477036766568905860880377083201877155895086314646184540847761941012876298043112589",
      "m_caps": {
        "master_secret": "14939641390382185728356532006021510290094190246970270846391604912039636770103195699233615623202397138832880944276204012738938326642330557633858888369902292238241136454248660183146"
      },
      "r_caps": {}
    },
    "nonce": "1102318872769788879744434"
  },
  "data_agreement": {
    "@context": [
      "https://raw.githubusercontent.com/decentralised-dataexchange/automated-data-agreements/main/interface-specs/data-agreement-schema/v1/data-agreement-schema-context.jsonld",
      "https://w3id.org/security/v2"
    ],
    "id": "183b8652-af4b-4fe5-a587-738e8d0beac0",
    "version": 1,
    "template_id": "b329ff24-076c-4ac4-ba36-723b422f1dfc",
    "template_version": 1,
    "data_controller_name": "Test Center AB",
    "data_controller_url": "https://www.testcenter.se",
    "purpose": "Covid19 Test Results",
    "purpose_description": "Release of Covid19 Test Results to individual.",
    "lawful_basis": "consent",
    "method_of_use": "data-source",
    "data_policy": {
      "data_retention_period": 365,
      "policy_URL": "https://testcenter.se/privacy-policy/",
      "jurisdiction": "Sweden",
      "industry_sector": "Healthcare",
      "geographic_restriction": "Europe",
      "storage_location": "Europe"
    },
    "personal_data": [
      {
        "attribute_id": "437b0b94-78ba-475c-a20b-26b44de095ab",
        "attribute_name": "Test Result",
        "attribute_sensitive": true,
        "attribute_category": "Health Certificate",
        "attribute_description": "Result of the Covid-19 Test conducted by the Test Center"
      },
      {
        "attribute_id": "0f391930-c933-48aa-9af4-5388b98b4fa5",
        "attribute_name": "Beneficiary Name",
        "attribute_sensitive": true,
        "attribute_category": "Health Certificate",
        "attribute_description": "Full name of the individual"
      },
      {
        "attribute_id": "1b978aa6-d633-4029-b626-4ea38e760dd4",
        "attribute_name": "Certificate Issuer",
        "attribute_sensitive": true,
        "attribute_category": "Health Certificate",
        "attribute_description": "The issuer of the certificate, e.g. Swedish e-Health Agency"
      }
    ],
    "event": [
      {
        "id": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn#1",
        "time_stamp": "2021-12-22T13:51:37.271282+00:00",
        "did": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn",
        "state": "offer"
      },
      {
        "id": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW#2",
        "time_stamp": "2021-12-22T13:58:14.670991+00:00",
        "did": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW",
        "state": "accept"
      }
    ],
    "proofChain": [
      {
        "id": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn#1",
        "type": "Ed25519Signature2018",
        "created": "2021-12-22T13:51:37.273151+00:00",
        "verificationMethod": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn",
        "proofPurpose": "contractAgreement",
        "proofValue": "eyJhbGciOiAiRWREU0EiLCAiYjY0IjogZmFsc2UsICJjcml0IjogWyJiNjQiXX0..vEBtZFaCnmmJBr_WLWT382NB5l_9xcKFEhxvWEw_zHfNDXFE9I0jVcQJ4hbnZU2RoWJ2Q8zg20LMGrSpKaB8CA"
      },
      {
        "id": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW#2",
        "type": "Ed25519Signature2018",
        "created": "2021-12-22T13:58:14.671994+00:00",
        "verificationMethod": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW",
        "proofPurpose": "contractAgreement",
        "proofValue": "eyJhbGciOiAiRWREU0EiLCAiYjY0IjogZmFsc2UsICJjcml0IjogWyJiNjQiXX0..1unCHCVZ-UtXWuFnLMstpyCrYGnEuDj3HCi8IN6J9uAHs97rP5EgIa2tSwd2i2w0lzS-2pJ53c66DqSeJuI5DA"
      }
    ],
    "data_subject_did": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW"
  },
  "trace": false,
  "auto_remove": false,
  "auto_offer": false,
  "credential_offer": {
    "schema_id": "8zn9iWuZUc8jsy6BCYK42b:2:Covid19 Test Results:1.0.0",
    "cred_def_id": "8zn9iWuZUc8jsy6BCYK42b:3:CL:55:default",
    "key_correctness_proof": {
      "c": "105900000790982073928869529081277316084773227550282495741859568403966520137202",
      "xz_cap": "385098801946788524384919158495714573922908921436033697321641581934116568740321409807698548033738238536519213435140648277916783172592234889397340665130053551969204349916202582558465980371167311406736701991926022112378210541738098386802534596324109486975004371114335760512983936869162615334106225973773956719535780301160799815705126251071678338701351969104808748900579170658046216266264104545604950219408906663720182647088959830831695060548885525121489425097260775558676461908563572738109305605341538418878956409570306947059363187204805011137603530828563336134095707182090862432365463961933837836296201638799961291844985803871996881717391344764950765556963620507154532404514691875305743623602576",
      "xr_cap": [
        [
          "testresult",
          "615070135108421969806945783228928994392505982765760876476606524493951346942052063262862837967207761234881933515391729343083706614646241449754588635923537580368748643243908637168846802532513331348741861992934938893316172981408597717413073301143375108073847197244829382112456660698179816025995582157055232815563824783123001995966711808115308940194609577993188975389333085630578150554351315229358993282322059676280980486401772426790654264164829904937581720575868018784691418195692122878986796158122639665561837777767158509568108125662338063282104332035908553807203925173270902078820369251598808438911410946502065144806325597541036829662444657204143777805838778543222479056087826560831081086458800"
        ],
        [
          "certificateissuer",
          "820330245455844980350934665091267317971081391334672457861517466475237448395668005079143721665130102017719111004830882263848023662821829236216786396833385242870818260145146868834377622423047316858704265598225700894682777106941683455526335474832754819560627192660630541527158975265583839329336849795596173289545594991125479163997103843737962262839917450047728530341805189499590538112824466629455003255567515978089710760664567039431355265842900796491595629967007497437142117860992118600630916369363193017403739439918922946850401115778666068209583668415465613535605311496586869387332537586836542269055892202229772925755000965838393454126941872575643085271010327458339544588823742863288191178739047"
        ],
        [
          "beneficiaryname",
          "400472586207939969528803764354328601368214137305176176850827629435563017485807426838207942044003775614600681950011611772393493932054900178436181466958679697932571430119062572528635055551023268879000197775049762801375975094759836082619065354158979726718027015187398626336885571359396043341479163977865830154637193645666568610506582048304990386513746931308823080600370769459722365458027818825093709009100689889344559462188490982232528280014385221171747170890291026222357716998403574884273830091240729128823019265075572528809482751474867127175991758177437149290335721334125170361331699324074946086637239656950285528194915586508053749352352505950854981373077228631594236243488472193196923969622706"
        ],
        [
          "master_secret",
          "1900456721595957649393425561338652614068203789011692585806234976611276372517641284129075161384084966580170868624723139620712745591330660899350184576988941703054047415745831972690641400985328723683689145791020643886549057075692452317726972996590681004277363513744760489924129337590196836051400133571142107134327349371747399595012924630186994865589292602131522333614660015546463589291158192480644207056719519197603726530910964114461624337198784494932697076393672228305676891945188690841245856519327974407229749718870697228267788444508599822408510779789547284786468111581281883911594133560967750038428015295541199988943010465215414140746712441185739211853412503542990252165672088415631752387461085"
        ]
      ]
    },
    "nonce": "835466362367016278448021"
  }
}
```


After accepting, individual can query the data agreement to see the `accept` event and it's proof updated. 

Individual can query the data agreement associated with a data exchange by `credential_exchange_id`. Perform [**HTTP GET** http://individual.swagger.localhost/data-agreement-instances?data_exchange_record_id={data_exchange_record_id}](http://individual.swagger.localhost/api/doc#/Data%20Agreement%20-%20Core%20Functions/get_data_agreement_instances) by passing the `data_exchange_record_id` as query parameter. 


A sample response is given below.

```json
{
  "results": [
    {
      "data_exchange_record_id": "fea25938-2c00-4814-b69b-87dc1e245918",
      "data_agreement": {
        "@context": [
          "https://raw.githubusercontent.com/decentralised-dataexchange/automated-data-agreements/main/interface-specs/data-agreement-schema/v1/data-agreement-schema-context.jsonld",
          "https://w3id.org/security/v2"
        ],
        "id": "183b8652-af4b-4fe5-a587-738e8d0beac0",
        "version": 1,
        "template_id": "b329ff24-076c-4ac4-ba36-723b422f1dfc",
        "template_version": 1,
        "data_controller_name": "Test Center AB",
        "data_controller_url": "https://www.testcenter.se",
        "purpose": "Covid19 Test Results",
        "purpose_description": "Release of Covid19 Test Results to individual.",
        "lawful_basis": "consent",
        "method_of_use": "data-source",
        "data_policy": {
          "data_retention_period": 365,
          "policy_URL": "https://testcenter.se/privacy-policy/",
          "jurisdiction": "Sweden",
          "industry_sector": "Healthcare",
          "geographic_restriction": "Europe",
          "storage_location": "Europe"
        },
        "personal_data": [
          {
            "attribute_id": "437b0b94-78ba-475c-a20b-26b44de095ab",
            "attribute_name": "Test Result",
            "attribute_sensitive": true,
            "attribute_category": "Health Certificate",
            "attribute_description": "Result of the Covid-19 Test conducted by the Test Center"
          },
          {
            "attribute_id": "0f391930-c933-48aa-9af4-5388b98b4fa5",
            "attribute_name": "Beneficiary Name",
            "attribute_sensitive": true,
            "attribute_category": "Health Certificate",
            "attribute_description": "Full name of the individual"
          },
          {
            "attribute_id": "1b978aa6-d633-4029-b626-4ea38e760dd4",
            "attribute_name": "Certificate Issuer",
            "attribute_sensitive": true,
            "attribute_category": "Health Certificate",
            "attribute_description": "The issuer of the certificate, e.g. Swedish e-Health Agency"
          }
        ],
        "event": [
          {
            "id": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn#1",
            "time_stamp": "2021-12-22T13:51:37.271282+00:00",
            "did": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn",
            "state": "offer"
          },
          {
            "id": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW#2",
            "time_stamp": "2021-12-22T13:58:14.670991+00:00",
            "did": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW",
            "state": "accept"
          }
        ],
        "proofChain": [
          {
            "id": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn#1",
            "type": "Ed25519Signature2018",
            "created": "2021-12-22T13:51:37.273151+00:00",
            "verificationMethod": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn",
            "proofPurpose": "contractAgreement",
            "proofValue": "eyJhbGciOiAiRWREU0EiLCAiYjY0IjogZmFsc2UsICJjcml0IjogWyJiNjQiXX0..vEBtZFaCnmmJBr_WLWT382NB5l_9xcKFEhxvWEw_zHfNDXFE9I0jVcQJ4hbnZU2RoWJ2Q8zg20LMGrSpKaB8CA"
          },
          {
            "id": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW#2",
            "type": "Ed25519Signature2018",
            "created": "2021-12-22T13:58:14.671994+00:00",
            "verificationMethod": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW",
            "proofPurpose": "contractAgreement",
            "proofValue": "eyJhbGciOiAiRWREU0EiLCAiYjY0IjogZmFsc2UsICJjcml0IjogWyJiNjQiXX0..1unCHCVZ-UtXWuFnLMstpyCrYGnEuDj3HCi8IN6J9uAHs97rP5EgIa2tSwd2i2w0lzS-2pJ53c66DqSeJuI5DA"
          }
        ],
        "data_subject_did": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW"
      }
    }
  ]
}
```

The above data agreement contains `accept` event and it's proof.

### 5.1.3 Data Agreement terminate workflow

Individual can decide to terminate an accepted data agreement.

Perform [**HTTP POST** http://individual.swagger.localhost/issue-credential/records/{cred_ex_id}/data-agreement-termination/terminate](http://individual.swagger.localhost/api/doc#/issue-credential/post_issue_credential_records__cred_ex_id__data_agreement_termination_terminate) by passing `cred_ex_id` as path parameter to terminate the data agreement associated with credential exchange.

Sample response is given below.

```json
{
  "credential_definition_id": "8zn9iWuZUc8jsy6BCYK42b:3:CL:55:default",
  "data_agreement_template_id": "b329ff24-076c-4ac4-ba36-723b422f1dfc",
  "credential_proposal_dict": {
    "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/issue-credential/1.0/propose-credential",
    "@id": "e50d76be-7ed7-439c-afee-6679b2f8a661",
    "credential_proposal": {
      "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/issue-credential/1.0/credential-preview",
      "attributes": [
        {
          "name": "Test Result",
          "value": "Negative"
        },
        {
          "name": "Beneficiary Name",
          "value": "Alice"
        },
        {
          "name": "Certificate Issuer",
          "value": "Swedish e-Health Agency"
        }
      ]
    },
    "comment": "Issuance of Covid-19 Test Results",
    "cred_def_id": "8zn9iWuZUc8jsy6BCYK42b:3:CL:55:default",
    "schema_id": "8zn9iWuZUc8jsy6BCYK42b:2:Covid19 Test Results:1.0.0"
  },
  "auto_issue": false,
  "schema_id": "8zn9iWuZUc8jsy6BCYK42b:2:Covid19 Test Results:1.0.0",
  "role": "holder",
  "updated_at": "2021-12-22 14:09:18.700482Z",
  "credential_request_metadata": {
    "master_secret_blinding_data": {
      "v_prime": "33809551871075863230671987523265996634159406137153319893005946890367659559238226121045878959136025562881325238100010779096951164228500799302135474115733479173405013444191119699487091809339134328889000264709621436170831250175140655047381726692079112248943988475201066732629120600430022449673013536157958069879889376445080218735582520780902409059878996758777934313969668782479202344765119327918593716846165214175274126234101378219024012738443614425340694081194831398288780999791561828849402179452109974120769708222245888851792144302533529324977433451367581027255988291849360398001918446296004538911709102163798911979867295825807556822437597500",
      "vr_prime": null
    },
    "nonce": "1102318872769788879744434",
    "master_secret_name": "Individual"
  },
  "thread_id": "ad2671d4-5f0e-429c-a359-32e36d393244",
  "data_agreement_id": "183b8652-af4b-4fe5-a587-738e8d0beac0",
  "data_agreement_status": "terminate",
  "created_at": "2021-12-22 13:51:47.562212Z",
  "connection_id": "73b2edc4-522b-4743-8d03-2907fa9ea991",
  "initiator": "external",
  "state": "request_sent",
  "credential_exchange_id": "fea25938-2c00-4814-b69b-87dc1e245918",
  "credential_request": {
    "prover_did": "SrnCqbFxn38J94pABcrPZc",
    "cred_def_id": "8zn9iWuZUc8jsy6BCYK42b:3:CL:55:default",
    "blinded_ms": {
      "u": "35662097033613076882324583588954484194446039396772618030438172894538191902575644840823588412625456755763639249274556357673377024457331390095187535962635056985807634558275198826921551030940713113981340893865220550443578089107196271813970744227037832881271469074392563565805070844023056008816632921435078257182597721822783330924338617680993602779237123467657201409619136205384532032764522844873984293152199688047010580589594634103005487982431108863646697962856419508905738767550932599252164710140933254366814615525432461322660089813260480121617244657490026675025379122421057764797642122600353587073215881580326591956464",
      "ur": null,
      "hidden_attributes": [
        "master_secret"
      ],
      "committed_attributes": {}
    },
    "blinded_ms_correctness_proof": {
      "c": "68935678956215054121806331749889465855305788683026777219129210629727208095758",
      "v_dash_cap": "2330684413437985693476468944260873974362912795297421244209222250382125716159458125986086198141383359767485469729577910250074475718248063220341804417236963187003910422088477635795141807619233024225604249249829973230771970528977652247204749394106866673531534445474599782934664123352968172470263872092297995377322943619742538882058754784404154032000487009085170752244938423972516860365019769448512279675716838669426308005352993538765850585521769975530657904970127982991297017724447272787859986030488859722102733196599650447719245963883534275068448855047467871778526929341107195911701802928518032084572777934825400291309759832147045206079518477036766568905860880377083201877155895086314646184540847761941012876298043112589",
      "m_caps": {
        "master_secret": "14939641390382185728356532006021510290094190246970270846391604912039636770103195699233615623202397138832880944276204012738938326642330557633858888369902292238241136454248660183146"
      },
      "r_caps": {}
    },
    "nonce": "1102318872769788879744434"
  },
  "data_agreement": {
    "@context": [
      "https://raw.githubusercontent.com/decentralised-dataexchange/automated-data-agreements/main/interface-specs/data-agreement-schema/v1/data-agreement-schema-context.jsonld",
      "https://w3id.org/security/v2"
    ],
    "id": "183b8652-af4b-4fe5-a587-738e8d0beac0",
    "version": 1,
    "template_id": "b329ff24-076c-4ac4-ba36-723b422f1dfc",
    "template_version": 1,
    "data_controller_name": "Test Center AB",
    "data_controller_url": "https://www.testcenter.se",
    "purpose": "Covid19 Test Results",
    "purpose_description": "Release of Covid19 Test Results to individual.",
    "lawful_basis": "consent",
    "method_of_use": "data-source",
    "data_policy": {
      "data_retention_period": 365,
      "policy_URL": "https://testcenter.se/privacy-policy/",
      "jurisdiction": "Sweden",
      "industry_sector": "Healthcare",
      "geographic_restriction": "Europe",
      "storage_location": "Europe"
    },
    "personal_data": [
      {
        "attribute_id": "437b0b94-78ba-475c-a20b-26b44de095ab",
        "attribute_name": "Test Result",
        "attribute_sensitive": true,
        "attribute_category": "Health Certificate",
        "attribute_description": "Result of the Covid-19 Test conducted by the Test Center"
      },
      {
        "attribute_id": "0f391930-c933-48aa-9af4-5388b98b4fa5",
        "attribute_name": "Beneficiary Name",
        "attribute_sensitive": true,
        "attribute_category": "Health Certificate",
        "attribute_description": "Full name of the individual"
      },
      {
        "attribute_id": "1b978aa6-d633-4029-b626-4ea38e760dd4",
        "attribute_name": "Certificate Issuer",
        "attribute_sensitive": true,
        "attribute_category": "Health Certificate",
        "attribute_description": "The issuer of the certificate, e.g. Swedish e-Health Agency"
      }
    ],
    "event": [
      {
        "id": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn#1",
        "time_stamp": "2021-12-22T13:51:37.271282+00:00",
        "did": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn",
        "state": "offer"
      },
      {
        "id": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW#2",
        "time_stamp": "2021-12-22T13:58:14.670991+00:00",
        "did": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW",
        "state": "accept"
      },
      {
        "id": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW#3",
        "time_stamp": "2021-12-22T14:09:08.870401+00:00",
        "did": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW",
        "state": "terminate"
      }
    ],
    "proofChain": [
      {
        "id": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn#1",
        "type": "Ed25519Signature2018",
        "created": "2021-12-22T13:51:37.273151+00:00",
        "verificationMethod": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn",
        "proofPurpose": "contractAgreement",
        "proofValue": "eyJhbGciOiAiRWREU0EiLCAiYjY0IjogZmFsc2UsICJjcml0IjogWyJiNjQiXX0..vEBtZFaCnmmJBr_WLWT382NB5l_9xcKFEhxvWEw_zHfNDXFE9I0jVcQJ4hbnZU2RoWJ2Q8zg20LMGrSpKaB8CA"
      },
      {
        "id": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW#2",
        "type": "Ed25519Signature2018",
        "created": "2021-12-22T13:58:14.671994+00:00",
        "verificationMethod": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW",
        "proofPurpose": "contractAgreement",
        "proofValue": "eyJhbGciOiAiRWREU0EiLCAiYjY0IjogZmFsc2UsICJjcml0IjogWyJiNjQiXX0..1unCHCVZ-UtXWuFnLMstpyCrYGnEuDj3HCi8IN6J9uAHs97rP5EgIa2tSwd2i2w0lzS-2pJ53c66DqSeJuI5DA"
      },
      {
        "id": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW#3",
        "type": "Ed25519Signature2018",
        "created": "2021-12-22T14:09:08.873294+00:00",
        "verificationMethod": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW",
        "proofPurpose": "contractAgreement",
        "proofValue": "eyJhbGciOiAiRWREU0EiLCAiYjY0IjogZmFsc2UsICJjcml0IjogWyJiNjQiXX0..tuoPC0ptO0DY-50haUun9gKZTS1LhENaIpLHAqqzl3d-zaFgyZNanMeoQwZ7URQ6AiTqT7pa2lMYZyZ3PItuBQ"
      }
    ],
    "data_subject_did": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW"
  },
  "trace": false,
  "auto_remove": false,
  "auto_offer": false,
  "credential_offer": {
    "schema_id": "8zn9iWuZUc8jsy6BCYK42b:2:Covid19 Test Results:1.0.0",
    "cred_def_id": "8zn9iWuZUc8jsy6BCYK42b:3:CL:55:default",
    "key_correctness_proof": {
      "c": "105900000790982073928869529081277316084773227550282495741859568403966520137202",
      "xz_cap": "385098801946788524384919158495714573922908921436033697321641581934116568740321409807698548033738238536519213435140648277916783172592234889397340665130053551969204349916202582558465980371167311406736701991926022112378210541738098386802534596324109486975004371114335760512983936869162615334106225973773956719535780301160799815705126251071678338701351969104808748900579170658046216266264104545604950219408906663720182647088959830831695060548885525121489425097260775558676461908563572738109305605341538418878956409570306947059363187204805011137603530828563336134095707182090862432365463961933837836296201638799961291844985803871996881717391344764950765556963620507154532404514691875305743623602576",
      "xr_cap": [
        [
          "testresult",
          "615070135108421969806945783228928994392505982765760876476606524493951346942052063262862837967207761234881933515391729343083706614646241449754588635923537580368748643243908637168846802532513331348741861992934938893316172981408597717413073301143375108073847197244829382112456660698179816025995582157055232815563824783123001995966711808115308940194609577993188975389333085630578150554351315229358993282322059676280980486401772426790654264164829904937581720575868018784691418195692122878986796158122639665561837777767158509568108125662338063282104332035908553807203925173270902078820369251598808438911410946502065144806325597541036829662444657204143777805838778543222479056087826560831081086458800"
        ],
        [
          "certificateissuer",
          "820330245455844980350934665091267317971081391334672457861517466475237448395668005079143721665130102017719111004830882263848023662821829236216786396833385242870818260145146868834377622423047316858704265598225700894682777106941683455526335474832754819560627192660630541527158975265583839329336849795596173289545594991125479163997103843737962262839917450047728530341805189499590538112824466629455003255567515978089710760664567039431355265842900796491595629967007497437142117860992118600630916369363193017403739439918922946850401115778666068209583668415465613535605311496586869387332537586836542269055892202229772925755000965838393454126941872575643085271010327458339544588823742863288191178739047"
        ],
        [
          "beneficiaryname",
          "400472586207939969528803764354328601368214137305176176850827629435563017485807426838207942044003775614600681950011611772393493932054900178436181466958679697932571430119062572528635055551023268879000197775049762801375975094759836082619065354158979726718027015187398626336885571359396043341479163977865830154637193645666568610506582048304990386513746931308823080600370769459722365458027818825093709009100689889344559462188490982232528280014385221171747170890291026222357716998403574884273830091240729128823019265075572528809482751474867127175991758177437149290335721334125170361331699324074946086637239656950285528194915586508053749352352505950854981373077228631594236243488472193196923969622706"
        ],
        [
          "master_secret",
          "1900456721595957649393425561338652614068203789011692585806234976611276372517641284129075161384084966580170868624723139620712745591330660899350184576988941703054047415745831972690641400985328723683689145791020643886549057075692452317726972996590681004277363513744760489924129337590196836051400133571142107134327349371747399595012924630186994865589292602131522333614660015546463589291158192480644207056719519197603726530910964114461624337198784494932697076393672228305676891945188690841245856519327974407229749718870697228267788444508599822408510779789547284786468111581281883911594133560967750038428015295541199988943010465215414140746712441185739211853412503542990252165672088415631752387461085"
        ]
      ]
    },
    "nonce": "835466362367016278448021"
  }
}
```

After termination, individual can query the data agreement to see the `terminate` event and it's proof updated. 

Individual can query the data agreement associated with a data exchange by `credential_exchange_id`. Perform [**HTTP GET** http://individual.swagger.localhost/data-agreement-instances?data_exchange_record_id={data_exchange_record_id}](http://individual.swagger.localhost/api/doc#/Data%20Agreement%20-%20Core%20Functions/get_data_agreement_instances) by passing the `data_exchange_record_id` as query parameter. 


A sample response is given below.

```json
{
  "results": [
    {
      "data_exchange_record_id": "fea25938-2c00-4814-b69b-87dc1e245918",
      "data_agreement": {
        "@context": [
          "https://raw.githubusercontent.com/decentralised-dataexchange/automated-data-agreements/main/interface-specs/data-agreement-schema/v1/data-agreement-schema-context.jsonld",
          "https://w3id.org/security/v2"
        ],
        "id": "183b8652-af4b-4fe5-a587-738e8d0beac0",
        "version": 1,
        "template_id": "b329ff24-076c-4ac4-ba36-723b422f1dfc",
        "template_version": 1,
        "data_controller_name": "Test Center AB",
        "data_controller_url": "https://www.testcenter.se",
        "purpose": "Covid19 Test Results",
        "purpose_description": "Release of Covid19 Test Results to individual.",
        "lawful_basis": "consent",
        "method_of_use": "data-source",
        "data_policy": {
          "data_retention_period": 365,
          "policy_URL": "https://testcenter.se/privacy-policy/",
          "jurisdiction": "Sweden",
          "industry_sector": "Healthcare",
          "geographic_restriction": "Europe",
          "storage_location": "Europe"
        },
        "personal_data": [
          {
            "attribute_id": "437b0b94-78ba-475c-a20b-26b44de095ab",
            "attribute_name": "Test Result",
            "attribute_sensitive": true,
            "attribute_category": "Health Certificate",
            "attribute_description": "Result of the Covid-19 Test conducted by the Test Center"
          },
          {
            "attribute_id": "0f391930-c933-48aa-9af4-5388b98b4fa5",
            "attribute_name": "Beneficiary Name",
            "attribute_sensitive": true,
            "attribute_category": "Health Certificate",
            "attribute_description": "Full name of the individual"
          },
          {
            "attribute_id": "1b978aa6-d633-4029-b626-4ea38e760dd4",
            "attribute_name": "Certificate Issuer",
            "attribute_sensitive": true,
            "attribute_category": "Health Certificate",
            "attribute_description": "The issuer of the certificate, e.g. Swedish e-Health Agency"
          }
        ],
        "event": [
          {
            "id": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn#1",
            "time_stamp": "2021-12-22T13:51:37.271282+00:00",
            "did": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn",
            "state": "offer"
          },
          {
            "id": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW#2",
            "time_stamp": "2021-12-22T13:58:14.670991+00:00",
            "did": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW",
            "state": "accept"
          },
          {
            "id": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW#3",
            "time_stamp": "2021-12-22T14:09:08.870401+00:00",
            "did": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW",
            "state": "terminate"
          }
        ],
        "proofChain": [
          {
            "id": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn#1",
            "type": "Ed25519Signature2018",
            "created": "2021-12-22T13:51:37.273151+00:00",
            "verificationMethod": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn",
            "proofPurpose": "contractAgreement",
            "proofValue": "eyJhbGciOiAiRWREU0EiLCAiYjY0IjogZmFsc2UsICJjcml0IjogWyJiNjQiXX0..vEBtZFaCnmmJBr_WLWT382NB5l_9xcKFEhxvWEw_zHfNDXFE9I0jVcQJ4hbnZU2RoWJ2Q8zg20LMGrSpKaB8CA"
          },
          {
            "id": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW#2",
            "type": "Ed25519Signature2018",
            "created": "2021-12-22T13:58:14.671994+00:00",
            "verificationMethod": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW",
            "proofPurpose": "contractAgreement",
            "proofValue": "eyJhbGciOiAiRWREU0EiLCAiYjY0IjogZmFsc2UsICJjcml0IjogWyJiNjQiXX0..1unCHCVZ-UtXWuFnLMstpyCrYGnEuDj3HCi8IN6J9uAHs97rP5EgIa2tSwd2i2w0lzS-2pJ53c66DqSeJuI5DA"
          },
          {
            "id": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW#3",
            "type": "Ed25519Signature2018",
            "created": "2021-12-22T14:09:08.873294+00:00",
            "verificationMethod": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW",
            "proofPurpose": "contractAgreement",
            "proofValue": "eyJhbGciOiAiRWREU0EiLCAiYjY0IjogZmFsc2UsICJjcml0IjogWyJiNjQiXX0..tuoPC0ptO0DY-50haUun9gKZTS1LhENaIpLHAqqzl3d-zaFgyZNanMeoQwZ7URQ6AiTqT7pa2lMYZyZ3PItuBQ"
          }
        ],
        "data_subject_did": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW"
      }
    }
  ]
}
```

The above data agreement contains `terminate` event and it's proof.

## 5.2 Proof presentation by the individual to the travel company

### 5.2.1 Data Agreement definition and preparation workflow

1. Choose a data agreement defintion.

JSON-LD context document for version 1.0 data agreement is available at https://github.com/decentralised-dataexchange/automated-data-agreements/blob/main/interface-specs/data-agreement-schema/v1/data-agreement-schema-context.jsonld

2. Create personal data (attributes) for the data agreement preparation.

As mentioned in the use case scenario, Travel Company will verify the Covid-19 Test Result (issued by the Test Center) presented by Individual. Covid-19 Test Result contains 3 personal data (attributes). They are:

   - Test Result
   - Beneficiary Name
   - Certificate Issuer


Perform [**HTTP POST** http://travelcompany.swaggger.localhost/data-agreements/personal-data](http://travelcompany.swagger.localhost/api/doc#/Data%20Agreement%20-%20Core%20Functions/post_data_agreements_personal_data) to create the personal data.

Sample request body for creating Test Result personal data is given below:

```json
{
  "attribute_category": "Health Certificate",
  "attribute_description": "Result of the Covid-19 Test conducted by the Test Center",
  "attribute_name": "Test Result",
  "attribute_sensitive": true
}
```

Sample response is given below:

```json
{
  "attribute_description": "Result of the Covid-19 Test conducted by the Test Center",
  "updated_at": "2021-12-22 19:38:20.709148Z",
  "data_agreement_personal_data_record_id": "996dcab0-4182-468b-a106-19de5068c572",
  "attribute_name": "Test Result",
  "created_at": "2021-12-22 19:38:20.709148Z",
  "attribute_sensitive": "True",
  "trace": false,
  "attribute_category": "Health Certificate"
}
```

Sample request body for creating Beneficiary Name personal data is given below:

```json
{
  "attribute_category": "Health Certificate",
  "attribute_description": "Full name of the individual",
  "attribute_name": "Beneficiary Name",
  "attribute_sensitive": true
}
```

Sample response is given below:

```json
{
  "attribute_description": "Full name of the individual",
  "updated_at": "2021-12-22 19:38:37.415354Z",
  "data_agreement_personal_data_record_id": "3d6e27fe-847f-42e2-84e5-029df7e177e1",
  "attribute_name": "Beneficiary Name",
  "created_at": "2021-12-22 19:38:37.415354Z",
  "attribute_sensitive": "True",
  "trace": false,
  "attribute_category": "Health Certificate"
}
```

Sample request body for creating Certificate Issuer personal data is given below:

```json
{
  "attribute_category": "Health Certificate",
  "attribute_description": "The issuer of the certificate, e.g. Swedish e-Health Agency",
  "attribute_name": "Certificate Issuer",
  "attribute_sensitive": true
}
```

Sample response is given below:

```json
{
  "attribute_description": "The issuer of the certificate, e.g. Swedish e-Health Agency",
  "updated_at": "2021-12-22 19:38:56.907962Z",
  "data_agreement_personal_data_record_id": "4605e8c9-fcd4-43a9-91e3-b4762127c4e8",
  "attribute_name": "Certificate Issuer",
  "created_at": "2021-12-22 19:38:56.907962Z",
  "attribute_sensitive": "True",
  "trace": false,
  "attribute_category": "Health Certificate"
}
```


3. Prepare and record the data agreement.

Prepare the data agreement in accordance with the data agreement definition. A sample data agreement for the verification of Covid19 Test Results is given below.

```json
{
  "@context": "https://raw.githubusercontent.com/decentralised-dataexchange/automated-data-agreements/main/interface-specs/data-agreement-schema/v1/data-agreement-schema-context.jsonld",
  "data_controller_name": "Travel Company AB",
  "data_controller_url": "https://www.travelcompany.se",
  "data_policy": {
    "data_retention_period": 365,
    "geographic_restriction": "Europe",
    "industry_sector": "Travel",
    "jurisdiction": "Sweden",
    "policy_URL": "https://travelcompany.se/privacy-policy/",
    "storage_location": "Europe"
  },
  "lawful_basis": "consent",
  "method_of_use": "data-using-service",
  "personal_data": [
    {
      "attribute_id": "996dcab0-4182-468b-a106-19de5068c572",
      "restrictions": [
        {
          "cred_def_id": "8zn9iWuZUc8jsy6BCYK42b:3:CL:55:default",
          "schema_id": "8zn9iWuZUc8jsy6BCYK42b:2:Covid19 Test Results:1.0.0"
        }
      ]
    },
    {
      "attribute_id": "3d6e27fe-847f-42e2-84e5-029df7e177e1",
      "restrictions": [
        {
          "cred_def_id": "8zn9iWuZUc8jsy6BCYK42b:3:CL:55:default",
          "schema_id": "8zn9iWuZUc8jsy6BCYK42b:2:Covid19 Test Results:1.0.0"
        }
      ]
    },
    {
      "attribute_id": "4605e8c9-fcd4-43a9-91e3-b4762127c4e8",
      "restrictions": [
        {
          "cred_def_id": "8zn9iWuZUc8jsy6BCYK42b:3:CL:55:default",
          "schema_id": "8zn9iWuZUc8jsy6BCYK42b:2:Covid19 Test Results:1.0.0"
        }
      ]
    }
  ],
  "purpose": "Verification of Covid-19 Test Results",
  "purpose_description": "Perform verification of Covid-19 Test Result to permit travel."
}
```

**Note**: `personal_data` key in the above data agreement contains the list of personal data (attributes) that are to be received and verified from the individual. The list contains personal data identifiers (`data_agreement_personal_data_record_id`) obtained from the previous step. The list also contains the restrictions that are to be applied to the personal data to be received from the individual. The restrictions in the above example, constraints the data shared to be from a certain `schema_id` and `cred_def_id`. This can make sure the data shared is issued by Test Center to the individual.

Perform [**HTTP POST** http://travelcompany.swagger.localhost/data-agreements](http://travelcompany.swagger.localhost/api/doc#/Data%20Agreement%20-%20Core%20Functions/post_data_agreements) with the above prepared data agreement as request payload to record the data agreement.

Sample response is given below.

```json
{
  "published_flag": "True",
  "data_agreement": {
    "@context": "https://raw.githubusercontent.com/decentralised-dataexchange/automated-data-agreements/main/interface-specs/data-agreement-schema/v1/data-agreement-schema-context.jsonld",
    "template_id": "8f9878b0-cb20-4ed6-be5f-b2ef1531a13c",
    "template_version": 1,
    "data_controller_name": "Travel Company AB",
    "data_controller_url": "https://www.travelcompany.se",
    "purpose": "Verification of Covid-19 Test Results",
    "purpose_description": "Perform verification of Covid-19 Test Result to permit travel.",
    "lawful_basis": "consent",
    "method_of_use": "data-using-service",
    "data_policy": {
      "data_retention_period": 365,
      "policy_URL": "https://travelcompany.se/privacy-policy/",
      "jurisdiction": "Sweden",
      "industry_sector": "Travel",
      "geographic_restriction": "Europe",
      "storage_location": "Europe"
    },
    "personal_data": [
      {
        "attribute_id": "996dcab0-4182-468b-a106-19de5068c572",
        "attribute_name": "Test Result",
        "attribute_sensitive": true,
        "attribute_category": "Health Certificate",
        "attribute_description": "Result of the Covid-19 Test conducted by the Test Center"
      },
      {
        "attribute_id": "3d6e27fe-847f-42e2-84e5-029df7e177e1",
        "attribute_name": "Beneficiary Name",
        "attribute_sensitive": true,
        "attribute_category": "Health Certificate",
        "attribute_description": "Full name of the individual"
      },
      {
        "attribute_id": "4605e8c9-fcd4-43a9-91e3-b4762127c4e8",
        "attribute_name": "Certificate Issuer",
        "attribute_sensitive": true,
        "attribute_category": "Health Certificate",
        "attribute_description": "The issuer of the certificate, e.g. Swedish e-Health Agency"
      }
    ]
  },
  "updated_at": "2021-12-22 19:49:11.568384Z",
  "method_of_use": "data-using-service",
  "data_agreement_record_id": "71101f11-87d0-4ac8-882f-c613b7cf8d2a",
  "delete_flag": "False",
  "data_agreement_proof_presentation_request": {
    "name": "Verification of Covid-19 Test Results",
    "comment": "Perform verification of Covid-19 Test Result to permit travel.",
    "version": "1.0.0",
    "requested_attributes": {
      "additionalProp1": {
        "name": "Test Result",
        "restrictions": [
          {
            "cred_def_id": "8zn9iWuZUc8jsy6BCYK42b:3:CL:55:default",
            "schema_id": "8zn9iWuZUc8jsy6BCYK42b:2:Covid19 Test Results:1.0.0"
          }
        ]
      },
      "additionalProp2": {
        "name": "Beneficiary Name",
        "restrictions": [
          {
            "cred_def_id": "8zn9iWuZUc8jsy6BCYK42b:3:CL:55:default",
            "schema_id": "8zn9iWuZUc8jsy6BCYK42b:2:Covid19 Test Results:1.0.0"
          }
        ]
      },
      "additionalProp3": {
        "name": "Certificate Issuer",
        "restrictions": [
          {
            "cred_def_id": "8zn9iWuZUc8jsy6BCYK42b:3:CL:55:default",
            "schema_id": "8zn9iWuZUc8jsy6BCYK42b:2:Covid19 Test Results:1.0.0"
          }
        ]
      }
    },
    "requested_predicates": {}
  },
  "data_agreement_id": "8f9878b0-cb20-4ed6-be5f-b2ef1531a13c",
  "created_at": "2021-12-22 19:49:11.568384Z",
  "state": "PREPARATION",
  "trace": false
}
```

`data_agreement_id` in the response is the identifier of the data agreement. This identifier is used in subsequest operations like **UPDATE**, **DELETE** and **READ**.

Data agreements can be queried (**READ**) by performing [**HTTP GET** http://travelcompany.swagger.localhost/data-agreements](http://travelcompany.swagger.localhost/api/doc#/Data%20Agreement%20-%20Core%20Functions/get_data_agreements) by passing `data_agreement_id` as query parameter.

**UPDATE** to data agreements can be performed by performing [**HTTP PUT** http://travelcompany.swagger.localhost/data-agreements/{data_agreement_id}](http://travelcompany.swagger.localhost/api/doc#/Data%20Agreement%20-%20Core%20Functions/put_data_agreements__data_agreement_id_) by passing updated data agreement as request payload and `data_agreement_id` as path parameter.

Once a data agreement is updated, old data agreements is no longer published. The new data agreement supercedes the old one and is marked as published. **Version history** of the data agreement can be accessed by performing [**HTTP GET** http://travelcompany.swagger.localhost/data-agreements/version-history/{data_agreement_id}](http://travelcompany.swagger.localhost/api/doc#/Data%20Agreement%20-%20Core%20Functions/get_data_agreements_version_history__data_agreement_id_) by passing `data_agreement_id` as path parameter.

Data agreement can be deleted by performing [**HTTP DELETE** http://travelcompany.swagger.localhost/data-agreements/{data_agreement_id}](http://travelcompany.swagger.localhost/api/doc#/Data%20Agreement%20-%20Core%20Functions/delete_data_agreements__data_agreement_id_) by passing `data_agreement_id` as path parameter.


### 5.2.2 Data Agreement capture workflow (includes present proof by SSI)

#### 5.2.2.1 Establish connection between Travel Company and the Individual


1. Create invitation by Travel Company and send the invitation to the individual through OOB channel.

Perform [**HTTP POST** http://travelcompany.swagger.localhost/connections/create-invitation](http://travelcompany.swagger.localhost/api/doc#/connection/post_connections_create_invitation). Sample response is given below.

```json
{
  "connection_id": "e5f10204-1167-4d08-9095-8a69aae2c5de",
  "invitation": {
    "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/connections/1.0/invitation",
    "@id": "60458ecf-d531-4c30-9a0f-ebcb2bd5772a",
    "recipientKeys": [
      "B1Z24o23Aynmnrvaj9AAvdhnwXHCpqoY8REapwu4Habq"
    ],
    "serviceEndpoint": "http://travelcompany.localhost",
    "label": "Travel-Company"
  },
  "invitation_url": "http://travelcompany.localhost?c_i=eyJAdHlwZSI6ICJkaWQ6c292OkJ6Q2JzTlloTXJqSGlxWkRUVUFTSGc7c3BlYy9jb25uZWN0aW9ucy8xLjAvaW52aXRhdGlvbiIsICJAaWQiOiAiNjA0NThlY2YtZDUzMS00YzMwLTlhMGYtZWJjYjJiZDU3NzJhIiwgInJlY2lwaWVudEtleXMiOiBbIkIxWjI0bzIzQXlubW5ydmFqOUFBdmRobndYSENwcW9ZOFJFYXB3dTRIYWJxIl0sICJzZXJ2aWNlRW5kcG9pbnQiOiAiaHR0cDovL3RyYXZlbGNvbXBhbnkubG9jYWxob3N0IiwgImxhYmVsIjogIlRyYXZlbC1Db21wYW55In0="
}
```

Send the content of `invitation` to the individual through out-of-band means.

2. Receive a new connection invitation from the Travel Company by the Individual.

Receive a new connection invitation by copying the invitation from response in step 1 and passing it as request body to [**HTTP POST** http://individual.swagger.localhost/connections/receive-invitation](http://individual.swagger.localhost/api/doc#/connection/post_connections_receive_invitation). Sample response is given below.

```json
{
  "created_at": "2021-12-23 05:42:12.005848Z",
  "routing_state": "none",
  "their_label": "Travel-Company",
  "connection_id": "efa8c7f2-33fc-43e3-8a02-801ba6eca6ae",
  "invitation_key": "B1Z24o23Aynmnrvaj9AAvdhnwXHCpqoY8REapwu4Habq",
  "invitation_mode": "once",
  "state": "invitation",
  "initiator": "external",
  "accept": "manual",
  "updated_at": "2021-12-23 05:42:12.005848Z"
}
```

3. Accept received connection invitation by Individual.

Perform [**HTTP POST** http://individual.swagger.localhost/connections/{conn_id}/accept-invitation](http://individual.swagger.localhost/api/doc#/connection/post_connections__conn_id__accept_invitation) by passing `connection_id` from the above response. Sample response is given below.

```json
{
  "created_at": "2021-12-23 05:42:12.005848Z",
  "routing_state": "none",
  "request_id": "865dea5b-521a-4507-b8ac-b96ffa5066f6",
  "their_label": "Travel-Company",
  "connection_id": "efa8c7f2-33fc-43e3-8a02-801ba6eca6ae",
  "invitation_key": "B1Z24o23Aynmnrvaj9AAvdhnwXHCpqoY8REapwu4Habq",
  "invitation_mode": "once",
  "state": "request",
  "initiator": "external",
  "accept": "manual",
  "updated_at": "2021-12-23 05:42:44.348470Z",
  "my_did": "DFvRJLm4Rzqv5wiREfePfQ"
}
```

#### 5.2.2.2 Travel Company sends proof presentation request to the Individual

Perform [**HTTP POST** http://travelcompany.swagger.localhost/present-proof/data-agreement-negotiation/offer](http://travelcompany.swagger.localhost/api/doc#/present-proof/post_present_proof_data_agreement_negotiation_offer)

Sample request body is given below.

```json
{
  "connection_id": "e5f10204-1167-4d08-9095-8a69aae2c5de",
  "data_agreement_id": "8f9878b0-cb20-4ed6-be5f-b2ef1531a13c"
}
```

- `connection_id`: `connection_id` from the response of [Section 5.2.2.1 Step 1](#5221-establish-connection-between-travel-company-and-the-individual)
- `data_agreement_id`: `data_agreement_id` from the response of [Section 5.2.1 Step 3](#521-data-agreement-definition-and-preparation-workflow)


Present proof data agreement negotiation offer API might take some time to execute, since it is preparing the data agreement by generating the Linked Data Proofs. This process involves resolving the context in real time over the internet.

Sample response is given below.

```json
{
  "data_agreement": {
    "@context": [
      "https://raw.githubusercontent.com/decentralised-dataexchange/automated-data-agreements/main/interface-specs/data-agreement-schema/v1/data-agreement-schema-context.jsonld",
      "https://w3id.org/security/v2"
    ],
    "id": "cc3144bc-3f6c-475e-9fbc-8d1813109315",
    "version": 1,
    "template_id": "8f9878b0-cb20-4ed6-be5f-b2ef1531a13c",
    "template_version": 1,
    "data_controller_name": "Travel Company AB",
    "data_controller_url": "https://www.travelcompany.se",
    "purpose": "Verification of Covid-19 Test Results",
    "purpose_description": "Perform verification of Covid-19 Test Result to permit travel.",
    "lawful_basis": "consent",
    "method_of_use": "data-using-service",
    "data_policy": {
      "data_retention_period": 365,
      "policy_URL": "https://travelcompany.se/privacy-policy/",
      "jurisdiction": "Sweden",
      "industry_sector": "Travel",
      "geographic_restriction": "Europe",
      "storage_location": "Europe"
    },
    "personal_data": [
      {
        "attribute_id": "996dcab0-4182-468b-a106-19de5068c572",
        "attribute_name": "Test Result",
        "attribute_sensitive": true,
        "attribute_category": "Health Certificate",
        "attribute_description": "Result of the Covid-19 Test conducted by the Test Center"
      },
      {
        "attribute_id": "3d6e27fe-847f-42e2-84e5-029df7e177e1",
        "attribute_name": "Beneficiary Name",
        "attribute_sensitive": true,
        "attribute_category": "Health Certificate",
        "attribute_description": "Full name of the individual"
      },
      {
        "attribute_id": "4605e8c9-fcd4-43a9-91e3-b4762127c4e8",
        "attribute_name": "Certificate Issuer",
        "attribute_sensitive": true,
        "attribute_category": "Health Certificate",
        "attribute_description": "The issuer of the certificate, e.g. Swedish e-Health Agency"
      }
    ],
    "event": [
      {
        "id": "did:mydata:z6Mkozm5hY7naS4NyQGZpCwHkPdMkBi5m4ctLgbFcDBssnPf#1",
        "time_stamp": "2021-12-23T06:00:06.787688+00:00",
        "did": "did:mydata:z6Mkozm5hY7naS4NyQGZpCwHkPdMkBi5m4ctLgbFcDBssnPf",
        "state": "offer"
      }
    ],
    "proof": {
      "id": "did:mydata:z6Mkozm5hY7naS4NyQGZpCwHkPdMkBi5m4ctLgbFcDBssnPf#1",
      "type": "Ed25519Signature2018",
      "created": "2021-12-23T06:00:06.789617+00:00",
      "verificationMethod": "did:mydata:z6Mkozm5hY7naS4NyQGZpCwHkPdMkBi5m4ctLgbFcDBssnPf",
      "proofPurpose": "contractAgreement",
      "proofValue": "eyJhbGciOiAiRWREU0EiLCAiYjY0IjogZmFsc2UsICJjcml0IjogWyJiNjQiXX0..aLs-Tr-pBhwg3qdLOvwjnWWcGishDu056T97LW-n9fVWwEWOk8ucyLNb2Wp4YxMrK_lH52ciKKZdG3ZCcyAhDg"
    },
    "data_subject_did": "did:mydata:z6Mkm8jfFXKuRhXeNg78naVkyGyWZ6LX8e9ujcWBsguLmpLi"
  },
  "presentation_exchange_id": "b8ae3baa-7a5f-4900-9560-9d0ac0e000b7",
  "initiator": "self",
  "auto_present": false,
  "updated_at": "2021-12-23 06:00:17.088397Z",
  "data_agreement_template_id": "8f9878b0-cb20-4ed6-be5f-b2ef1531a13c",
  "state": "request_sent",
  "thread_id": "9215a86f-ac2e-4a0b-a1f3-4bd05913e6da",
  "trace": false,
  "presentation_request_dict": {
    "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/present-proof/1.0/request-presentation",
    "@id": "9215a86f-ac2e-4a0b-a1f3-4bd05913e6da",
    "~data-agreement-context": {
      "message_type": "protocol",
      "message": {
        "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/data-agreement-negotiation/1.0/offer",
        "@id": "c12897e8-36f7-4cd2-b583-e0b835613b82",
        "to": "did:mydata:z6Mkm8jfFXKuRhXeNg78naVkyGyWZ6LX8e9ujcWBsguLmpLi",
        "from": "did:mydata:z6Mkozm5hY7naS4NyQGZpCwHkPdMkBi5m4ctLgbFcDBssnPf",
        "body": {
          "@context": [
            "https://raw.githubusercontent.com/decentralised-dataexchange/automated-data-agreements/main/interface-specs/data-agreement-schema/v1/data-agreement-schema-context.jsonld",
            "https://w3id.org/security/v2"
          ],
          "id": "cc3144bc-3f6c-475e-9fbc-8d1813109315",
          "version": 1,
          "template_id": "8f9878b0-cb20-4ed6-be5f-b2ef1531a13c",
          "template_version": 1,
          "data_controller_name": "Travel Company AB",
          "data_controller_url": "https://www.travelcompany.se",
          "purpose": "Verification of Covid-19 Test Results",
          "purpose_description": "Perform verification of Covid-19 Test Result to permit travel.",
          "lawful_basis": "consent",
          "method_of_use": "data-using-service",
          "data_policy": {
            "data_retention_period": 365,
            "policy_URL": "https://travelcompany.se/privacy-policy/",
            "jurisdiction": "Sweden",
            "industry_sector": "Travel",
            "geographic_restriction": "Europe",
            "storage_location": "Europe"
          },
          "personal_data": [
            {
              "attribute_id": "996dcab0-4182-468b-a106-19de5068c572",
              "attribute_name": "Test Result",
              "attribute_sensitive": true,
              "attribute_category": "Health Certificate",
              "attribute_description": "Result of the Covid-19 Test conducted by the Test Center"
            },
            {
              "attribute_id": "3d6e27fe-847f-42e2-84e5-029df7e177e1",
              "attribute_name": "Beneficiary Name",
              "attribute_sensitive": true,
              "attribute_category": "Health Certificate",
              "attribute_description": "Full name of the individual"
            },
            {
              "attribute_id": "4605e8c9-fcd4-43a9-91e3-b4762127c4e8",
              "attribute_name": "Certificate Issuer",
              "attribute_sensitive": true,
              "attribute_category": "Health Certificate",
              "attribute_description": "The issuer of the certificate, e.g. Swedish e-Health Agency"
            }
          ],
          "event": [
            {
              "id": "did:mydata:z6Mkozm5hY7naS4NyQGZpCwHkPdMkBi5m4ctLgbFcDBssnPf#1",
              "time_stamp": "2021-12-23T06:00:06.787688+00:00",
              "did": "did:mydata:z6Mkozm5hY7naS4NyQGZpCwHkPdMkBi5m4ctLgbFcDBssnPf",
              "state": "offer"
            }
          ],
          "proof": {
            "id": "did:mydata:z6Mkozm5hY7naS4NyQGZpCwHkPdMkBi5m4ctLgbFcDBssnPf#1",
            "type": "Ed25519Signature2018",
            "created": "2021-12-23T06:00:06.789617+00:00",
            "verificationMethod": "did:mydata:z6Mkozm5hY7naS4NyQGZpCwHkPdMkBi5m4ctLgbFcDBssnPf",
            "proofPurpose": "contractAgreement",
            "proofValue": "eyJhbGciOiAiRWREU0EiLCAiYjY0IjogZmFsc2UsICJjcml0IjogWyJiNjQiXX0..aLs-Tr-pBhwg3qdLOvwjnWWcGishDu056T97LW-n9fVWwEWOk8ucyLNb2Wp4YxMrK_lH52ciKKZdG3ZCcyAhDg"
          },
          "data_subject_did": "did:mydata:z6Mkm8jfFXKuRhXeNg78naVkyGyWZ6LX8e9ujcWBsguLmpLi"
        },
        "created_time": "1640239217"
      }
    },
    "comment": "Perform verification of Covid-19 Test Result to permit travel.",
    "request_presentations~attach": [
      {
        "@id": "libindy-request-presentation-0",
        "mime-type": "application/json",
        "data": {
          "base64": "eyJuYW1lIjogIlZlcmlmaWNhdGlvbiBvZiBDb3ZpZC0xOSBUZXN0IFJlc3VsdHMiLCAidmVyc2lvbiI6ICIxLjAuMCIsICJyZXF1ZXN0ZWRfYXR0cmlidXRlcyI6IHsiYWRkaXRpb25hbFByb3AxIjogeyJuYW1lIjogIlRlc3QgUmVzdWx0IiwgInJlc3RyaWN0aW9ucyI6IFt7ImNyZWRfZGVmX2lkIjogIjh6bjlpV3VaVWM4anN5NkJDWUs0MmI6MzpDTDo1NTpkZWZhdWx0IiwgInNjaGVtYV9pZCI6ICI4em45aVd1WlVjOGpzeTZCQ1lLNDJiOjI6Q292aWQxOSBUZXN0IFJlc3VsdHM6MS4wLjAifV19LCAiYWRkaXRpb25hbFByb3AyIjogeyJuYW1lIjogIkJlbmVmaWNpYXJ5IE5hbWUiLCAicmVzdHJpY3Rpb25zIjogW3siY3JlZF9kZWZfaWQiOiAiOHpuOWlXdVpVYzhqc3k2QkNZSzQyYjozOkNMOjU1OmRlZmF1bHQiLCAic2NoZW1hX2lkIjogIjh6bjlpV3VaVWM4anN5NkJDWUs0MmI6MjpDb3ZpZDE5IFRlc3QgUmVzdWx0czoxLjAuMCJ9XX0sICJhZGRpdGlvbmFsUHJvcDMiOiB7Im5hbWUiOiAiQ2VydGlmaWNhdGUgSXNzdWVyIiwgInJlc3RyaWN0aW9ucyI6IFt7ImNyZWRfZGVmX2lkIjogIjh6bjlpV3VaVWM4anN5NkJDWUs0MmI6MzpDTDo1NTpkZWZhdWx0IiwgInNjaGVtYV9pZCI6ICI4em45aVd1WlVjOGpzeTZCQ1lLNDJiOjI6Q292aWQxOSBUZXN0IFJlc3VsdHM6MS4wLjAifV19fSwgInJlcXVlc3RlZF9wcmVkaWNhdGVzIjoge30sICJub25jZSI6ICI5MzQ3MzkzOTA1NjA2NzU2ODk4MjkyODEifQ=="
        }
      }
    ]
  },
  "presentation_request": {
    "name": "Verification of Covid-19 Test Results",
    "version": "1.0.0",
    "requested_attributes": {
      "additionalProp1": {
        "name": "Test Result",
        "restrictions": [
          {
            "cred_def_id": "8zn9iWuZUc8jsy6BCYK42b:3:CL:55:default",
            "schema_id": "8zn9iWuZUc8jsy6BCYK42b:2:Covid19 Test Results:1.0.0"
          }
        ]
      },
      "additionalProp2": {
        "name": "Beneficiary Name",
        "restrictions": [
          {
            "cred_def_id": "8zn9iWuZUc8jsy6BCYK42b:3:CL:55:default",
            "schema_id": "8zn9iWuZUc8jsy6BCYK42b:2:Covid19 Test Results:1.0.0"
          }
        ]
      },
      "additionalProp3": {
        "name": "Certificate Issuer",
        "restrictions": [
          {
            "cred_def_id": "8zn9iWuZUc8jsy6BCYK42b:3:CL:55:default",
            "schema_id": "8zn9iWuZUc8jsy6BCYK42b:2:Covid19 Test Results:1.0.0"
          }
        ]
      }
    },
    "requested_predicates": {},
    "nonce": "934739390560675689829281"
  },
  "data_agreement_id": "cc3144bc-3f6c-475e-9fbc-8d1813109315",
  "created_at": "2021-12-23 06:00:06.721461Z",
  "data_agreement_status": "offer",
  "connection_id": "e5f10204-1167-4d08-9095-8a69aae2c5de",
  "role": "verifier"
}
```

- `presentation_request_dict` - Contains the `present-proof/1.0/request-presentation` didcomm message send to the individual.
- `data_agreement_template_id` - Data agreement template identifier
- `data_agreement_id` - Data agreement instance identifer (Specific to the individual)
- `data_agreement_status` - Data agreement status
- `data_agreement` - Data agreement
- `thread_id` - Thread identifier (Parent didcomm message identifier)
- `presentation_exchange_id` - Presentation exchange record identifier


#### 5.2.2.3 Individual receives the proof presentation request

In a practical implementation, when the individual receives the proof presentation request, a notification is shown in the UI. 

For the sake of simplicity, the individual can query the proof presentation request by using the `data_agreement_id` (data agreement **instance** identifier) from response [above](#5222-travel-company-sends-proof-presentation-request-to-the-individual).

Query the proof presentation request by performing [**HTTP GET** http://individual.swagger.localhost/present-proof/records?data_agreement_id={data_agreement_id}](http://individual.swagger.localhost/api/doc#/present-proof/get_present_proof_records) by passing data_agreement_id as query parameter.

Sample response is given below.

```json
{
  "results": [
    {
      "trace": false,
      "connection_id": "efa8c7f2-33fc-43e3-8a02-801ba6eca6ae",
      "updated_at": "2021-12-23 06:00:26.096585Z",
      "data_agreement": {
        "@context": [
          "https://raw.githubusercontent.com/decentralised-dataexchange/automated-data-agreements/main/interface-specs/data-agreement-schema/v1/data-agreement-schema-context.jsonld",
          "https://w3id.org/security/v2"
        ],
        "id": "cc3144bc-3f6c-475e-9fbc-8d1813109315",
        "version": 1,
        "template_id": "8f9878b0-cb20-4ed6-be5f-b2ef1531a13c",
        "template_version": 1,
        "data_controller_name": "Travel Company AB",
        "data_controller_url": "https://www.travelcompany.se",
        "purpose": "Verification of Covid-19 Test Results",
        "purpose_description": "Perform verification of Covid-19 Test Result to permit travel.",
        "lawful_basis": "consent",
        "method_of_use": "data-using-service",
        "data_policy": {
          "data_retention_period": 365,
          "policy_URL": "https://travelcompany.se/privacy-policy/",
          "jurisdiction": "Sweden",
          "industry_sector": "Travel",
          "geographic_restriction": "Europe",
          "storage_location": "Europe"
        },
        "personal_data": [
          {
            "attribute_id": "996dcab0-4182-468b-a106-19de5068c572",
            "attribute_name": "Test Result",
            "attribute_sensitive": true,
            "attribute_category": "Health Certificate",
            "attribute_description": "Result of the Covid-19 Test conducted by the Test Center"
          },
          {
            "attribute_id": "3d6e27fe-847f-42e2-84e5-029df7e177e1",
            "attribute_name": "Beneficiary Name",
            "attribute_sensitive": true,
            "attribute_category": "Health Certificate",
            "attribute_description": "Full name of the individual"
          },
          {
            "attribute_id": "4605e8c9-fcd4-43a9-91e3-b4762127c4e8",
            "attribute_name": "Certificate Issuer",
            "attribute_sensitive": true,
            "attribute_category": "Health Certificate",
            "attribute_description": "The issuer of the certificate, e.g. Swedish e-Health Agency"
          }
        ],
        "event": [
          {
            "id": "did:mydata:z6Mkozm5hY7naS4NyQGZpCwHkPdMkBi5m4ctLgbFcDBssnPf#1",
            "time_stamp": "2021-12-23T06:00:06.787688+00:00",
            "did": "did:mydata:z6Mkozm5hY7naS4NyQGZpCwHkPdMkBi5m4ctLgbFcDBssnPf",
            "state": "offer"
          }
        ],
        "proof": {
          "id": "did:mydata:z6Mkozm5hY7naS4NyQGZpCwHkPdMkBi5m4ctLgbFcDBssnPf#1",
          "type": "Ed25519Signature2018",
          "created": "2021-12-23T06:00:06.789617+00:00",
          "verificationMethod": "did:mydata:z6Mkozm5hY7naS4NyQGZpCwHkPdMkBi5m4ctLgbFcDBssnPf",
          "proofPurpose": "contractAgreement",
          "proofValue": "eyJhbGciOiAiRWREU0EiLCAiYjY0IjogZmFsc2UsICJjcml0IjogWyJiNjQiXX0..aLs-Tr-pBhwg3qdLOvwjnWWcGishDu056T97LW-n9fVWwEWOk8ucyLNb2Wp4YxMrK_lH52ciKKZdG3ZCcyAhDg"
        },
        "data_subject_did": "did:mydata:z6Mkm8jfFXKuRhXeNg78naVkyGyWZ6LX8e9ujcWBsguLmpLi"
      },
      "thread_id": "9215a86f-ac2e-4a0b-a1f3-4bd05913e6da",
      "created_at": "2021-12-23 06:00:17.303605Z",
      "presentation_request": {
        "name": "Verification of Covid-19 Test Results",
        "version": "1.0.0",
        "requested_attributes": {
          "additionalProp1": {
            "name": "Test Result",
            "restrictions": [
              {
                "cred_def_id": "8zn9iWuZUc8jsy6BCYK42b:3:CL:55:default",
                "schema_id": "8zn9iWuZUc8jsy6BCYK42b:2:Covid19 Test Results:1.0.0"
              }
            ]
          },
          "additionalProp2": {
            "name": "Beneficiary Name",
            "restrictions": [
              {
                "cred_def_id": "8zn9iWuZUc8jsy6BCYK42b:3:CL:55:default",
                "schema_id": "8zn9iWuZUc8jsy6BCYK42b:2:Covid19 Test Results:1.0.0"
              }
            ]
          },
          "additionalProp3": {
            "name": "Certificate Issuer",
            "restrictions": [
              {
                "cred_def_id": "8zn9iWuZUc8jsy6BCYK42b:3:CL:55:default",
                "schema_id": "8zn9iWuZUc8jsy6BCYK42b:2:Covid19 Test Results:1.0.0"
              }
            ]
          }
        },
        "requested_predicates": {},
        "nonce": "934739390560675689829281"
      },
      "initiator": "external",
      "data_agreement_id": "cc3144bc-3f6c-475e-9fbc-8d1813109315",
      "data_agreement_template_id": "8f9878b0-cb20-4ed6-be5f-b2ef1531a13c",
      "presentation_exchange_id": "bb667a30-e2c3-425c-a922-e519d60b401b",
      "role": "prover",
      "state": "request_received",
      "data_agreement_status": "offer"
    }
  ]
}
```

- `data_agreement_template_id` - Data agreement template identifier
- `data_agreement_id` - Data agreement instance identifer (Specific to the individual)
- `data_agreement_status` - Data agreement status
- `data_agreement` - Data agreement
- `thread_id` - Thread identifier (Parent didcomm message identifier)
- `presentation_exchange_id` - Presentation exchange record identifier (data exchange record identifier)

Individual can decide to accept or reject the proof presentation request by inspecting the request data and data agreement associated with it.

Individual can query the data agreement associated with a data exchange by `presentation_exchange_id`. Perform [**HTTP GET** http://individual.swagger.localhost/data-agreement-instances?data_exchange_record_id={data_exchange_record_id}](http://individual.swagger.localhost/api/doc#/Data%20Agreement%20-%20Core%20Functions/get_data_agreement_instances) by passing the `data_exchange_record_id` as query parameter.

Sample response is given below.

```json
{
  "results": [
    {
      "data_exchange_record_id": "bb667a30-e2c3-425c-a922-e519d60b401b",
      "data_agreement": {
        "@context": [
          "https://raw.githubusercontent.com/decentralised-dataexchange/automated-data-agreements/main/interface-specs/data-agreement-schema/v1/data-agreement-schema-context.jsonld",
          "https://w3id.org/security/v2"
        ],
        "id": "cc3144bc-3f6c-475e-9fbc-8d1813109315",
        "version": 1,
        "template_id": "8f9878b0-cb20-4ed6-be5f-b2ef1531a13c",
        "template_version": 1,
        "data_controller_name": "Travel Company AB",
        "data_controller_url": "https://www.travelcompany.se",
        "purpose": "Verification of Covid-19 Test Results",
        "purpose_description": "Perform verification of Covid-19 Test Result to permit travel.",
        "lawful_basis": "consent",
        "method_of_use": "data-using-service",
        "data_policy": {
          "data_retention_period": 365,
          "policy_URL": "https://travelcompany.se/privacy-policy/",
          "jurisdiction": "Sweden",
          "industry_sector": "Travel",
          "geographic_restriction": "Europe",
          "storage_location": "Europe"
        },
        "personal_data": [
          {
            "attribute_id": "996dcab0-4182-468b-a106-19de5068c572",
            "attribute_name": "Test Result",
            "attribute_sensitive": true,
            "attribute_category": "Health Certificate",
            "attribute_description": "Result of the Covid-19 Test conducted by the Test Center"
          },
          {
            "attribute_id": "3d6e27fe-847f-42e2-84e5-029df7e177e1",
            "attribute_name": "Beneficiary Name",
            "attribute_sensitive": true,
            "attribute_category": "Health Certificate",
            "attribute_description": "Full name of the individual"
          },
          {
            "attribute_id": "4605e8c9-fcd4-43a9-91e3-b4762127c4e8",
            "attribute_name": "Certificate Issuer",
            "attribute_sensitive": true,
            "attribute_category": "Health Certificate",
            "attribute_description": "The issuer of the certificate, e.g. Swedish e-Health Agency"
          }
        ],
        "event": [
          {
            "id": "did:mydata:z6Mkozm5hY7naS4NyQGZpCwHkPdMkBi5m4ctLgbFcDBssnPf#1",
            "time_stamp": "2021-12-23T06:00:06.787688+00:00",
            "did": "did:mydata:z6Mkozm5hY7naS4NyQGZpCwHkPdMkBi5m4ctLgbFcDBssnPf",
            "state": "offer"
          }
        ],
        "data_subject_did": "did:mydata:z6Mkm8jfFXKuRhXeNg78naVkyGyWZ6LX8e9ujcWBsguLmpLi",
        "proof": {
          "id": "did:mydata:z6Mkozm5hY7naS4NyQGZpCwHkPdMkBi5m4ctLgbFcDBssnPf#1",
          "type": "Ed25519Signature2018",
          "created": "2021-12-23T06:00:06.789617+00:00",
          "verificationMethod": "did:mydata:z6Mkozm5hY7naS4NyQGZpCwHkPdMkBi5m4ctLgbFcDBssnPf",
          "proofPurpose": "contractAgreement",
          "proofValue": "eyJhbGciOiAiRWREU0EiLCAiYjY0IjogZmFsc2UsICJjcml0IjogWyJiNjQiXX0..aLs-Tr-pBhwg3qdLOvwjnWWcGishDu056T97LW-n9fVWwEWOk8ucyLNb2Wp4YxMrK_lH52ciKKZdG3ZCcyAhDg"
        }
      }
    }
  ]
}
```

The above data agreement contains offer event and it's proof.

#### 5.2.2.4 Individual rejects the data agreement

Individual decided to reject the data agreement.

Perform [**HTTP POST** http://individual.swagger.localhost/present-proof/records/{pres_ex_id}/data-agreement-negotiation/reject](http://individual.swagger.localhost/api/doc#/present-proof/post_present_proof_records__pres_ex_id__data_agreement_negotiation_reject) by passing the `pres_ex_id` as path parameter. 

After rejection, individual can query the data agreement to see the `reject` event and it's proof updated. 

Individual can query the data agreement associated with a data exchange by `presentation_exchange_id`. Perform [**HTTP GET** http://individual.swagger.localhost/data-agreement-instances?data_exchange_record_id={data_exchange_record_id}](http://individual.swagger.localhost/api/doc#/Data%20Agreement%20-%20Core%20Functions/get_data_agreement_instances) by passing the `data_exchange_record_id` (i.e. `presentation_exchange_id`) as query parameter. 



Sample response is given below.

```json
{
  "results": [
    {
      "data_exchange_record_id": "bb667a30-e2c3-425c-a922-e519d60b401b",
      "data_agreement": {
        "@context": [
          "https://raw.githubusercontent.com/decentralised-dataexchange/automated-data-agreements/main/interface-specs/data-agreement-schema/v1/data-agreement-schema-context.jsonld",
          "https://w3id.org/security/v2"
        ],
        "id": "cc3144bc-3f6c-475e-9fbc-8d1813109315",
        "version": 1,
        "template_id": "8f9878b0-cb20-4ed6-be5f-b2ef1531a13c",
        "template_version": 1,
        "data_controller_name": "Travel Company AB",
        "data_controller_url": "https://www.travelcompany.se",
        "purpose": "Verification of Covid-19 Test Results",
        "purpose_description": "Perform verification of Covid-19 Test Result to permit travel.",
        "lawful_basis": "consent",
        "method_of_use": "data-using-service",
        "data_policy": {
          "data_retention_period": 365,
          "policy_URL": "https://travelcompany.se/privacy-policy/",
          "jurisdiction": "Sweden",
          "industry_sector": "Travel",
          "geographic_restriction": "Europe",
          "storage_location": "Europe"
        },
        "personal_data": [
          {
            "attribute_id": "996dcab0-4182-468b-a106-19de5068c572",
            "attribute_name": "Test Result",
            "attribute_sensitive": true,
            "attribute_category": "Health Certificate",
            "attribute_description": "Result of the Covid-19 Test conducted by the Test Center"
          },
          {
            "attribute_id": "3d6e27fe-847f-42e2-84e5-029df7e177e1",
            "attribute_name": "Beneficiary Name",
            "attribute_sensitive": true,
            "attribute_category": "Health Certificate",
            "attribute_description": "Full name of the individual"
          },
          {
            "attribute_id": "4605e8c9-fcd4-43a9-91e3-b4762127c4e8",
            "attribute_name": "Certificate Issuer",
            "attribute_sensitive": true,
            "attribute_category": "Health Certificate",
            "attribute_description": "The issuer of the certificate, e.g. Swedish e-Health Agency"
          }
        ],
        "event": [
          {
            "id": "did:mydata:z6Mkozm5hY7naS4NyQGZpCwHkPdMkBi5m4ctLgbFcDBssnPf#1",
            "time_stamp": "2021-12-23T06:00:06.787688+00:00",
            "did": "did:mydata:z6Mkozm5hY7naS4NyQGZpCwHkPdMkBi5m4ctLgbFcDBssnPf",
            "state": "offer"
          },
          {
            "id": "did:mydata:z6Mkm8jfFXKuRhXeNg78naVkyGyWZ6LX8e9ujcWBsguLmpLi#2",
            "time_stamp": "2021-12-23T06:24:20.561682+00:00",
            "did": "did:mydata:z6Mkm8jfFXKuRhXeNg78naVkyGyWZ6LX8e9ujcWBsguLmpLi",
            "state": "reject"
          }
        ],
        "proofChain": [
          {
            "id": "did:mydata:z6Mkozm5hY7naS4NyQGZpCwHkPdMkBi5m4ctLgbFcDBssnPf#1",
            "type": "Ed25519Signature2018",
            "created": "2021-12-23T06:00:06.789617+00:00",
            "verificationMethod": "did:mydata:z6Mkozm5hY7naS4NyQGZpCwHkPdMkBi5m4ctLgbFcDBssnPf",
            "proofPurpose": "contractAgreement",
            "proofValue": "eyJhbGciOiAiRWREU0EiLCAiYjY0IjogZmFsc2UsICJjcml0IjogWyJiNjQiXX0..aLs-Tr-pBhwg3qdLOvwjnWWcGishDu056T97LW-n9fVWwEWOk8ucyLNb2Wp4YxMrK_lH52ciKKZdG3ZCcyAhDg"
          },
          {
            "id": "did:mydata:z6Mkm8jfFXKuRhXeNg78naVkyGyWZ6LX8e9ujcWBsguLmpLi#2",
            "type": "Ed25519Signature2018",
            "created": "2021-12-23T06:24:20.563360+00:00",
            "verificationMethod": "did:mydata:z6Mkm8jfFXKuRhXeNg78naVkyGyWZ6LX8e9ujcWBsguLmpLi",
            "proofPurpose": "contractAgreement",
            "proofValue": "eyJhbGciOiAiRWREU0EiLCAiYjY0IjogZmFsc2UsICJjcml0IjogWyJiNjQiXX0..lyGouLxJkhfUY53bSrjl5jy6cT9HrXJ7uKsyLmRPr6F7EGIKIHND7IXBrkuby8MgFnoTo5axZKiSweaB3S2ACQ"
          }
        ],
        "data_subject_did": "did:mydata:z6Mkm8jfFXKuRhXeNg78naVkyGyWZ6LX8e9ujcWBsguLmpLi"
      }
    }
  ]
}
```

The above data agreement contains `reject` event and it's proof.


#### 5.2.2.5 Individual accepts the data agreement

Accepting data agreeement would mean Individual is ready to present the data for the attributes requested by Travel Company. Individual should send `present-proof/1.0/presentation` message to the Travel Company.

1. In order for the individual to send presentation for the requested attributes, individual should check if requested data is available in the wallet.

Perform [**HTTP GET** http://individual.swagger.localhost/credentials](http://individual.swagger.localhost/api/doc#/credentials/get_credentials) to query the stored credentials in the wallet.

Sample response is given below.

```json
{
  "results": [
    {
      "referent": "97b9dacb-31c0-40cf-b98f-3c4349db3855",
      "attrs": {
        "Test Result": "Negative",
        "Beneficiary Name": "Alice",
        "Certificate Issuer": "Swedish e-Health Agency"
      },
      "schema_id": "8zn9iWuZUc8jsy6BCYK42b:2:Covid19 Test Results:1.0.0",
      "cred_def_id": "8zn9iWuZUc8jsy6BCYK42b:3:CL:55:default",
      "rev_reg_id": null,
      "cred_rev_id": null
    }
  ]
}
```

- `referent` - Unique identifier of the credential.
- `attrs` - Attributes of the credential.
- `schema_id` - Schema identifier of the credential.
- `cred_def_id` - Credential definition identifier of the credential.

2. Perform [**HTTP POST** http://individual.swagger.localhost/present-proof/records/{pres_ex_id}/send-presentation](http://individual.swagger.localhost/api/doc#/present-proof/post_present_proof_records__pres_ex_id__send_presentation) by passing the `pres_ex_id` as path parameter to present requested data to Travel Company.

Request body for the above API call needs to be constructed in accordance to the `presentation_request` in [Section 5.2.2.3](#5223-individual-receives-the-proof-presentation-request).

Sample request body is given below.

```json
{
  "requested_attributes": {
    "additionalProp1": {
      "cred_id": "97b9dacb-31c0-40cf-b98f-3c4349db3855",
      "revealed": true
    },
    "additionalProp2": {
      "cred_id": "97b9dacb-31c0-40cf-b98f-3c4349db3855",
      "revealed": true
    },
    "additionalProp3": {
      "cred_id": "97b9dacb-31c0-40cf-b98f-3c4349db3855",
      "revealed": true
    }
  },
  "requested_predicates": {},
  "self_attested_attributes": {},
  "trace": false
}
```

Sample response is given below.

```json
{
  "trace": false,
  "data_agreement_id": "cb8ca19c-eedd-4786-8d58-c119bcf487b9",
  "data_agreement_status": "accept",
  "thread_id": "6b63777c-8087-457b-a5ad-de9c75aaddac",
  "presentation_exchange_id": "08371fc1-7126-4bdd-a823-a56170dbcb78",
  "presentation": {
    "proof": {
      "proofs": [
        {
          "primary_proof": {
            "eq_proof": {
              "revealed_attrs": {
                "beneficiaryname": "27034640024117331033063128044004318218486816931520886405535659934417438781507",
                "certificateissuer": "99683496033783611638382324975402674369943801867037982636612083044855762796670",
                "testresult": "72136574741428928453961258731671019611255086403640189708094101439611854020200"
              },
              "a_prime": "4361798215807883793949338997448807465531315789042427077302107235080925309130001203624083272688506198616041084577764746747526694428508580011853969769115965146688889091171775965605482166237495294210928031867123450861431839647613862799330044153974766151656696243263685381151992844333830763205935862014322367872410284282017951119652149264745609808305369953214055403472803483361421682914051318596169646000910636257685694335514813048972422393941883190240189105351083059423905439738770592468997678511968818870358688139801652773161303683526496999142024316721486629547875037628223836901351711367135635257220829859965430850316",
              "e": "154880940351965718789829765499300004388448509848785863484782908417841193933267103795094666218153010711141176494163786991320957636238132306",
              "v": "558790000685715198532709642387206740915113727138276381286221605357033482504361242497822115863636332688414547463864452694859970250542508311420276790014104370735219499439128629781531828942029563974911220687738967735811339948331848152658890557306996883706977441357509563886495499448421370688652035826863304901534878616087054958193767968911405832643623990501605109277674538346843658002718045268232785205576187396099355224988149149171348924949907671665094465568470280360456581529384367519081615188680876623058776481218066635580702083269473281699884433690416421599565419638273603910328880159869550719547614877499195875909272425931191398376755577622652237083156301175215799427143910035778578581291739520184095871399553467188593899658360493398887555882133576093476193265188108656095586699800801303052988327706957534495908155114336404080655296205977957577799786666777040334407974474005852823094795446240239932824848089565760059346",
              "m": {
                "master_secret": "10371552000802645071540055081669719223059913988577983531200428572955277990631830976471479524603231450096421327393092677961969644774873150745074202477798221195536387914835856732478"
              },
              "m2": "771605672603551010733085757364074741005844505729722426674801686319204086925597502222150485155902756902894509048693734886924619263883434696794790243002721675470347155734894744769"
            },
            "ge_proofs": []
          },
          "non_revoc_proof": null
        }
      ],
      "aggregated_proof": {
        "c_hash": "99077910753389871836833072976822635364693563100374798145866223383848811796781",
        "c_list": [
          [
            34,
            141,
            86,
            66,
            67,
            178,
            63,
            121,
            111,
            84,
            103,
            16,
            205,
            80,
            186,
            200,
            129,
            41,
            46,
            18,
            0,
            199,
            240,
            242,
            46,
            11,
            139,
            16,
            61,
            191,
            112,
            127,
            230,
            123,
            27,
            160,
            167,
            9,
            211,
            61,
            33,
            82,
            244,
            95,
            83,
            148,
            2,
            100,
            245,
            226,
            241,
            135,
            247,
            126,
            199,
            21,
            173,
            187,
            198,
            190,
            112,
            229,
            162,
            17,
            240,
            137,
            58,
            86,
            78,
            80,
            152,
            212,
            43,
            152,
            119,
            212,
            208,
            253,
            172,
            181,
            232,
            49,
            47,
            73,
            77,
            230,
            228,
            89,
            36,
            176,
            1,
            52,
            140,
            246,
            96,
            228,
            19,
            109,
            129,
            154,
            103,
            93,
            96,
            180,
            13,
            199,
            11,
            116,
            176,
            18,
            52,
            114,
            236,
            146,
            243,
            188,
            219,
            162,
            237,
            212,
            93,
            129,
            48,
            151,
            66,
            3,
            78,
            82,
            134,
            165,
            123,
            4,
            70,
            114,
            166,
            136,
            57,
            66,
            157,
            157,
            25,
            106,
            152,
            55,
            68,
            130,
            194,
            180,
            98,
            223,
            58,
            227,
            84,
            221,
            19,
            194,
            252,
            98,
            249,
            198,
            117,
            113,
            228,
            175,
            81,
            248,
            18,
            161,
            14,
            235,
            178,
            207,
            51,
            165,
            206,
            176,
            216,
            73,
            17,
            4,
            119,
            221,
            11,
            141,
            167,
            135,
            233,
            251,
            95,
            156,
            31,
            234,
            52,
            148,
            114,
            69,
            197,
            53,
            166,
            229,
            140,
            184,
            14,
            239,
            204,
            80,
            43,
            113,
            10,
            50,
            164,
            81,
            169,
            102,
            198,
            177,
            110,
            230,
            149,
            139,
            0,
            18,
            128,
            190,
            67,
            174,
            245,
            193,
            47,
            206,
            53,
            239,
            115,
            150,
            8,
            155,
            103,
            70,
            239,
            155,
            217,
            34,
            67,
            125,
            82,
            180,
            161,
            69,
            219,
            114,
            11,
            218,
            176,
            98,
            227,
            12
          ]
        ]
      }
    },
    "requested_proof": {
      "revealed_attrs": {
        "additionalProp1": {
          "sub_proof_index": 0,
          "raw": "Negative",
          "encoded": "72136574741428928453961258731671019611255086403640189708094101439611854020200"
        },
        "additionalProp2": {
          "sub_proof_index": 0,
          "raw": "Alice",
          "encoded": "27034640024117331033063128044004318218486816931520886405535659934417438781507"
        },
        "additionalProp3": {
          "sub_proof_index": 0,
          "raw": "Swedish e-Health Agency",
          "encoded": "99683496033783611638382324975402674369943801867037982636612083044855762796670"
        }
      },
      "self_attested_attrs": {},
      "unrevealed_attrs": {},
      "predicates": {}
    },
    "identifiers": [
      {
        "schema_id": "8zn9iWuZUc8jsy6BCYK42b:2:Covid19 Test Results:1.0.0",
        "cred_def_id": "8zn9iWuZUc8jsy6BCYK42b:3:CL:55:default",
        "rev_reg_id": null,
        "timestamp": null
      }
    ]
  },
  "role": "prover",
  "data_agreement_template_id": "8f9878b0-cb20-4ed6-be5f-b2ef1531a13c",
  "created_at": "2021-12-23 06:27:22.694505Z",
  "connection_id": "efa8c7f2-33fc-43e3-8a02-801ba6eca6ae",
  "presentation_request": {
    "name": "Verification of Covid-19 Test Results",
    "version": "1.0.0",
    "requested_attributes": {
      "additionalProp1": {
        "name": "Test Result",
        "restrictions": [
          {
            "cred_def_id": "8zn9iWuZUc8jsy6BCYK42b:3:CL:55:default",
            "schema_id": "8zn9iWuZUc8jsy6BCYK42b:2:Covid19 Test Results:1.0.0"
          }
        ]
      },
      "additionalProp2": {
        "name": "Beneficiary Name",
        "restrictions": [
          {
            "cred_def_id": "8zn9iWuZUc8jsy6BCYK42b:3:CL:55:default",
            "schema_id": "8zn9iWuZUc8jsy6BCYK42b:2:Covid19 Test Results:1.0.0"
          }
        ]
      },
      "additionalProp3": {
        "name": "Certificate Issuer",
        "restrictions": [
          {
            "cred_def_id": "8zn9iWuZUc8jsy6BCYK42b:3:CL:55:default",
            "schema_id": "8zn9iWuZUc8jsy6BCYK42b:2:Covid19 Test Results:1.0.0"
          }
        ]
      }
    },
    "requested_predicates": {},
    "nonce": "37342236124754233266452"
  },
  "state": "presentation_sent",
  "updated_at": "2021-12-23 07:05:42.125112Z",
  "initiator": "external",
  "data_agreement": {
    "@context": [
      "https://raw.githubusercontent.com/decentralised-dataexchange/automated-data-agreements/main/interface-specs/data-agreement-schema/v1/data-agreement-schema-context.jsonld",
      "https://w3id.org/security/v2"
    ],
    "id": "cb8ca19c-eedd-4786-8d58-c119bcf487b9",
    "version": 1,
    "template_id": "8f9878b0-cb20-4ed6-be5f-b2ef1531a13c",
    "template_version": 1,
    "data_controller_name": "Travel Company AB",
    "data_controller_url": "https://www.travelcompany.se",
    "purpose": "Verification of Covid-19 Test Results",
    "purpose_description": "Perform verification of Covid-19 Test Result to permit travel.",
    "lawful_basis": "consent",
    "method_of_use": "data-using-service",
    "data_policy": {
      "data_retention_period": 365,
      "policy_URL": "https://travelcompany.se/privacy-policy/",
      "jurisdiction": "Sweden",
      "industry_sector": "Travel",
      "geographic_restriction": "Europe",
      "storage_location": "Europe"
    },
    "personal_data": [
      {
        "attribute_id": "996dcab0-4182-468b-a106-19de5068c572",
        "attribute_name": "Test Result",
        "attribute_sensitive": true,
        "attribute_category": "Health Certificate",
        "attribute_description": "Result of the Covid-19 Test conducted by the Test Center"
      },
      {
        "attribute_id": "3d6e27fe-847f-42e2-84e5-029df7e177e1",
        "attribute_name": "Beneficiary Name",
        "attribute_sensitive": true,
        "attribute_category": "Health Certificate",
        "attribute_description": "Full name of the individual"
      },
      {
        "attribute_id": "4605e8c9-fcd4-43a9-91e3-b4762127c4e8",
        "attribute_name": "Certificate Issuer",
        "attribute_sensitive": true,
        "attribute_category": "Health Certificate",
        "attribute_description": "The issuer of the certificate, e.g. Swedish e-Health Agency"
      }
    ],
    "event": [
      {
        "id": "did:mydata:z6Mkozm5hY7naS4NyQGZpCwHkPdMkBi5m4ctLgbFcDBssnPf#1",
        "time_stamp": "2021-12-23T06:27:13.748472+00:00",
        "did": "did:mydata:z6Mkozm5hY7naS4NyQGZpCwHkPdMkBi5m4ctLgbFcDBssnPf",
        "state": "offer"
      },
      {
        "id": "did:mydata:z6Mkm8jfFXKuRhXeNg78naVkyGyWZ6LX8e9ujcWBsguLmpLi#2",
        "time_stamp": "2021-12-23T07:05:33.091309+00:00",
        "did": "did:mydata:z6Mkm8jfFXKuRhXeNg78naVkyGyWZ6LX8e9ujcWBsguLmpLi",
        "state": "accept"
      }
    ],
    "proofChain": [
      {
        "id": "did:mydata:z6Mkozm5hY7naS4NyQGZpCwHkPdMkBi5m4ctLgbFcDBssnPf#1",
        "type": "Ed25519Signature2018",
        "created": "2021-12-23T06:27:13.749999+00:00",
        "verificationMethod": "did:mydata:z6Mkozm5hY7naS4NyQGZpCwHkPdMkBi5m4ctLgbFcDBssnPf",
        "proofPurpose": "contractAgreement",
        "proofValue": "eyJhbGciOiAiRWREU0EiLCAiYjY0IjogZmFsc2UsICJjcml0IjogWyJiNjQiXX0..Z-Hqsq2R3j9yOxSydk8JxqK2dDtp1qB3stEmREmh_ubDED6UEtU_tXKS_m-2JIzquXCj8VJ0KGSF7pU8nJzvBw"
      },
      {
        "id": "did:mydata:z6Mkm8jfFXKuRhXeNg78naVkyGyWZ6LX8e9ujcWBsguLmpLi#2",
        "type": "Ed25519Signature2018",
        "created": "2021-12-23T07:05:33.093851+00:00",
        "verificationMethod": "did:mydata:z6Mkm8jfFXKuRhXeNg78naVkyGyWZ6LX8e9ujcWBsguLmpLi",
        "proofPurpose": "contractAgreement",
        "proofValue": "eyJhbGciOiAiRWREU0EiLCAiYjY0IjogZmFsc2UsICJjcml0IjogWyJiNjQiXX0..ieQivg6W_6UyVlwefxgcK7vYw16ZavR7Axaz1oWEUSyyCR4n-coTLQ27rAKICpvhDqmvE1kKaDi7ehgBs3aKBQ"
      }
    ],
    "data_subject_did": "did:mydata:z6Mkm8jfFXKuRhXeNg78naVkyGyWZ6LX8e9ujcWBsguLmpLi"
  }
}
```


After accepting, individual can query the data agreement to see the `accept` event and it's proof updated. 

Individual can query the data agreement associated with a data exchange by `presentation_exchange_id`. Perform [**HTTP GET** http://individual.swagger.localhost/data-agreement-instances?data_exchange_record_id={data_exchange_record_id}](http://individual.swagger.localhost/api/doc#/Data%20Agreement%20-%20Core%20Functions/get_data_agreement_instances) by passing the `data_exchange_record_id` as query parameter. 


A sample response is given below.

```json
{
  "results": [
    {
      "data_exchange_record_id": "08371fc1-7126-4bdd-a823-a56170dbcb78",
      "data_agreement": {
        "@context": [
          "https://raw.githubusercontent.com/decentralised-dataexchange/automated-data-agreements/main/interface-specs/data-agreement-schema/v1/data-agreement-schema-context.jsonld",
          "https://w3id.org/security/v2"
        ],
        "id": "cb8ca19c-eedd-4786-8d58-c119bcf487b9",
        "version": 1,
        "template_id": "8f9878b0-cb20-4ed6-be5f-b2ef1531a13c",
        "template_version": 1,
        "data_controller_name": "Travel Company AB",
        "data_controller_url": "https://www.travelcompany.se",
        "purpose": "Verification of Covid-19 Test Results",
        "purpose_description": "Perform verification of Covid-19 Test Result to permit travel.",
        "lawful_basis": "consent",
        "method_of_use": "data-using-service",
        "data_policy": {
          "data_retention_period": 365,
          "policy_URL": "https://travelcompany.se/privacy-policy/",
          "jurisdiction": "Sweden",
          "industry_sector": "Travel",
          "geographic_restriction": "Europe",
          "storage_location": "Europe"
        },
        "personal_data": [
          {
            "attribute_id": "996dcab0-4182-468b-a106-19de5068c572",
            "attribute_name": "Test Result",
            "attribute_sensitive": true,
            "attribute_category": "Health Certificate",
            "attribute_description": "Result of the Covid-19 Test conducted by the Test Center"
          },
          {
            "attribute_id": "3d6e27fe-847f-42e2-84e5-029df7e177e1",
            "attribute_name": "Beneficiary Name",
            "attribute_sensitive": true,
            "attribute_category": "Health Certificate",
            "attribute_description": "Full name of the individual"
          },
          {
            "attribute_id": "4605e8c9-fcd4-43a9-91e3-b4762127c4e8",
            "attribute_name": "Certificate Issuer",
            "attribute_sensitive": true,
            "attribute_category": "Health Certificate",
            "attribute_description": "The issuer of the certificate, e.g. Swedish e-Health Agency"
          }
        ],
        "event": [
          {
            "id": "did:mydata:z6Mkozm5hY7naS4NyQGZpCwHkPdMkBi5m4ctLgbFcDBssnPf#1",
            "time_stamp": "2021-12-23T06:27:13.748472+00:00",
            "did": "did:mydata:z6Mkozm5hY7naS4NyQGZpCwHkPdMkBi5m4ctLgbFcDBssnPf",
            "state": "offer"
          },
          {
            "id": "did:mydata:z6Mkm8jfFXKuRhXeNg78naVkyGyWZ6LX8e9ujcWBsguLmpLi#2",
            "time_stamp": "2021-12-23T07:05:33.091309+00:00",
            "did": "did:mydata:z6Mkm8jfFXKuRhXeNg78naVkyGyWZ6LX8e9ujcWBsguLmpLi",
            "state": "accept"
          }
        ],
        "proofChain": [
          {
            "id": "did:mydata:z6Mkozm5hY7naS4NyQGZpCwHkPdMkBi5m4ctLgbFcDBssnPf#1",
            "type": "Ed25519Signature2018",
            "created": "2021-12-23T06:27:13.749999+00:00",
            "verificationMethod": "did:mydata:z6Mkozm5hY7naS4NyQGZpCwHkPdMkBi5m4ctLgbFcDBssnPf",
            "proofPurpose": "contractAgreement",
            "proofValue": "eyJhbGciOiAiRWREU0EiLCAiYjY0IjogZmFsc2UsICJjcml0IjogWyJiNjQiXX0..Z-Hqsq2R3j9yOxSydk8JxqK2dDtp1qB3stEmREmh_ubDED6UEtU_tXKS_m-2JIzquXCj8VJ0KGSF7pU8nJzvBw"
          },
          {
            "id": "did:mydata:z6Mkm8jfFXKuRhXeNg78naVkyGyWZ6LX8e9ujcWBsguLmpLi#2",
            "type": "Ed25519Signature2018",
            "created": "2021-12-23T07:05:33.093851+00:00",
            "verificationMethod": "did:mydata:z6Mkm8jfFXKuRhXeNg78naVkyGyWZ6LX8e9ujcWBsguLmpLi",
            "proofPurpose": "contractAgreement",
            "proofValue": "eyJhbGciOiAiRWREU0EiLCAiYjY0IjogZmFsc2UsICJjcml0IjogWyJiNjQiXX0..ieQivg6W_6UyVlwefxgcK7vYw16ZavR7Axaz1oWEUSyyCR4n-coTLQ27rAKICpvhDqmvE1kKaDi7ehgBs3aKBQ"
          }
        ],
        "data_subject_did": "did:mydata:z6Mkm8jfFXKuRhXeNg78naVkyGyWZ6LX8e9ujcWBsguLmpLi"
      }
    }
  ]
}
```

The above data agreement contains `accept` event and it's proof.

### 5.2.3 Data Agreement terminate workflow

Individual can decide to terminate an accepted data agreement.

Perform [**HTTP POST** http://individual.swagger.localhost/present-proof/records/{pres_ex_id}/data-agreement-termination/terminate](http://individual.swagger.localhost/api/doc#/present-proof/post_present_proof_records__pres_ex_id__data_agreement_termination_terminate) by passing `pres_ex_id` as path parameter to terminate the data agreement associated with presentation exchange.

Sample response is given below.

```json
{
  "trace": false,
  "data_agreement_id": "cb8ca19c-eedd-4786-8d58-c119bcf487b9",
  "data_agreement_status": "terminate",
  "thread_id": "6b63777c-8087-457b-a5ad-de9c75aaddac",
  "presentation_exchange_id": "08371fc1-7126-4bdd-a823-a56170dbcb78",
  "presentation": {
    "proof": {
      "proofs": [
        {
          "primary_proof": {
            "eq_proof": {
              "revealed_attrs": {
                "beneficiaryname": "27034640024117331033063128044004318218486816931520886405535659934417438781507",
                "certificateissuer": "99683496033783611638382324975402674369943801867037982636612083044855762796670",
                "testresult": "72136574741428928453961258731671019611255086403640189708094101439611854020200"
              },
              "a_prime": "4361798215807883793949338997448807465531315789042427077302107235080925309130001203624083272688506198616041084577764746747526694428508580011853969769115965146688889091171775965605482166237495294210928031867123450861431839647613862799330044153974766151656696243263685381151992844333830763205935862014322367872410284282017951119652149264745609808305369953214055403472803483361421682914051318596169646000910636257685694335514813048972422393941883190240189105351083059423905439738770592468997678511968818870358688139801652773161303683526496999142024316721486629547875037628223836901351711367135635257220829859965430850316",
              "e": "154880940351965718789829765499300004388448509848785863484782908417841193933267103795094666218153010711141176494163786991320957636238132306",
              "v": "558790000685715198532709642387206740915113727138276381286221605357033482504361242497822115863636332688414547463864452694859970250542508311420276790014104370735219499439128629781531828942029563974911220687738967735811339948331848152658890557306996883706977441357509563886495499448421370688652035826863304901534878616087054958193767968911405832643623990501605109277674538346843658002718045268232785205576187396099355224988149149171348924949907671665094465568470280360456581529384367519081615188680876623058776481218066635580702083269473281699884433690416421599565419638273603910328880159869550719547614877499195875909272425931191398376755577622652237083156301175215799427143910035778578581291739520184095871399553467188593899658360493398887555882133576093476193265188108656095586699800801303052988327706957534495908155114336404080655296205977957577799786666777040334407974474005852823094795446240239932824848089565760059346",
              "m": {
                "master_secret": "10371552000802645071540055081669719223059913988577983531200428572955277990631830976471479524603231450096421327393092677961969644774873150745074202477798221195536387914835856732478"
              },
              "m2": "771605672603551010733085757364074741005844505729722426674801686319204086925597502222150485155902756902894509048693734886924619263883434696794790243002721675470347155734894744769"
            },
            "ge_proofs": []
          },
          "non_revoc_proof": null
        }
      ],
      "aggregated_proof": {
        "c_hash": "99077910753389871836833072976822635364693563100374798145866223383848811796781",
        "c_list": [
          [
            34,
            141,
            86,
            66,
            67,
            178,
            63,
            121,
            111,
            84,
            103,
            16,
            205,
            80,
            186,
            200,
            129,
            41,
            46,
            18,
            0,
            199,
            240,
            242,
            46,
            11,
            139,
            16,
            61,
            191,
            112,
            127,
            230,
            123,
            27,
            160,
            167,
            9,
            211,
            61,
            33,
            82,
            244,
            95,
            83,
            148,
            2,
            100,
            245,
            226,
            241,
            135,
            247,
            126,
            199,
            21,
            173,
            187,
            198,
            190,
            112,
            229,
            162,
            17,
            240,
            137,
            58,
            86,
            78,
            80,
            152,
            212,
            43,
            152,
            119,
            212,
            208,
            253,
            172,
            181,
            232,
            49,
            47,
            73,
            77,
            230,
            228,
            89,
            36,
            176,
            1,
            52,
            140,
            246,
            96,
            228,
            19,
            109,
            129,
            154,
            103,
            93,
            96,
            180,
            13,
            199,
            11,
            116,
            176,
            18,
            52,
            114,
            236,
            146,
            243,
            188,
            219,
            162,
            237,
            212,
            93,
            129,
            48,
            151,
            66,
            3,
            78,
            82,
            134,
            165,
            123,
            4,
            70,
            114,
            166,
            136,
            57,
            66,
            157,
            157,
            25,
            106,
            152,
            55,
            68,
            130,
            194,
            180,
            98,
            223,
            58,
            227,
            84,
            221,
            19,
            194,
            252,
            98,
            249,
            198,
            117,
            113,
            228,
            175,
            81,
            248,
            18,
            161,
            14,
            235,
            178,
            207,
            51,
            165,
            206,
            176,
            216,
            73,
            17,
            4,
            119,
            221,
            11,
            141,
            167,
            135,
            233,
            251,
            95,
            156,
            31,
            234,
            52,
            148,
            114,
            69,
            197,
            53,
            166,
            229,
            140,
            184,
            14,
            239,
            204,
            80,
            43,
            113,
            10,
            50,
            164,
            81,
            169,
            102,
            198,
            177,
            110,
            230,
            149,
            139,
            0,
            18,
            128,
            190,
            67,
            174,
            245,
            193,
            47,
            206,
            53,
            239,
            115,
            150,
            8,
            155,
            103,
            70,
            239,
            155,
            217,
            34,
            67,
            125,
            82,
            180,
            161,
            69,
            219,
            114,
            11,
            218,
            176,
            98,
            227,
            12
          ]
        ]
      }
    },
    "requested_proof": {
      "revealed_attrs": {
        "additionalProp1": {
          "sub_proof_index": 0,
          "raw": "Negative",
          "encoded": "72136574741428928453961258731671019611255086403640189708094101439611854020200"
        },
        "additionalProp2": {
          "sub_proof_index": 0,
          "raw": "Alice",
          "encoded": "27034640024117331033063128044004318218486816931520886405535659934417438781507"
        },
        "additionalProp3": {
          "sub_proof_index": 0,
          "raw": "Swedish e-Health Agency",
          "encoded": "99683496033783611638382324975402674369943801867037982636612083044855762796670"
        }
      },
      "self_attested_attrs": {},
      "unrevealed_attrs": {},
      "predicates": {}
    },
    "identifiers": [
      {
        "schema_id": "8zn9iWuZUc8jsy6BCYK42b:2:Covid19 Test Results:1.0.0",
        "cred_def_id": "8zn9iWuZUc8jsy6BCYK42b:3:CL:55:default",
        "rev_reg_id": null,
        "timestamp": null
      }
    ]
  },
  "role": "prover",
  "data_agreement_template_id": "8f9878b0-cb20-4ed6-be5f-b2ef1531a13c",
  "created_at": "2021-12-23 06:27:22.694505Z",
  "connection_id": "efa8c7f2-33fc-43e3-8a02-801ba6eca6ae",
  "presentation_request": {
    "name": "Verification of Covid-19 Test Results",
    "version": "1.0.0",
    "requested_attributes": {
      "additionalProp1": {
        "name": "Test Result",
        "restrictions": [
          {
            "cred_def_id": "8zn9iWuZUc8jsy6BCYK42b:3:CL:55:default",
            "schema_id": "8zn9iWuZUc8jsy6BCYK42b:2:Covid19 Test Results:1.0.0"
          }
        ]
      },
      "additionalProp2": {
        "name": "Beneficiary Name",
        "restrictions": [
          {
            "cred_def_id": "8zn9iWuZUc8jsy6BCYK42b:3:CL:55:default",
            "schema_id": "8zn9iWuZUc8jsy6BCYK42b:2:Covid19 Test Results:1.0.0"
          }
        ]
      },
      "additionalProp3": {
        "name": "Certificate Issuer",
        "restrictions": [
          {
            "cred_def_id": "8zn9iWuZUc8jsy6BCYK42b:3:CL:55:default",
            "schema_id": "8zn9iWuZUc8jsy6BCYK42b:2:Covid19 Test Results:1.0.0"
          }
        ]
      }
    },
    "requested_predicates": {},
    "nonce": "37342236124754233266452"
  },
  "state": "presentation_acked",
  "updated_at": "2021-12-23 07:24:07.282115Z",
  "initiator": "external",
  "data_agreement": {
    "@context": [
      "https://raw.githubusercontent.com/decentralised-dataexchange/automated-data-agreements/main/interface-specs/data-agreement-schema/v1/data-agreement-schema-context.jsonld",
      "https://w3id.org/security/v2"
    ],
    "id": "cb8ca19c-eedd-4786-8d58-c119bcf487b9",
    "version": 1,
    "template_id": "8f9878b0-cb20-4ed6-be5f-b2ef1531a13c",
    "template_version": 1,
    "data_controller_name": "Travel Company AB",
    "data_controller_url": "https://www.travelcompany.se",
    "purpose": "Verification of Covid-19 Test Results",
    "purpose_description": "Perform verification of Covid-19 Test Result to permit travel.",
    "lawful_basis": "consent",
    "method_of_use": "data-using-service",
    "data_policy": {
      "data_retention_period": 365,
      "policy_URL": "https://travelcompany.se/privacy-policy/",
      "jurisdiction": "Sweden",
      "industry_sector": "Travel",
      "geographic_restriction": "Europe",
      "storage_location": "Europe"
    },
    "personal_data": [
      {
        "attribute_id": "996dcab0-4182-468b-a106-19de5068c572",
        "attribute_name": "Test Result",
        "attribute_sensitive": true,
        "attribute_category": "Health Certificate",
        "attribute_description": "Result of the Covid-19 Test conducted by the Test Center"
      },
      {
        "attribute_id": "3d6e27fe-847f-42e2-84e5-029df7e177e1",
        "attribute_name": "Beneficiary Name",
        "attribute_sensitive": true,
        "attribute_category": "Health Certificate",
        "attribute_description": "Full name of the individual"
      },
      {
        "attribute_id": "4605e8c9-fcd4-43a9-91e3-b4762127c4e8",
        "attribute_name": "Certificate Issuer",
        "attribute_sensitive": true,
        "attribute_category": "Health Certificate",
        "attribute_description": "The issuer of the certificate, e.g. Swedish e-Health Agency"
      }
    ],
    "event": [
      {
        "id": "did:mydata:z6Mkozm5hY7naS4NyQGZpCwHkPdMkBi5m4ctLgbFcDBssnPf#1",
        "time_stamp": "2021-12-23T06:27:13.748472+00:00",
        "did": "did:mydata:z6Mkozm5hY7naS4NyQGZpCwHkPdMkBi5m4ctLgbFcDBssnPf",
        "state": "offer"
      },
      {
        "id": "did:mydata:z6Mkm8jfFXKuRhXeNg78naVkyGyWZ6LX8e9ujcWBsguLmpLi#2",
        "time_stamp": "2021-12-23T07:05:33.091309+00:00",
        "did": "did:mydata:z6Mkm8jfFXKuRhXeNg78naVkyGyWZ6LX8e9ujcWBsguLmpLi",
        "state": "accept"
      },
      {
        "id": "did:mydata:z6Mkm8jfFXKuRhXeNg78naVkyGyWZ6LX8e9ujcWBsguLmpLi#3",
        "time_stamp": "2021-12-23T07:23:57.084508+00:00",
        "did": "did:mydata:z6Mkm8jfFXKuRhXeNg78naVkyGyWZ6LX8e9ujcWBsguLmpLi",
        "state": "terminate"
      }
    ],
    "proofChain": [
      {
        "id": "did:mydata:z6Mkozm5hY7naS4NyQGZpCwHkPdMkBi5m4ctLgbFcDBssnPf#1",
        "type": "Ed25519Signature2018",
        "created": "2021-12-23T06:27:13.749999+00:00",
        "verificationMethod": "did:mydata:z6Mkozm5hY7naS4NyQGZpCwHkPdMkBi5m4ctLgbFcDBssnPf",
        "proofPurpose": "contractAgreement",
        "proofValue": "eyJhbGciOiAiRWREU0EiLCAiYjY0IjogZmFsc2UsICJjcml0IjogWyJiNjQiXX0..Z-Hqsq2R3j9yOxSydk8JxqK2dDtp1qB3stEmREmh_ubDED6UEtU_tXKS_m-2JIzquXCj8VJ0KGSF7pU8nJzvBw"
      },
      {
        "id": "did:mydata:z6Mkm8jfFXKuRhXeNg78naVkyGyWZ6LX8e9ujcWBsguLmpLi#2",
        "type": "Ed25519Signature2018",
        "created": "2021-12-23T07:05:33.093851+00:00",
        "verificationMethod": "did:mydata:z6Mkm8jfFXKuRhXeNg78naVkyGyWZ6LX8e9ujcWBsguLmpLi",
        "proofPurpose": "contractAgreement",
        "proofValue": "eyJhbGciOiAiRWREU0EiLCAiYjY0IjogZmFsc2UsICJjcml0IjogWyJiNjQiXX0..ieQivg6W_6UyVlwefxgcK7vYw16ZavR7Axaz1oWEUSyyCR4n-coTLQ27rAKICpvhDqmvE1kKaDi7ehgBs3aKBQ"
      },
      {
        "id": "did:mydata:z6Mkm8jfFXKuRhXeNg78naVkyGyWZ6LX8e9ujcWBsguLmpLi#3",
        "type": "Ed25519Signature2018",
        "created": "2021-12-23T07:23:57.089359+00:00",
        "verificationMethod": "did:mydata:z6Mkm8jfFXKuRhXeNg78naVkyGyWZ6LX8e9ujcWBsguLmpLi",
        "proofPurpose": "contractAgreement",
        "proofValue": "eyJhbGciOiAiRWREU0EiLCAiYjY0IjogZmFsc2UsICJjcml0IjogWyJiNjQiXX0..Vl4uSAfZGQqWBx89NmpcKpM2SufsrY1YB9maLuxE8xGYDW2w43oij_iSo0SrKrmsp80PP36o7MmLq_OGgUKiDg"
      }
    ],
    "data_subject_did": "did:mydata:z6Mkm8jfFXKuRhXeNg78naVkyGyWZ6LX8e9ujcWBsguLmpLi"
  }
}
```

After termination, individual can query the data agreement to see the `terminate` event and it's proof updated. 

Individual can query the data agreement associated with a data exchange by `presentation_exchange_id`. Perform [**HTTP GET** http://individual.swagger.localhost/data-agreement-instances?data_exchange_record_id={data_exchange_record_id}](http://individual.swagger.localhost/api/doc#/Data%20Agreement%20-%20Core%20Functions/get_data_agreement_instances) by passing the `data_exchange_record_id` as query parameter. 


A sample response is given below.

```json
{
  "results": [
    {
      "data_exchange_record_id": "08371fc1-7126-4bdd-a823-a56170dbcb78",
      "data_agreement": {
        "@context": [
          "https://raw.githubusercontent.com/decentralised-dataexchange/automated-data-agreements/main/interface-specs/data-agreement-schema/v1/data-agreement-schema-context.jsonld",
          "https://w3id.org/security/v2"
        ],
        "id": "cb8ca19c-eedd-4786-8d58-c119bcf487b9",
        "version": 1,
        "template_id": "8f9878b0-cb20-4ed6-be5f-b2ef1531a13c",
        "template_version": 1,
        "data_controller_name": "Travel Company AB",
        "data_controller_url": "https://www.travelcompany.se",
        "purpose": "Verification of Covid-19 Test Results",
        "purpose_description": "Perform verification of Covid-19 Test Result to permit travel.",
        "lawful_basis": "consent",
        "method_of_use": "data-using-service",
        "data_policy": {
          "data_retention_period": 365,
          "policy_URL": "https://travelcompany.se/privacy-policy/",
          "jurisdiction": "Sweden",
          "industry_sector": "Travel",
          "geographic_restriction": "Europe",
          "storage_location": "Europe"
        },
        "personal_data": [
          {
            "attribute_id": "996dcab0-4182-468b-a106-19de5068c572",
            "attribute_name": "Test Result",
            "attribute_sensitive": true,
            "attribute_category": "Health Certificate",
            "attribute_description": "Result of the Covid-19 Test conducted by the Test Center"
          },
          {
            "attribute_id": "3d6e27fe-847f-42e2-84e5-029df7e177e1",
            "attribute_name": "Beneficiary Name",
            "attribute_sensitive": true,
            "attribute_category": "Health Certificate",
            "attribute_description": "Full name of the individual"
          },
          {
            "attribute_id": "4605e8c9-fcd4-43a9-91e3-b4762127c4e8",
            "attribute_name": "Certificate Issuer",
            "attribute_sensitive": true,
            "attribute_category": "Health Certificate",
            "attribute_description": "The issuer of the certificate, e.g. Swedish e-Health Agency"
          }
        ],
        "event": [
          {
            "id": "did:mydata:z6Mkozm5hY7naS4NyQGZpCwHkPdMkBi5m4ctLgbFcDBssnPf#1",
            "time_stamp": "2021-12-23T06:27:13.748472+00:00",
            "did": "did:mydata:z6Mkozm5hY7naS4NyQGZpCwHkPdMkBi5m4ctLgbFcDBssnPf",
            "state": "offer"
          },
          {
            "id": "did:mydata:z6Mkm8jfFXKuRhXeNg78naVkyGyWZ6LX8e9ujcWBsguLmpLi#2",
            "time_stamp": "2021-12-23T07:05:33.091309+00:00",
            "did": "did:mydata:z6Mkm8jfFXKuRhXeNg78naVkyGyWZ6LX8e9ujcWBsguLmpLi",
            "state": "accept"
          },
          {
            "id": "did:mydata:z6Mkm8jfFXKuRhXeNg78naVkyGyWZ6LX8e9ujcWBsguLmpLi#3",
            "time_stamp": "2021-12-23T07:23:57.084508+00:00",
            "did": "did:mydata:z6Mkm8jfFXKuRhXeNg78naVkyGyWZ6LX8e9ujcWBsguLmpLi",
            "state": "terminate"
          }
        ],
        "proofChain": [
          {
            "id": "did:mydata:z6Mkozm5hY7naS4NyQGZpCwHkPdMkBi5m4ctLgbFcDBssnPf#1",
            "type": "Ed25519Signature2018",
            "created": "2021-12-23T06:27:13.749999+00:00",
            "verificationMethod": "did:mydata:z6Mkozm5hY7naS4NyQGZpCwHkPdMkBi5m4ctLgbFcDBssnPf",
            "proofPurpose": "contractAgreement",
            "proofValue": "eyJhbGciOiAiRWREU0EiLCAiYjY0IjogZmFsc2UsICJjcml0IjogWyJiNjQiXX0..Z-Hqsq2R3j9yOxSydk8JxqK2dDtp1qB3stEmREmh_ubDED6UEtU_tXKS_m-2JIzquXCj8VJ0KGSF7pU8nJzvBw"
          },
          {
            "id": "did:mydata:z6Mkm8jfFXKuRhXeNg78naVkyGyWZ6LX8e9ujcWBsguLmpLi#2",
            "type": "Ed25519Signature2018",
            "created": "2021-12-23T07:05:33.093851+00:00",
            "verificationMethod": "did:mydata:z6Mkm8jfFXKuRhXeNg78naVkyGyWZ6LX8e9ujcWBsguLmpLi",
            "proofPurpose": "contractAgreement",
            "proofValue": "eyJhbGciOiAiRWREU0EiLCAiYjY0IjogZmFsc2UsICJjcml0IjogWyJiNjQiXX0..ieQivg6W_6UyVlwefxgcK7vYw16ZavR7Axaz1oWEUSyyCR4n-coTLQ27rAKICpvhDqmvE1kKaDi7ehgBs3aKBQ"
          },
          {
            "id": "did:mydata:z6Mkm8jfFXKuRhXeNg78naVkyGyWZ6LX8e9ujcWBsguLmpLi#3",
            "type": "Ed25519Signature2018",
            "created": "2021-12-23T07:23:57.089359+00:00",
            "verificationMethod": "did:mydata:z6Mkm8jfFXKuRhXeNg78naVkyGyWZ6LX8e9ujcWBsguLmpLi",
            "proofPurpose": "contractAgreement",
            "proofValue": "eyJhbGciOiAiRWREU0EiLCAiYjY0IjogZmFsc2UsICJjcml0IjogWyJiNjQiXX0..Vl4uSAfZGQqWBx89NmpcKpM2SufsrY1YB9maLuxE8xGYDW2w43oij_iSo0SrKrmsp80PP36o7MmLq_OGgUKiDg"
          }
        ],
        "data_subject_did": "did:mydata:z6Mkm8jfFXKuRhXeNg78naVkyGyWZ6LX8e9ujcWBsguLmpLi"
      }
    }
  ]
}
```

The above data agreement contains `terminate` event and it's proof.

## 5.3 Data Agreement audit workflow

Individual or Travel Company can utilise a third party auditing service to verify the correctness of the data agreement independently.

Either entity can query the data agreement by performing `HTTP GET /data-agreement-instances` and decide the data agreement that is to be audited. 

Then initiate the audit workflow by sending a verify request to the auditing service by performing `HTTP POST /auditor/didcomm/verify-request/{data_agreement_id}`

Below example shows the individual performing audit workflow, but the same steps could be used for a test center.

1. Individual queries the data agreements.

Perform [**HTTP GET** http://individual.swagger.localhost/data-agreement-instances](http://individual.swagger.localhost/api/doc#/Data%20Agreement%20-%20Core%20Functions/get_data_agreement_instances).

A sample response is given below.

```json
{
  "results": [
    {
      "data_exchange_record_id": "fea25938-2c00-4814-b69b-87dc1e245918",
      "data_agreement": {
        "@context": [
          "https://raw.githubusercontent.com/decentralised-dataexchange/automated-data-agreements/main/interface-specs/data-agreement-schema/v1/data-agreement-schema-context.jsonld",
          "https://w3id.org/security/v2"
        ],
        "id": "183b8652-af4b-4fe5-a587-738e8d0beac0",
        "version": 1,
        "template_id": "b329ff24-076c-4ac4-ba36-723b422f1dfc",
        "template_version": 1,
        "data_controller_name": "Test Center AB",
        "data_controller_url": "https://www.testcenter.se",
        "purpose": "Covid19 Test Results",
        "purpose_description": "Release of Covid19 Test Results to individual.",
        "lawful_basis": "consent",
        "method_of_use": "data-source",
        "data_policy": {
          "data_retention_period": 365,
          "policy_URL": "https://testcenter.se/privacy-policy/",
          "jurisdiction": "Sweden",
          "industry_sector": "Healthcare",
          "geographic_restriction": "Europe",
          "storage_location": "Europe"
        },
        "personal_data": [
          {
            "attribute_id": "437b0b94-78ba-475c-a20b-26b44de095ab",
            "attribute_name": "Test Result",
            "attribute_sensitive": true,
            "attribute_category": "Health Certificate",
            "attribute_description": "Result of the Covid-19 Test conducted by the Test Center"
          },
          {
            "attribute_id": "0f391930-c933-48aa-9af4-5388b98b4fa5",
            "attribute_name": "Beneficiary Name",
            "attribute_sensitive": true,
            "attribute_category": "Health Certificate",
            "attribute_description": "Full name of the individual"
          },
          {
            "attribute_id": "1b978aa6-d633-4029-b626-4ea38e760dd4",
            "attribute_name": "Certificate Issuer",
            "attribute_sensitive": true,
            "attribute_category": "Health Certificate",
            "attribute_description": "The issuer of the certificate, e.g. Swedish e-Health Agency"
          }
        ],
        "event": [
          {
            "id": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn#1",
            "time_stamp": "2021-12-22T13:51:37.271282+00:00",
            "did": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn",
            "state": "offer"
          },
          {
            "id": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW#2",
            "time_stamp": "2021-12-22T13:58:14.670991+00:00",
            "did": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW",
            "state": "accept"
          },
          {
            "id": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW#3",
            "time_stamp": "2021-12-22T14:09:08.870401+00:00",
            "did": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW",
            "state": "terminate"
          }
        ],
        "proofChain": [
          {
            "id": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn#1",
            "type": "Ed25519Signature2018",
            "created": "2021-12-22T13:51:37.273151+00:00",
            "verificationMethod": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn",
            "proofPurpose": "contractAgreement",
            "proofValue": "eyJhbGciOiAiRWREU0EiLCAiYjY0IjogZmFsc2UsICJjcml0IjogWyJiNjQiXX0..vEBtZFaCnmmJBr_WLWT382NB5l_9xcKFEhxvWEw_zHfNDXFE9I0jVcQJ4hbnZU2RoWJ2Q8zg20LMGrSpKaB8CA"
          },
          {
            "id": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW#2",
            "type": "Ed25519Signature2018",
            "created": "2021-12-22T13:58:14.671994+00:00",
            "verificationMethod": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW",
            "proofPurpose": "contractAgreement",
            "proofValue": "eyJhbGciOiAiRWREU0EiLCAiYjY0IjogZmFsc2UsICJjcml0IjogWyJiNjQiXX0..1unCHCVZ-UtXWuFnLMstpyCrYGnEuDj3HCi8IN6J9uAHs97rP5EgIa2tSwd2i2w0lzS-2pJ53c66DqSeJuI5DA"
          },
          {
            "id": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW#3",
            "type": "Ed25519Signature2018",
            "created": "2021-12-22T14:09:08.873294+00:00",
            "verificationMethod": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW",
            "proofPurpose": "contractAgreement",
            "proofValue": "eyJhbGciOiAiRWREU0EiLCAiYjY0IjogZmFsc2UsICJjcml0IjogWyJiNjQiXX0..tuoPC0ptO0DY-50haUun9gKZTS1LhENaIpLHAqqzl3d-zaFgyZNanMeoQwZ7URQ6AiTqT7pa2lMYZyZ3PItuBQ"
          }
        ],
        "data_subject_did": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW"
      }
    },
    {
      "data_exchange_record_id": "da6dcc4f-2327-4686-824b-b6accb532664",
      "data_agreement": {
        "@context": [
          "https://raw.githubusercontent.com/decentralised-dataexchange/automated-data-agreements/main/interface-specs/data-agreement-schema/v1/data-agreement-schema-context.jsonld",
          "https://w3id.org/security/v2"
        ],
        "id": "a32bdfeb-65d4-4cf0-b004-4cdb833042b2",
        "version": 1,
        "template_id": "b329ff24-076c-4ac4-ba36-723b422f1dfc",
        "template_version": 1,
        "data_controller_name": "Test Center AB",
        "data_controller_url": "https://www.testcenter.se",
        "purpose": "Covid19 Test Results",
        "purpose_description": "Release of Covid19 Test Results to individual.",
        "lawful_basis": "consent",
        "method_of_use": "data-source",
        "data_policy": {
          "data_retention_period": 365,
          "policy_URL": "https://testcenter.se/privacy-policy/",
          "jurisdiction": "Sweden",
          "industry_sector": "Healthcare",
          "geographic_restriction": "Europe",
          "storage_location": "Europe"
        },
        "personal_data": [
          {
            "attribute_id": "437b0b94-78ba-475c-a20b-26b44de095ab",
            "attribute_name": "Test Result",
            "attribute_sensitive": true,
            "attribute_category": "Health Certificate",
            "attribute_description": "Result of the Covid-19 Test conducted by the Test Center"
          },
          {
            "attribute_id": "0f391930-c933-48aa-9af4-5388b98b4fa5",
            "attribute_name": "Beneficiary Name",
            "attribute_sensitive": true,
            "attribute_category": "Health Certificate",
            "attribute_description": "Full name of the individual"
          },
          {
            "attribute_id": "1b978aa6-d633-4029-b626-4ea38e760dd4",
            "attribute_name": "Certificate Issuer",
            "attribute_sensitive": true,
            "attribute_category": "Health Certificate",
            "attribute_description": "The issuer of the certificate, e.g. Swedish e-Health Agency"
          }
        ],
        "event": [
          {
            "id": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn#1",
            "time_stamp": "2021-12-22T12:47:05.816357+00:00",
            "did": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn",
            "state": "offer"
          },
          {
            "id": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW#2",
            "time_stamp": "2021-12-22T13:28:17.474965+00:00",
            "did": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW",
            "state": "reject"
          }
        ],
        "proofChain": [
          {
            "id": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn#1",
            "type": "Ed25519Signature2018",
            "created": "2021-12-22T12:47:05.817813+00:00",
            "verificationMethod": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn",
            "proofPurpose": "contractAgreement",
            "proofValue": "eyJhbGciOiAiRWREU0EiLCAiYjY0IjogZmFsc2UsICJjcml0IjogWyJiNjQiXX0..eEziRTJ10X_P1OzbH2wu44nvvNGcmp4DI6fLvG5ZAr5e38I4KXbEfnjCDy6b8ZaR3Ktk0UcJi0OVEJv_XwtbBA"
          },
          {
            "id": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW#2",
            "type": "Ed25519Signature2018",
            "created": "2021-12-22T13:28:17.478040+00:00",
            "verificationMethod": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW",
            "proofPurpose": "contractAgreement",
            "proofValue": "eyJhbGciOiAiRWREU0EiLCAiYjY0IjogZmFsc2UsICJjcml0IjogWyJiNjQiXX0..4hOT_VU2mfBEntodhGWvUqmtmkcc6_D7hjN5fms_0ja941SQ4mOu8O7a87ujhgVBVwYj6b9r8eH7DyhqjFCbDw"
          }
        ],
        "data_subject_did": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW"
      }
    }
  ]
}
```


2. Individual initiates the audit by sending a data agreement verify request to the auditor.

Copy the `id` field inside the Data Agreement (`data_agreement`) that needs to be audited.

Perform [**HTTP POST** http://individual.swagger.localhost/auditor/didcomm/verify-request/{data_agreement_id}](http://individual.swagger.localhost/api/doc#/Data%20Agreement%20-%20Auditor%20Functions/post_auditor_didcomm_verify_request__data_agreement_id_) by passing `data_agreement_id` as path parameter to send verify request to the auditor.

Sample response is given below.

```json
{
  "created_at": "2021-12-22 14:36:53.925036Z",
  "updated_at": "2021-12-22 14:36:53.925036Z",
  "auditor_didcomm_transaction_record_id": "36e40723-20ab-444d-b831-2c7661efe9d9",
  "trace": false,
  "connection_id": "78a360d9-5831-4824-9ea3-6f0583c78d97",
  "thread_id": "c06802c9-7d9b-4292-99bd-eb6799a8031e",
  "messages_list": [
    {
      "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/data-agreement-proofs/1.0/verify-request",
      "@id": "c06802c9-7d9b-4292-99bd-eb6799a8031e",
      "body": {
        "data_agreement": {
          "@context": [
            "https://raw.githubusercontent.com/decentralised-dataexchange/automated-data-agreements/main/interface-specs/data-agreement-schema/v1/data-agreement-schema-context.jsonld",
            "https://w3id.org/security/v2"
          ],
          "id": "a32bdfeb-65d4-4cf0-b004-4cdb833042b2",
          "version": 1,
          "template_id": "b329ff24-076c-4ac4-ba36-723b422f1dfc",
          "template_version": 1,
          "data_controller_name": "Test Center AB",
          "data_controller_url": "https://www.testcenter.se",
          "purpose": "Covid19 Test Results",
          "purpose_description": "Release of Covid19 Test Results to individual.",
          "lawful_basis": "consent",
          "method_of_use": "data-source",
          "data_policy": {
            "data_retention_period": 365,
            "policy_URL": "https://testcenter.se/privacy-policy/",
            "jurisdiction": "Sweden",
            "industry_sector": "Healthcare",
            "geographic_restriction": "Europe",
            "storage_location": "Europe"
          },
          "personal_data": [
            {
              "attribute_id": "437b0b94-78ba-475c-a20b-26b44de095ab",
              "attribute_name": "Test Result",
              "attribute_sensitive": true,
              "attribute_category": "Health Certificate",
              "attribute_description": "Result of the Covid-19 Test conducted by the Test Center"
            },
            {
              "attribute_id": "0f391930-c933-48aa-9af4-5388b98b4fa5",
              "attribute_name": "Beneficiary Name",
              "attribute_sensitive": true,
              "attribute_category": "Health Certificate",
              "attribute_description": "Full name of the individual"
            },
            {
              "attribute_id": "1b978aa6-d633-4029-b626-4ea38e760dd4",
              "attribute_name": "Certificate Issuer",
              "attribute_sensitive": true,
              "attribute_category": "Health Certificate",
              "attribute_description": "The issuer of the certificate, e.g. Swedish e-Health Agency"
            }
          ],
          "event": [
            {
              "id": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn#1",
              "time_stamp": "2021-12-22T12:47:05.816357+00:00",
              "did": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn",
              "state": "offer"
            },
            {
              "id": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW#2",
              "time_stamp": "2021-12-22T13:28:17.474965+00:00",
              "did": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW",
              "state": "reject"
            }
          ],
          "proofChain": [
            {
              "id": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn#1",
              "type": "Ed25519Signature2018",
              "created": "2021-12-22T12:47:05.817813+00:00",
              "verificationMethod": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn",
              "proofPurpose": "contractAgreement",
              "proofValue": "eyJhbGciOiAiRWREU0EiLCAiYjY0IjogZmFsc2UsICJjcml0IjogWyJiNjQiXX0..eEziRTJ10X_P1OzbH2wu44nvvNGcmp4DI6fLvG5ZAr5e38I4KXbEfnjCDy6b8ZaR3Ktk0UcJi0OVEJv_XwtbBA"
            },
            {
              "id": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW#2",
              "type": "Ed25519Signature2018",
              "created": "2021-12-22T13:28:17.478040+00:00",
              "verificationMethod": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW",
              "proofPurpose": "contractAgreement",
              "proofValue": "eyJhbGciOiAiRWREU0EiLCAiYjY0IjogZmFsc2UsICJjcml0IjogWyJiNjQiXX0..4hOT_VU2mfBEntodhGWvUqmtmkcc6_D7hjN5fms_0ja941SQ4mOu8O7a87ujhgVBVwYj6b9r8eH7DyhqjFCbDw"
            }
          ],
          "data_subject_did": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW"
        }
      },
      "created_time": "1640183813",
      "from": "did:mydata:z6MkmdAsGKopbREaiJ14raCmAN3m6K317xk236tqpDpe6Qxo",
      "to": "did:mydata:z6MkpYqJj4nbSL9pCzvxaUzbY5VGUW7nCXj1xYKNLENWq9nE"
    }
  ]
}
```

3. Individual queries the didcomm transaction between the auditor to check the verify request status.


Copy the `thread_id` from the above response.

Perform [**HTTP GET** http://individual.swagger.localhost/auditor/didcomm/transaction-records?thread_id={thread_id}](http://individual.swagger.localhost/api/doc#/Data%20Agreement%20-%20Auditor%20Functions/get_auditor_didcomm_transaction_records) by passing `thread_id` as query parameter.

Sample response is given below.

```json
[
  {
    "created_at": "2021-12-22 14:36:53.925036Z",
    "updated_at": "2021-12-22 14:37:21.087703Z",
    "auditor_didcomm_transaction_record_id": "36e40723-20ab-444d-b831-2c7661efe9d9",
    "trace": false,
    "connection_id": "78a360d9-5831-4824-9ea3-6f0583c78d97",
    "thread_id": "c06802c9-7d9b-4292-99bd-eb6799a8031e",
    "messages_list": [
      {
        "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/data-agreement-proofs/1.0/verify-request",
        "@id": "c06802c9-7d9b-4292-99bd-eb6799a8031e",
        "body": {
          "data_agreement": {
            "@context": [
              "https://raw.githubusercontent.com/decentralised-dataexchange/automated-data-agreements/main/interface-specs/data-agreement-schema/v1/data-agreement-schema-context.jsonld",
              "https://w3id.org/security/v2"
            ],
            "id": "a32bdfeb-65d4-4cf0-b004-4cdb833042b2",
            "version": 1,
            "template_id": "b329ff24-076c-4ac4-ba36-723b422f1dfc",
            "template_version": 1,
            "data_controller_name": "Test Center AB",
            "data_controller_url": "https://www.testcenter.se",
            "purpose": "Covid19 Test Results",
            "purpose_description": "Release of Covid19 Test Results to individual.",
            "lawful_basis": "consent",
            "method_of_use": "data-source",
            "data_policy": {
              "data_retention_period": 365,
              "policy_URL": "https://testcenter.se/privacy-policy/",
              "jurisdiction": "Sweden",
              "industry_sector": "Healthcare",
              "geographic_restriction": "Europe",
              "storage_location": "Europe"
            },
            "personal_data": [
              {
                "attribute_id": "437b0b94-78ba-475c-a20b-26b44de095ab",
                "attribute_name": "Test Result",
                "attribute_sensitive": true,
                "attribute_category": "Health Certificate",
                "attribute_description": "Result of the Covid-19 Test conducted by the Test Center"
              },
              {
                "attribute_id": "0f391930-c933-48aa-9af4-5388b98b4fa5",
                "attribute_name": "Beneficiary Name",
                "attribute_sensitive": true,
                "attribute_category": "Health Certificate",
                "attribute_description": "Full name of the individual"
              },
              {
                "attribute_id": "1b978aa6-d633-4029-b626-4ea38e760dd4",
                "attribute_name": "Certificate Issuer",
                "attribute_sensitive": true,
                "attribute_category": "Health Certificate",
                "attribute_description": "The issuer of the certificate, e.g. Swedish e-Health Agency"
              }
            ],
            "event": [
              {
                "id": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn#1",
                "time_stamp": "2021-12-22T12:47:05.816357+00:00",
                "did": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn",
                "state": "offer"
              },
              {
                "id": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW#2",
                "time_stamp": "2021-12-22T13:28:17.474965+00:00",
                "did": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW",
                "state": "reject"
              }
            ],
            "proofChain": [
              {
                "id": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn#1",
                "type": "Ed25519Signature2018",
                "created": "2021-12-22T12:47:05.817813+00:00",
                "verificationMethod": "did:mydata:z6Mkip2zm2rEQCVGaKJHFfWkcPhMuXyaiLnzyupcn6fz7gsn",
                "proofPurpose": "contractAgreement",
                "proofValue": "eyJhbGciOiAiRWREU0EiLCAiYjY0IjogZmFsc2UsICJjcml0IjogWyJiNjQiXX0..eEziRTJ10X_P1OzbH2wu44nvvNGcmp4DI6fLvG5ZAr5e38I4KXbEfnjCDy6b8ZaR3Ktk0UcJi0OVEJv_XwtbBA"
              },
              {
                "id": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW#2",
                "type": "Ed25519Signature2018",
                "created": "2021-12-22T13:28:17.478040+00:00",
                "verificationMethod": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW",
                "proofPurpose": "contractAgreement",
                "proofValue": "eyJhbGciOiAiRWREU0EiLCAiYjY0IjogZmFsc2UsICJjcml0IjogWyJiNjQiXX0..4hOT_VU2mfBEntodhGWvUqmtmkcc6_D7hjN5fms_0ja941SQ4mOu8O7a87ujhgVBVwYj6b9r8eH7DyhqjFCbDw"
              }
            ],
            "data_subject_did": "did:mydata:z6MktYh2bemcEGJMvA1tDuG6CkswCppLPF7WSdnJcr3MFuVW"
          }
        },
        "created_time": "1640183813",
        "from": "did:mydata:z6MkmdAsGKopbREaiJ14raCmAN3m6K317xk236tqpDpe6Qxo",
        "to": "did:mydata:z6MkpYqJj4nbSL9pCzvxaUzbY5VGUW7nCXj1xYKNLENWq9nE"
      },
      {
        "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/data-agreement-proofs/1.0/verify-response",
        "@id": "25a96862-27ff-46a6-869e-66f824ad077c",
        "~thread": {
          "thid": "c06802c9-7d9b-4292-99bd-eb6799a8031e"
        },
        "explain": "Signature verification successful.",
        "status": "OK"
      }
    ]
  }
]
```

`messages_list` key in the response above contains the list of didcomm messages exchanged between the Individual and Auditor. Second entry in the list is the response to the `data-agreement-proofs/1.0/verify-request` didcomm message sent by the Individual. Since the message type of the second entry is `data-agreement-proofs/1.0/verify-response`, message body contains `status` with value `OK`, this would mean the correctness of data agreement was verified successfully.
