## Data Exchange Agreements (DEXA) User Guide

### Table of Contents

- [Data Exchange Agreements (DEXA) User Guide](#data-exchange-agreements-dexa-user-guide)
  - [Table of Contents](#table-of-contents)
  - [1.0 Introduction](#10-introduction)
  - [2.0 Reference system](#20-reference-system)
  - [3.0 Use case Scenario](#30-use-case-scenario)
  - [4.0 Pre-requisite workflows](#40-pre-requisite-workflows)
    - [4.1 ABC Bank](#41-abc-bank)
      - [4.1.1 Establish connection between ABC Bank and Finance Marketplace](#411-establish-connection-between-abc-bank-and-finance-marketplace)
    - [4.2 Credit Reporting Agency](#42-credit-reporting-agency)
      - [4.2.1 Establish connection between Credit Reporting Agency and Finance Marketplace](#421-establish-connection-between-credit-reporting-agency-and-finance-marketplace)
    - [4.3 Individual](#43-individual)
      - [4.3.1 Establish connection between Individual and ABC Bank](#431-establish-connection-between-individual-and-abc-bank)
  - [5.0 ABC Bank creates third-party data sharing data agreement to Individual](#50-abc-bank-creates-third-party-data-sharing-data-agreement-to-individual)
  - [6.0 ABC Bank issues third-party data sharing data agreement to Individual](#60-abc-bank-issues-third-party-data-sharing-data-agreement-to-individual)
  - [7.0 ABC Bank creates data disclosure agreement from third-party data sharing data agreement](#70-abc-bank-creates-data-disclosure-agreement-from-third-party-data-sharing-data-agreement)
  - [8.0 ABC Bank publishes data disclosure agreement to marketplace](#80-abc-bank-publishes-data-disclosure-agreement-to-marketplace)
  - [9.0 Credit Reporting Agency visits Finance Marketplace](#90-credit-reporting-agency-visits-finance-marketplace)
  - [10.0 Credit Reporting Agency sign up data disclosure agreement from ABC Bank](#100-credit-reporting-agency-sign-up-data-disclosure-agreement-from-abc-bank)
  - [11.0 Credit Reporting Agency pulls data from ABC Bank](#110-credit-reporting-agency-pulls-data-from-abc-bank)

### 1.0 Introduction

This describes the API call flows during a data exchange agreement enabled verified data exchange process using Hyperledger Indy for anchoring identity schemas, Ethereum for anchoring root hash of data exchange agreements and Hyperledger Aries for agents. 

The indy network is up and running at https://indy.igrant.io/. The aries agents are connected to this network and configured locally as described [here](https://github.com/decentralised-dataexchange/aries-playground/blob/master/dexa/README.md). Executing the sequence of operations described creates the reference system described [below](#Reference-system).

### 2.0 Reference system

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

### 3.0 Use case Scenario

Individual is a customer of ABC Bank. A Credit Reporting Agency determines the credit score of the Individual by pulling account transaction history from the ABC Bank on periodic basis. This enables the ABC Bank to determine the credibility of Individual if in-case they apply for a loan.


### 4.0 Pre-requisite workflows

#### 4.1 ABC Bank

##### 4.1.1 Establish connection between ABC Bank and Finance Marketplace

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

#### 4.2 Credit Reporting Agency

##### 4.2.1 Establish connection between Credit Reporting Agency and Finance Marketplace

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

#### 4.3 Individual

##### 4.3.1 Establish connection between Individual and ABC Bank


1. Fetch the invitation from well-known endpoint hosted at ABC Bank.

Perform [**HTTP GET** http://abc-bank.swagger.localhost/v1/.well-known/did-configuration.json](http://abc-bank.swagger.localhost/api/doc#/connection/get_v1__well_known_did_configuration_json). Sample response is given below.

```json
{
  "ServiceEndpoint": "http://abc-bank.localhost",
  "RoutingKey": "",
  "Invitation": {
    "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/connections/1.0/invitation",
    "@id": "f4876590-80fd-48e0-b817-e0870a2f2e64",
    "recipientKeys": [
      "2ACdmyJ7y1St47MBoAjqLEzbnZke8sXgmGmuZhwKB6wh"
    ],
    "serviceEndpoint": "http://abc-bank.localhost",
    "label": "ABC Bank"
  }
}
```

2. Receive a new connection invitation by Individual.

Receive a new connection invitation by copying the invitation from response in step 1 and passing it as request body to [**HTTP POST** http://individual.swagger.localhost/connections/receive-invitation?auto_accept=true](http://individual.swagger.localhost/api/doc#/connection/post_connections_receive_invitation). Sample response is given below.

```json
{
  "accept": "auto",
  "invitation_mode": "once",
  "connection_id": "0af1088d-8dd4-49e0-8169-e4670693398d",
  "request_id": "9b07e512-8be3-42b6-913f-085f4683f629",
  "my_did": "4aRFDaoK6e44pVLFbpscEz",
  "initiator": "external",
  "state": "request",
  "updated_at": "2022-10-04 07:38:01.999809Z",
  "invitation_key": "2ACdmyJ7y1St47MBoAjqLEzbnZke8sXgmGmuZhwKB6wh",
  "created_at": "2022-10-04 07:38:01.936549Z",
  "their_label": "ABC Bank",
  "routing_state": "none"
}
```

### 5.0 ABC Bank creates third-party data sharing data agreement to Individual

Perform [**HTTP POST** http://abc-bank.swagger.localhost/v1/data-agreements?publish_flag=true](http://abc-bank.swagger.localhost/api/doc#/Data%20Agreement%20-%20Core%20Functions/post_v1_data_agreements) with sample request body as given below.

```json
{
    "language": "en",
    "dataControllerName": "Happy Shopping AB",
    "dataControllerUrl": "https://www.happyshopping.com",
    "dataPolicy": {
        "policyUrl": "https://happyshoping.com/privacy-policy/",
        "jurisdiction": "Sweden",
        "industrySector": "Retail",
        "dataRetentionPeriod": 30,
        "geographicRestriction": "Europe",
        "storageLocation": "Europe",
        "thirdPartyDataSharing": true
    },
    "purpose": "Account transaction history",
    "purposeDescription": "Identify customer credibility.",
    "lawfulBasis": "consent",
    "methodOfUse": "data-source",
    "personalData": [
        {
            "attributeName": "Customer ID",
            "attributeDescription": "Unique number assigned to a customer."
        },
        {
            "attributeName": "Customer name",
            "attributeDescription": "Name of the customer"
        }
    ],
    "dpia": {
        "dpiaDate": "2021-05-08T08:41:59+0000",
        "dpiaSummaryUrl": "https://org.com/dpia_results.html"
    }
}
```

Sample response is given below.

```json
{
  "publish_flag": "true",
  "cred_def_id": "2dgesABgg8hfvPoZVD2nAc:3:CL:3579:default",
  "existing_schema_flag": "false",
  "data_agreement": {
    "@context": [
      "https://raw.githubusercontent.com/decentralised-dataexchange/data-exchange-agreements/main/interface-specs/jsonld/contexts/dexa-context.jsonld",
      "https://w3id.org/security/v2"
    ],
    "@id": "be964034-cca8-4c54-9e9c-9168c362a474",
    "@type": [
      "DataAgreement"
    ],
    "version": "1.0.0",
    "language": "en",
    "dataControllerName": "Happy Shopping AB",
    "dataControllerUrl": "https://www.happyshopping.com",
    "dataPolicy": {
      "policyUrl": "https://happyshoping.com/privacy-policy/",
      "jurisdiction": "Sweden",
      "industrySector": "Retail",
      "dataRetentionPeriod": 30,
      "geographicRestriction": "Europe",
      "storageLocation": "Europe",
      "thirdPartyDataSharing": true
    },
    "purpose": "Account transaction history",
    "purposeDescription": "Identify customer credibility.",
    "lawfulBasis": "consent",
    "methodOfUse": "data-source",
    "personalData": [
      {
        "attributeId": "a601c468-4d26-41e1-8ad9-30eb16746751",
        "attributeName": "Customer ID",
        "attributeSensitive": true,
        "attributeDescription": "Unique number assigned to a customer.",
        "restrictions": []
      },
      {
        "attributeId": "cca3db4d-2cf9-4c08-b5c1-4b86a65224ce",
        "attributeName": "Customer name",
        "attributeSensitive": true,
        "attributeDescription": "Name of the customer",
        "restrictions": []
      }
    ],
    "dpia": {
      "dpiaDate": "2021-05-08T08:41:59+0000",
      "dpiaSummaryUrl": "https://org.com/dpia_results.html"
    }
  },
  "state": "DEFINITION",
  "template_id": "be964034-cca8-4c54-9e9c-9168c362a474",
  "template_version": "1.0.0",
  "method_of_use": "data-source",
  "delete_flag": "false",
  "created_at": "2022-10-04 07:30:55.718372Z",
  "third_party_data_sharing": "true",
  "latest_version_flag": "true",
  "updated_at": "2022-10-04 07:31:48.606018Z",
  "schema_id": "2dgesABgg8hfvPoZVD2nAc:2:Account transaction history:1.0.0"
}
```

### 6.0 ABC Bank issues third-party data sharing data agreement to Individual

Perform [**HTTP POST** http://abc-bank.swagger.localhost/issue-credential/send-offer](http://abc-bank.swagger.localhost/api/doc#/issue-credential/post_issue_credential_send_offer) with sample request body as given below.

```json
{
  "auto_issue": true,
  "auto_remove": false,
  "comment": "Account transaction history",
  "connection_id": "05931679-14ce-443a-ad1c-8d5f67c944ac",
  "template_id": "be964034-cca8-4c54-9e9c-9168c362a474",
  "trace": false
}
```

Sample response is given below.

```json
{
  "credential_offer": {
    "schema_id": "2dgesABgg8hfvPoZVD2nAc:2:Account transaction history:1.0.0",
    "cred_def_id": "2dgesABgg8hfvPoZVD2nAc:3:CL:3579:default",
    "key_correctness_proof": {
      "c": "22173904069857967468277402717120747921074064578982301486541028815822115058808",
      "xz_cap": "376133687638753810291031327376457116425762571574816212635897670169431843144671885264380787752512577928555141066272391550831063144556109257068488565970349816261056612108286334514492848838751151885979473843901647349968403264276618474511880963440488093424530303961304474158142394932809785375977627445809675875277710759454091669454529700681374281226353754327150711149761369800170121607709544391888882468755898475106302983657015563727028980714118874724428789087959986567251140505471491482474190279744503775396731285030274514362940016416171388955170210862629330817944307752436505243126269458964433613373593293680305000106952643409708696039368101416574469228761933226233843092573777663144730825831314",
      "xr_cap": [
        [
          "master_secret",
          "322744285910941798362774207952162708525615054472183445345603111580573966945517644833481859543550525477697589019573037665644047807422046706308072394505214360284763210103001936654048215631121183298753588700453791123699191371331634964948078942847508565564150425563953905237483919375228267529534213007945384391928393566009605664325167207314676586067413403737260593311198760037368594814002455823514468385831205187478348669542696672281656708875839105578888133152404188035863192218229101755195856687453771962807529955100514232792207679265051864472309547230699020090547564998010134462436876821094476902577223981616465905160669226368582252982133346339170647314287233949063160937073865105613311664344907"
        ],
        [
          "customername",
          "319983389348178103849157054950456405262703814249432844579561527953957181293871358221718742879026028725628807113861149694963012709871998795765595187714602190775169316734894892210389428768204184900687169240194233366534350646699819208433308710563469094857171609315943454088280578693945491094449913874925283695375000714727428832316825119982468918936204428378050505812796384276664605922299393390840013376701025810848401081915231805673740753773641082920815596680354268443438192612781734980053250392777251019269664733585989570077433726174863782644962995172307863332569515281356835222824052599049318321702119437991592714339234129116571394317573917617025509903980669990845349142567843080073159047865042"
        ],
        [
          "customerid",
          "177422361266612463112165735712422787154858212058027039639696692284279810446824688541262825940048205949516738148359151508750384785422003000898630112923364885150725309774627757450444503200068089346136044837487751834222175295657723006380913493077112478053739532930857045980729741350448475392936005714674049465277313123149220067958685424147792478451011947878684931990198310167771919767807575777970669382598273258100790972181354632855623706402333769374787190964102562634886239019251681196540962524649164066731300781538311346852189946732835276995775475043799479416431629651162854088760633569302862601793253487657659440336424940476717052935659522521655507607137593127522793203170738521336401440394659"
        ]
      ]
    },
    "nonce": "556170727563745700731561"
  },
  "state": "offer_sent",
  "connection_id": "05931679-14ce-443a-ad1c-8d5f67c944ac",
  "credential_offer_dict": {
    "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/issue-credential/1.0/offer-credential",
    "@id": "ea6ab74c-644e-4f83-ae4c-621e1dae8396",
    "~thread": {},
    "~data-agreement-context": {
      "message_type": "protocol",
      "message": {
        "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/data-agreement-negotiation/1.0/offer",
        "@id": "000f8dcc-de19-4399-ac34-ef1be8d71653",
        "body": {
          "@context": [
            "https://raw.githubusercontent.com/decentralised-dataexchange/data-exchange-agreements/main/interface-specs/jsonld/contexts/dexa-context.jsonld",
            "https://w3id.org/security/v2"
          ],
          "@id": "99d98d68-19ef-4ad3-8009-cc18794c0270",
          "@type": [
            "DataAgreement"
          ],
          "version": "1.0.0",
          "templateId": "be964034-cca8-4c54-9e9c-9168c362a474",
          "templateVersion": "1.0.0",
          "language": "en",
          "dataControllerName": "Happy Shopping AB",
          "dataControllerUrl": "https://www.happyshopping.com",
          "dataPolicy": {
            "policyUrl": "https://happyshoping.com/privacy-policy/",
            "jurisdiction": "Sweden",
            "industrySector": "Retail",
            "dataRetentionPeriod": 30,
            "geographicRestriction": "Europe",
            "storageLocation": "Europe",
            "thirdPartyDataSharing": true
          },
          "purpose": "Account transaction history",
          "purposeDescription": "Identify customer credibility.",
          "lawfulBasis": "consent",
          "methodOfUse": "data-source",
          "personalData": [
            {
              "attributeId": "a601c468-4d26-41e1-8ad9-30eb16746751",
              "attributeName": "Customer ID",
              "attributeSensitive": true,
              "attributeDescription": "Unique number assigned to a customer.",
              "restrictions": []
            },
            {
              "attributeId": "cca3db4d-2cf9-4c08-b5c1-4b86a65224ce",
              "attributeName": "Customer name",
              "attributeSensitive": true,
              "attributeDescription": "Name of the customer",
              "restrictions": []
            }
          ],
          "dpia": {
            "dpiaDate": "2021-05-08T08:41:59+0000",
            "dpiaSummaryUrl": "https://org.com/dpia_results.html"
          },
          "dataSubjectDid": "did:sov:4aRFDaoK6e44pVLFbpscEz",
          "proof": {
            "id": "did:sov:2dgesABgg8hfvPoZVD2nAc#1",
            "type": "Ed25519Signature2018",
            "created": "2022-10-04T07:39:06.757003+00:00",
            "verificationMethod": "tc8yQSjm3hAz6rhdaswM25Phf3WrN2us8gNrUwamCoG",
            "proofPurpose": "authentication",
            "proofValue": "eyJhbGciOiAiRWREU0EiLCAiYjY0IjogZmFsc2UsICJjcml0IjogWyJiNjQiXX0..5sB-6x_kYoqmEmm8m9hY2SzXZ7E2h1CrCOkP09Fa-XIgWTzB-_GIE19ewXc-ovgZb1daMjDrKBDlgF06Ut3iAA"
          }
        }
      }
    },
    "comment": "Account transaction history",
    "credential_preview": {
      "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/issue-credential/1.0/credential-preview",
      "attributes": [
        {
          "name": "Customer ID",
          "value": " "
        },
        {
          "name": "Customer name",
          "value": " "
        }
      ]
    },
    "offers~attach": [
      {
        "@id": "libindy-cred-offer-0",
        "mime-type": "application/json",
        "data": {
          "base64": "eyJzY2hlbWFfaWQiOiAiMmRnZXNBQmdnOGhmdlBvWlZEMm5BYzoyOkFjY291bnQgdHJhbnNhY3Rpb24gaGlzdG9yeToxLjAuMCIsICJjcmVkX2RlZl9pZCI6ICIyZGdlc0FCZ2c4aGZ2UG9aVkQybkFjOjM6Q0w6MzU3OTpkZWZhdWx0IiwgImtleV9jb3JyZWN0bmVzc19wcm9vZiI6IHsiYyI6ICIyMjE3MzkwNDA2OTg1Nzk2NzQ2ODI3NzQwMjcxNzEyMDc0NzkyMTA3NDA2NDU3ODk4MjMwMTQ4NjU0MTAyODgxNTgyMjExNTA1ODgwOCIsICJ4el9jYXAiOiAiMzc2MTMzNjg3NjM4NzUzODEwMjkxMDMxMzI3Mzc2NDU3MTE2NDI1NzYyNTcxNTc0ODE2MjEyNjM1ODk3NjcwMTY5NDMxODQzMTQ0NjcxODg1MjY0MzgwNzg3NzUyNTEyNTc3OTI4NTU1MTQxMDY2MjcyMzkxNTUwODMxMDYzMTQ0NTU2MTA5MjU3MDY4NDg4NTY1OTcwMzQ5ODE2MjYxMDU2NjEyMTA4Mjg2MzM0NTE0NDkyODQ4ODM4NzUxMTUxODg1OTc5NDczODQzOTAxNjQ3MzQ5OTY4NDAzMjY0Mjc2NjE4NDc0NTExODgwOTYzNDQwNDg4MDkzNDI0NTMwMzAzOTYxMzA0NDc0MTU4MTQyMzk0OTMyODA5Nzg1Mzc1OTc3NjI3NDQ1ODA5Njc1ODc1Mjc3NzEwNzU5NDU0MDkxNjY5NDU0NTI5NzAwNjgxMzc0MjgxMjI2MzUzNzU0MzI3MTUwNzExMTQ5NzYxMzY5ODAwMTcwMTIxNjA3NzA5NTQ0MzkxODg4ODgyNDY4NzU1ODk4NDc1MTA2MzAyOTgzNjU3MDE1NTYzNzI3MDI4OTgwNzE0MTE4ODc0NzI0NDI4Nzg5MDg3OTU5OTg2NTY3MjUxMTQwNTA1NDcxNDkxNDgyNDc0MTkwMjc5NzQ0NTAzNzc1Mzk2NzMxMjg1MDMwMjc0NTE0MzYyOTQwMDE2NDE2MTcxMzg4OTU1MTcwMjEwODYyNjI5MzMwODE3OTQ0MzA3NzUyNDM2NTA1MjQzMTI2MjY5NDU4OTY0NDMzNjEzMzczNTkzMjkzNjgwMzA1MDAwMTA2OTUyNjQzNDA5NzA4Njk2MDM5MzY4MTAxNDE2NTc0NDY5MjI4NzYxOTMzMjI2MjMzODQzMDkyNTczNzc3NjYzMTQ0NzMwODI1ODMxMzE0IiwgInhyX2NhcCI6IFtbIm1hc3Rlcl9zZWNyZXQiLCAiMzIyNzQ0Mjg1OTEwOTQxNzk4MzYyNzc0MjA3OTUyMTYyNzA4NTI1NjE1MDU0NDcyMTgzNDQ1MzQ1NjAzMTExNTgwNTczOTY2OTQ1NTE3NjQ0ODMzNDgxODU5NTQzNTUwNTI1NDc3Njk3NTg5MDE5NTczMDM3NjY1NjQ0MDQ3ODA3NDIyMDQ2NzA2MzA4MDcyMzk0NTA1MjE0MzYwMjg0NzYzMjEwMTAzMDAxOTM2NjU0MDQ4MjE1NjMxMTIxMTgzMjk4NzUzNTg4NzAwNDUzNzkxMTIzNjk5MTkxMzcxMzMxNjM0OTY0OTQ4MDc4OTQyODQ3NTA4NTY1NTY0MTUwNDI1NTYzOTUzOTA1MjM3NDgzOTE5Mzc1MjI4MjY3NTI5NTM0MjEzMDA3OTQ1Mzg0MzkxOTI4MzkzNTY2MDA5NjA1NjY0MzI1MTY3MjA3MzE0Njc2NTg2MDY3NDEzNDAzNzM3MjYwNTkzMzExMTk4NzYwMDM3MzY4NTk0ODE0MDAyNDU1ODIzNTE0NDY4Mzg1ODMxMjA1MTg3NDc4MzQ4NjY5NTQyNjk2NjcyMjgxNjU2NzA4ODc1ODM5MTA1NTc4ODg4MTMzMTUyNDA0MTg4MDM1ODYzMTkyMjE4MjI5MTAxNzU1MTk1ODU2Njg3NDUzNzcxOTYyODA3NTI5OTU1MTAwNTE0MjMyNzkyMjA3Njc5MjY1MDUxODY0NDcyMzA5NTQ3MjMwNjk5MDIwMDkwNTQ3NTY0OTk4MDEwMTM0NDYyNDM2ODc2ODIxMDk0NDc2OTAyNTc3MjIzOTgxNjE2NDY1OTA1MTYwNjY5MjI2MzY4NTgyMjUyOTgyMTMzMzQ2MzM5MTcwNjQ3MzE0Mjg3MjMzOTQ5MDYzMTYwOTM3MDczODY1MTA1NjEzMzExNjY0MzQ0OTA3Il0sIFsiY3VzdG9tZXJuYW1lIiwgIjMxOTk4MzM4OTM0ODE3ODEwMzg0OTE1NzA1NDk1MDQ1NjQwNTI2MjcwMzgxNDI0OTQzMjg0NDU3OTU2MTUyNzk1Mzk1NzE4MTI5Mzg3MTM1ODIyMTcxODc0Mjg3OTAyNjAyODcyNTYyODgwNzExMzg2MTE0OTY5NDk2MzAxMjcwOTg3MTk5ODc5NTc2NTU5NTE4NzcxNDYwMjE5MDc3NTE2OTMxNjczNDg5NDg5MjIxMDM4OTQyODc2ODIwNDE4NDkwMDY4NzE2OTI0MDE5NDIzMzM2NjUzNDM1MDY0NjY5OTgxOTIwODQzMzMwODcxMDU2MzQ2OTA5NDg1NzE3MTYwOTMxNTk0MzQ1NDA4ODI4MDU3ODY5Mzk0NTQ5MTA5NDQ0OTkxMzg3NDkyNTI4MzY5NTM3NTAwMDcxNDcyNzQyODgzMjMxNjgyNTExOTk4MjQ2ODkxODkzNjIwNDQyODM3ODA1MDUwNTgxMjc5NjM4NDI3NjY2NDYwNTkyMjI5OTM5MzM5MDg0MDAxMzM3NjcwMTAyNTgxMDg0ODQwMTA4MTkxNTIzMTgwNTY3Mzc0MDc1Mzc3MzY0MTA4MjkyMDgxNTU5NjY4MDM1NDI2ODQ0MzQzODE5MjYxMjc4MTczNDk4MDA1MzI1MDM5Mjc3NzI1MTAxOTI2OTY2NDczMzU4NTk4OTU3MDA3NzQzMzcyNjE3NDg2Mzc4MjY0NDk2Mjk5NTE3MjMwNzg2MzMzMjU2OTUxNTI4MTM1NjgzNTIyMjgyNDA1MjU5OTA0OTMxODMyMTcwMjExOTQzNzk5MTU5MjcxNDMzOTIzNDEyOTExNjU3MTM5NDMxNzU3MzkxNzYxNzAyNTUwOTkwMzk4MDY2OTk5MDg0NTM0OTE0MjU2Nzg0MzA4MDA3MzE1OTA0Nzg2NTA0MiJdLCBbImN1c3RvbWVyaWQiLCAiMTc3NDIyMzYxMjY2NjEyNDYzMTEyMTY1NzM1NzEyNDIyNzg3MTU0ODU4MjEyMDU4MDI3MDM5NjM5Njk2NjkyMjg0Mjc5ODEwNDQ2ODI0Njg4NTQxMjYyODI1OTQwMDQ4MjA1OTQ5NTE2NzM4MTQ4MzU5MTUxNTA4NzUwMzg0Nzg1NDIyMDAzMDAwODk4NjMwMTEyOTIzMzY0ODg1MTUwNzI1MzA5Nzc0NjI3NzU3NDUwNDQ0NTAzMjAwMDY4MDg5MzQ2MTM2MDQ0ODM3NDg3NzUxODM0MjIyMTc1Mjk1NjU3NzIzMDA2MzgwOTEzNDkzMDc3MTEyNDc4MDUzNzM5NTMyOTMwODU3MDQ1OTgwNzI5NzQxMzUwNDQ4NDc1MzkyOTM2MDA1NzE0Njc0MDQ5NDY1Mjc3MzEzMTIzMTQ5MjIwMDY3OTU4Njg1NDI0MTQ3NzkyNDc4NDUxMDExOTQ3ODc4Njg0OTMxOTkwMTk4MzEwMTY3NzcxOTE5NzY3ODA3NTc1Nzc3OTcwNjY5MzgyNTk4MjczMjU4MTAwNzkwOTcyMTgxMzU0NjMyODU1NjIzNzA2NDAyMzMzNzY5Mzc0Nzg3MTkwOTY0MTAyNTYyNjM0ODg2MjM5MDE5MjUxNjgxMTk2NTQwOTYyNTI0NjQ5MTY0MDY2NzMxMzAwNzgxNTM4MzExMzQ2ODUyMTg5OTQ2NzMyODM1Mjc2OTk1Nzc1NDc1MDQzNzk5NDc5NDE2NDMxNjI5NjUxMTYyODU0MDg4NzYwNjMzNTY5MzAyODYyNjAxNzkzMjUzNDg3NjU3NjU5NDQwMzM2NDI0OTQwNDc2NzE3MDUyOTM1NjU5NTIyNTIxNjU1NTA3NjA3MTM3NTkzMTI3NTIyNzkzMjAzMTcwNzM4NTIxMzM2NDAxNDQwMzk0NjU5Il1dfSwgIm5vbmNlIjogIjU1NjE3MDcyNzU2Mzc0NTcwMDczMTU2MSJ9"
        }
      }
    ]
  },
  "thread_id": "ea6ab74c-644e-4f83-ae4c-621e1dae8396",
  "auto_issue": true,
  "created_at": "2022-10-04 07:39:06.710048Z",
  "template_id": "be964034-cca8-4c54-9e9c-9168c362a474",
  "trace": false,
  "credential_exchange_id": "f1137a60-7f1a-439c-8994-90138a513463",
  "updated_at": "2022-10-04 07:39:12.003539Z",
  "auto_offer": false,
  "initiator": "self",
  "credential_proposal_dict": {
    "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/issue-credential/1.0/propose-credential",
    "@id": "b63b8542-2d45-4ac6-b668-4a83724e57b8",
    "comment": "Account transaction history",
    "credential_proposal": {
      "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/issue-credential/1.0/credential-preview",
      "attributes": [
        {
          "name": "Customer ID",
          "value": " "
        },
        {
          "name": "Customer name",
          "value": " "
        }
      ]
    },
    "cred_def_id": "2dgesABgg8hfvPoZVD2nAc:3:CL:3579:default"
  },
  "auto_remove": false,
  "credential_definition_id": "2dgesABgg8hfvPoZVD2nAc:3:CL:3579:default",
  "schema_id": "2dgesABgg8hfvPoZVD2nAc:2:Account transaction history:1.0.0"
}
```

### 7.0 ABC Bank creates data disclosure agreement from third-party data sharing data agreement

Perform [**HTTP POST** http://abc-bank.swagger.localhost/v1/data-disclosure-agreements?da_template_id={da_template_id}&publish_flag=true](http://abc-bank.swagger.localhost/api/doc#/Data%20Disclosure%20Agreements/post_v1_data_disclosure_agreements).

Sample response is given below.

```json
{
  "industry_sector": "retail",
  "publish_flag": "true",
  "da_template_version": "1.0.0",
  "data_disclosure_agreement": {
    "@context": [
      "https://raw.githubusercontent.com/decentralised-dataexchange/data-exchange-agreements/main/interface-specs/jsonld/contexts/dexa-context.jsonld",
      "https://w3id.org/security/v2"
    ],
    "@id": "4ca1fe82-12d9-4a53-8156-ac8c53e76ca1",
    "@type": [
      "DataDisclosureAgreement"
    ],
    "version": "1.0.0",
    "language": "en",
    "dataController": {
      "did": "did:sov:2dgesABgg8hfvPoZVD2nAc",
      "name": "The Retail Inc",
      "legalId": "did:sov:2dgesABgg8hfvPoZVD2nAc",
      "url": "https://retail.se/policy.html",
      "industrySector": "Retail"
    },
    "agreementPeriod": 30,
    "dataSharingRestrictions": {
      "policyUrl": "https://happyshoping.com/privacy-policy/",
      "jurisdiction": "Sweden",
      "industrySector": "Retail",
      "dataRetentionPeriod": 30,
      "geographicRestriction": "Europe",
      "storageLocation": "Europe"
    },
    "purpose": "Account transaction history",
    "purposeDescription": "Identify customer credibility.",
    "lawfulBasis": "consent",
    "personalData": [
      {
        "attributeId": "a601c468-4d26-41e1-8ad9-30eb16746751",
        "attributeName": "Customer ID",
        "attributeDescription": "Unique number assigned to a customer."
      },
      {
        "attributeId": "cca3db4d-2cf9-4c08-b5c1-4b86a65224ce",
        "attributeName": "Customer name",
        "attributeDescription": "Name of the customer"
      }
    ],
    "codeOfConduct": "https://happyshoping.com/privacy-policy/"
  },
  "state": "DEFINITION",
  "template_id": "4ca1fe82-12d9-4a53-8156-ac8c53e76ca1",
  "template_version": "1.0.0",
  "delete_flag": "false",
  "created_at": "2022-10-04 07:41:32.219803Z",
  "da_template_id": "be964034-cca8-4c54-9e9c-9168c362a474",
  "latest_version_flag": "true",
  "updated_at": "2022-10-04 07:41:32.219803Z"
}
```

### 8.0 ABC Bank publishes data disclosure agreement to marketplace

Perform [**HTTP POST** http://abc-bank.swagger.localhost/v1/data-disclosure-agreements/{dda_template_id}/marketplace/{marketplace_connection_id}](http://abc-bank.swagger.localhost/api/doc#/Data%20Disclosure%20Agreements/post_v1_data_disclosure_agreements).

Sample response is given below.

```json
{
  "state": "request",
  "dda": {
    "@context": [
      "https://raw.githubusercontent.com/decentralised-dataexchange/data-exchange-agreements/main/interface-specs/jsonld/contexts/dexa-context.jsonld",
      "https://w3id.org/security/v2"
    ],
    "@id": "4ca1fe82-12d9-4a53-8156-ac8c53e76ca1",
    "@type": [
      "DataDisclosureAgreement"
    ],
    "version": "1.0.0",
    "language": "en",
    "dataController": {
      "did": "did:sov:2dgesABgg8hfvPoZVD2nAc",
      "name": "The Retail Inc",
      "legalId": "did:sov:2dgesABgg8hfvPoZVD2nAc",
      "url": "https://retail.se/policy.html",
      "industrySector": "Retail"
    },
    "agreementPeriod": 30,
    "dataSharingRestrictions": {
      "policyUrl": "https://happyshoping.com/privacy-policy/",
      "jurisdiction": "Sweden",
      "industrySector": "Retail",
      "dataRetentionPeriod": 30,
      "geographicRestriction": "Europe",
      "storageLocation": "Europe"
    },
    "purpose": "Account transaction history",
    "purposeDescription": "Identify customer credibility.",
    "lawfulBasis": "consent",
    "personalData": [
      {
        "attributeId": "a601c468-4d26-41e1-8ad9-30eb16746751",
        "attributeName": "Customer ID",
        "attributeDescription": "Unique number assigned to a customer."
      },
      {
        "attributeId": "cca3db4d-2cf9-4c08-b5c1-4b86a65224ce",
        "attributeName": "Customer name",
        "attributeDescription": "Name of the customer"
      }
    ],
    "codeOfConduct": "https://happyshoping.com/privacy-policy/"
  },
  "template_id": "4ca1fe82-12d9-4a53-8156-ac8c53e76ca1",
  "connection_id": "8006bc9f-ad53-4e8a-a65e-4a72233b426e",
  "created_at": "2022-10-04 07:43:25.541619Z",
  "request_id": "5d21b567-ccad-4e9c-9023-fa72bbcbce19",
  "updated_at": "2022-10-04 07:43:25.541619Z"
}
```

### 9.0 Credit Reporting Agency visits Finance Marketplace

Perform [**HTTP GET** http://credit-reporting-agency.swagger.localhost/v1/data-marketplace/{marketplace_connection_id}/published-dda](http://credit-reporting-agency.swagger.localhost/api/doc#/Data%20Marketplace/get_v1_data_marketplace__connection_id__published_dda).

Sample response is given below.

```json
{
  "results": [
    {
      "dda": {
        "@context": [
          "https://raw.githubusercontent.com/decentralised-dataexchange/data-exchange-agreements/main/interface-specs/jsonld/contexts/dexa-context.jsonld",
          "https://w3id.org/security/v2"
        ],
        "@id": "4ca1fe82-12d9-4a53-8156-ac8c53e76ca1",
        "@type": [
          "DataDisclosureAgreement"
        ],
        "version": "1.0.0",
        "language": "en",
        "dataController": {
          "did": "did:sov:2dgesABgg8hfvPoZVD2nAc",
          "name": "The Retail Inc",
          "legalId": "did:sov:2dgesABgg8hfvPoZVD2nAc",
          "url": "https://retail.se/policy.html",
          "industrySector": "Retail"
        },
        "agreementPeriod": 30,
        "dataSharingRestrictions": {
          "policyUrl": "https://happyshoping.com/privacy-policy/",
          "jurisdiction": "Sweden",
          "industrySector": "Retail",
          "dataRetentionPeriod": 30,
          "geographicRestriction": "Europe",
          "storageLocation": "Europe"
        },
        "purpose": "Account transaction history",
        "purposeDescription": "Identify customer credibility.",
        "lawfulBasis": "consent",
        "personalData": [
          {
            "attributeId": "a601c468-4d26-41e1-8ad9-30eb16746751",
            "attributeName": "Customer ID",
            "attributeDescription": "Unique number assigned to a customer."
          },
          {
            "attributeId": "cca3db4d-2cf9-4c08-b5c1-4b86a65224ce",
            "attributeName": "Customer name",
            "attributeDescription": "Name of the customer"
          }
        ],
        "codeOfConduct": "https://happyshoping.com/privacy-policy/"
      },
      "template_id": "4ca1fe82-12d9-4a53-8156-ac8c53e76ca1",
      "industry_sector": "Retail",
      "connection_url": "http://abc-bank.localhost?c_i=eyJAdHlwZSI6ICJkaWQ6c292OkJ6Q2JzTlloTXJqSGlxWkRUVUFTSGc7c3BlYy9jb25uZWN0aW9ucy8xLjAvaW52aXRhdGlvbiIsICJAaWQiOiAiOWVjZmVjMTMtODJmZC00OTA2LTk4ZjUtZmYwZDBkZGQ3MWE4IiwgImltYWdlVXJsIjogImh0dHBzOi8vZGVtby1hcGkuaWdyYW50LmlvL3YxL29yZ2FuaXphdGlvbnMvNjAyMTU3MDc0NmJjN2YwMDAxNGVkNjYxL2ltYWdlLzYyOGY0YWFlNjkzZTljMDAwMTAyYmJkZi93ZWIiLCAicmVjaXBpZW50S2V5cyI6IFsiRXZSNmp0ZG9FamNyWmdTdWVaV1VWS0xEWmpzTUptRzFEd2hHeWNzWHRHOGoiXSwgInNlcnZpY2VFbmRwb2ludCI6ICJodHRwOi8vYWJjLWJhbmsubG9jYWxob3N0IiwgImxhYmVsIjogIlRoZSBSZXRhaWwgSW5jIn0=",
      "updated_at": "2022-10-04 07:43:26.576702Z",
      "created_at": "2022-10-04 07:43:26.576702Z"
    }
  ],
  "pagination": {
    "total_count": 1,
    "page": 1,
    "page_size": 100000,
    "total_pages": 1
  }
}
```

### 10.0 Credit Reporting Agency sign up data disclosure agreement from ABC Bank

Credit Reporting Agency connects with the ABC Bank using the `connection_url` obtained from marketplace.

Credit Reporting Agency receives the connection invitation from ABC Bank.

Perform [**HTTP POST** http://credit-reporting-agency.swagger.localhost/v2/connections/receive-invitation?auto_accept=true](http://credit-reporting-agency.swagger.localhost/api/doc#/connection/post_v2_connections_receive_invitation) with sample request body as given below.

```json
{
  "connection_url": "http://abc-bank.localhost?c_i=eyJAdHlwZSI6ICJkaWQ6c292OkJ6Q2JzTlloTXJqSGlxWkRUVUFTSGc7c3BlYy9jb25uZWN0aW9ucy8xLjAvaW52aXRhdGlvbiIsICJAaWQiOiAiOWVjZmVjMTMtODJmZC00OTA2LTk4ZjUtZmYwZDBkZGQ3MWE4IiwgImltYWdlVXJsIjogImh0dHBzOi8vZGVtby1hcGkuaWdyYW50LmlvL3YxL29yZ2FuaXphdGlvbnMvNjAyMTU3MDc0NmJjN2YwMDAxNGVkNjYxL2ltYWdlLzYyOGY0YWFlNjkzZTljMDAwMTAyYmJkZi93ZWIiLCAicmVjaXBpZW50S2V5cyI6IFsiRXZSNmp0ZG9FamNyWmdTdWVaV1VWS0xEWmpzTUptRzFEd2hHeWNzWHRHOGoiXSwgInNlcnZpY2VFbmRwb2ludCI6ICJodHRwOi8vYWJjLWJhbmsubG9jYWxob3N0IiwgImxhYmVsIjogIlRoZSBSZXRhaWwgSW5jIn0="
}
```


Sample response is given below.

```json
{
  "invitation_key": "EvR6jtdoEjcrZgSueZWUVKLDZjsMJmG1DwhGycsXtG8j",
  "my_did": "RjoVdr5RPxBkfFNv7MbivU",
  "their_label": "ABC Bank",
  "created_at": "2022-10-04 08:01:56.092524Z",
  "routing_state": "none",
  "initiator": "external",
  "invitation_mode": "once",
  "connection_id": "d3bb78df-916d-40b0-b2b4-b0623811ba48",
  "accept": "auto",
  "updated_at": "2022-10-04 08:01:56.145728Z",
  "request_id": "cf9e4e17-3a28-439f-abce-bd8ee429277c",
  "state": "request"
}
```

Credit Reporting Agency sign up the DDA from ABC Bank by performing [**HTTP POST** http://credit-reporting-agency.swagger.localhost/v1/data-disclosure-agreements/{dda_template_id}/request/connections/{data_source_connection_id}](http://credit-reporting-agency.swagger.localhost/api/doc#/Data%20Disclosure%20Agreements/post_v1_data_disclosure_agreements__template_id__request_connections__connection_id_)

### 11.0 Credit Reporting Agency pulls data from ABC Bank

Credit Reporting Agency queries the signed up DDA by performing [**HTTP GET** http://credit-reporting-agency.swagger.localhost/v1/auditor/data-disclosure-agreements/instances](http://credit-reporting-agency.swagger.localhost/api/doc#/Data%20Agreement%20-%20Auditor%20Functions/get_v1_auditor_data_disclosure_agreements_instances).

Sample response is give below.

```json
{
  "results": [
    {
      "created_at": "2022-10-04 08:06:47.208573Z",
      "industry_sector": "Retail",
      "data_disclosure_agreement": {
        "@context": [
          "https://raw.githubusercontent.com/decentralised-dataexchange/data-exchange-agreements/main/interface-specs/jsonld/contexts/dexa-context.jsonld",
          "https://w3id.org/security/v2"
        ],
        "@id": "637cb89b-399a-4bc0-8a95-cf6d622995d2",
        "@type": [
          "DataDisclosureAgreement"
        ],
        "version": "1.0.0",
        "templateId": "4ca1fe82-12d9-4a53-8156-ac8c53e76ca1",
        "templateVersion": "1.0.0",
        "language": "en",
        "dataController": {
          "did": "did:sov:2dgesABgg8hfvPoZVD2nAc",
          "name": "The Retail Inc",
          "legalId": "did:sov:2dgesABgg8hfvPoZVD2nAc",
          "url": "https://retail.se/policy.html",
          "industrySector": "Retail"
        },
        "agreementPeriod": 30,
        "dataSharingRestrictions": {
          "policyUrl": "https://happyshoping.com/privacy-policy/",
          "jurisdiction": "Sweden",
          "industrySector": "Retail",
          "dataRetentionPeriod": 30,
          "geographicRestriction": "Europe",
          "storageLocation": "Europe"
        },
        "purpose": "Account transaction history",
        "purposeDescription": "Identify customer credibility.",
        "lawfulBasis": "consent",
        "personalData": [
          {
            "attributeId": "a601c468-4d26-41e1-8ad9-30eb16746751",
            "attributeName": "Customer ID",
            "attributeDescription": "Unique number assigned to a customer."
          },
          {
            "attributeId": "cca3db4d-2cf9-4c08-b5c1-4b86a65224ce",
            "attributeName": "Customer name",
            "attributeDescription": "Name of the customer"
          }
        ],
        "codeOfConduct": "https://happyshoping.com/privacy-policy/",
        "dataUsingService": {
          "did": "did:sov:3Wcyfb5QZ7mvtBXrY8Jg3h",
          "name": "The Retail Inc",
          "legalId": "did:sov:3Wcyfb5QZ7mvtBXrY8Jg3h",
          "url": "https://retail.se/policy.html",
          "industrySector": "Retail",
          "usagePurposes": "Account transaction history",
          "jurisdiction": "Sweden",
          "withdrawal": "https://retail.se/policy.html",
          "privacyRights": "https://retail.se/policy.html",
          "signatureContact": "did:sov:3Wcyfb5QZ7mvtBXrY8Jg3h"
        },
        "proofChain": [
          {
            "id": "did:sov:2dgesABgg8hfvPoZVD2nAc#1",
            "type": "Ed25519Signature2018",
            "created": "2022-10-04T08:06:43.288433+00:00",
            "verificationMethod": "tc8yQSjm3hAz6rhdaswM25Phf3WrN2us8gNrUwamCoG",
            "proofPurpose": "authentication",
            "proofValue": "eyJhbGciOiAiRWREU0EiLCAiYjY0IjogZmFsc2UsICJjcml0IjogWyJiNjQiXX0..n3knIprwHcHleNiMkLY2g_zxJSOnUBHQglPjTphLoCHy8A87PSixDK0PMc0X6qePaY4YtownZ1F1U1r04aRHDQ"
          },
          {
            "id": "did:sov:3Wcyfb5QZ7mvtBXrY8Jg3h#1",
            "type": "Ed25519Signature2018",
            "created": "2022-10-04T08:06:47.163938+00:00",
            "verificationMethod": "2NNLz1PmcJ3s9gYzTa9aeYm5MAzW9xGKGpdzkH4mnpp1",
            "proofPurpose": "authentication",
            "proofValue": "eyJhbGciOiAiRWREU0EiLCAiYjY0IjogZmFsc2UsICJjcml0IjogWyJiNjQiXX0..B0Yfz-2qnwT0EQudqrVOmm2rCOK5x90gcsTW_rZHFj589bkwSRDwIjtnEayezulGFSQJYAevuu9RK0qfbUljBg"
          }
        ]
      },
      "delete_flag": "false",
      "template_id": "4ca1fe82-12d9-4a53-8156-ac8c53e76ca1",
      "connection_id": "d3bb78df-916d-40b0-b2b4-b0623811ba48",
      "updated_at": "2022-10-04 08:07:07.885870Z",
      "blockchain_receipt": {
        "blockHash": "0x6f79ad623d278f2f61542f801cb945b876aafcdcebb36345c1d6e1c152875748",
        "blockNumber": 11492182,
        "contractAddress": null,
        "cumulativeGasUsed": 12297620,
        "effectiveGasPrice": 1000000012,
        "from": "0x5a2A6cd61BdE850E73E32a457863d3AB3d16936C",
        "gasUsed": 29051,
        "logs": [
          {
            "address": "0x58c77570BaD99116169D4700BDf7b2Ed845fcf74",
            "blockHash": "0x6f79ad623d278f2f61542f801cb945b876aafcdcebb36345c1d6e1c152875748",
            "blockNumber": 11492182,
            "data": "0x0000000000000000000000005a2a6cd61bde850e73e32a457863d3ab3d16936c0000000000000000000000000000000000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000004e6469643a6d79646174613a7a414d724e4d50534a3133414178514c41324e45696f4b456274664b786a7566516d447a6e373650515739467633746456314d614a383131394133343738786a696d38000000000000000000000000000000000000",
            "logIndex": 24,
            "removed": false,
            "topics": [
              "0x0244fa209677670c0a1bc9a496e4366cc0fbb90f957fda7ad775d454d98a54d7"
            ],
            "transactionHash": "0x486d0603eefeb4341277a8f49e6d6d8ad13976d89e51accf979831d1f131180d",
            "transactionIndex": 11
          }
        ],
        "logsBloom": "0x00000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000204000000000000000000000000000004000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000800000000000000000000000000000000000000000000000",
        "status": 1,
        "to": "0x58c77570BaD99116169D4700BDf7b2Ed845fcf74",
        "transactionHash": "0x486d0603eefeb4341277a8f49e6d6d8ad13976d89e51accf979831d1f131180d",
        "transactionIndex": 11,
        "type": "0x2"
      },
      "blink": "blink:ethereum:rinkeby:0x486d0603eefeb4341277a8f49e6d6d8ad13976d89e51accf979831d1f131180d",
      "template_version": "1.0.0",
      "mydata_did": "did:mydata:zAMrNMPSJ13AAxQLA2NEioKEbtfKxjufQmDzn76PQW9Fv3tdV1MaJ8119A3478xjim8",
      "state": "CAPTURE",
      "instance_id": "637cb89b-399a-4bc0-8a95-cf6d622995d2",
      "permissions": []
    }
  ],
  "pagination": {
    "total_count": 1,
    "page": 1,
    "page_size": 10,
    "total_pages": 1
  }
}
```

Credit Reporting Agency proceeds to pull data for the DDA by performing [**HTTP POST** http://credit-reporting-agency.swagger.localhost/v1/data-disclosure-agreements/instances/{dda_instance_id}/pulldata](http://credit-reporting-agency.swagger.localhost/api/doc#/Data%20Disclosure%20Agreements/post_v1_data_disclosure_agreements_instances__instance_id__pulldata).

Released access token can be obtained by querying pull data records for the DDA instance.

Perform [**HTTP GET** http://credit-reporting-agency.swagger.localhost/v1/auditor/data-disclosure-agreements/pulldata-records?dda_instance_id={dda_instance_id}](http://credit-reporting-agency.swagger.localhost/api/doc#/Data%20Agreement%20-%20Auditor%20Functions/get_v1_auditor_data_disclosure_agreements_pulldata_records).

Sample response is given below.


```json
{
  "results": [
    {
      "created_at": "2022-10-04 08:11:13.996470Z",
      "token": "eyJhbGciOiAiRWREU0EiLCAidHlwZSI6ICJKV1QifQ.eyJpYXQiOiAxNjY0ODcxMDc0LCAiZXhwIjogMTY2NDg3ODI3NCwgImRkYV9pbnN0YW5jZV9pZCI6ICI2MzdjYjg5Yi0zOTlhLTRiYzAtOGE5NS1jZjZkNjIyOTk1ZDIiLCAibm9uY2UiOiAiMzA1NjgxMjY2NDcxODA1NzI4ODkzNDQ2In0.uu0oqlMyoyTqj5WbksuM02Ff3QgBaWtbk8-a7q4vGUAWzc06KK5a67hwopHaRPJz_erpdvEyJYaSj2J0ZulZBA",
      "updated_at": "2022-10-04 08:11:32.457820Z",
      "nonce": "305681266471805728893446",
      "dda_instance_id": "637cb89b-399a-4bc0-8a95-cf6d622995d2",
      "state": "response",
      "token_packed": {
        "protected": "eyJlbmMiOiJ4Y2hhY2hhMjBwb2x5MTMwNV9pZXRmIiwidHlwIjoiSldNLzEuMCIsImFsZyI6IkF1dGhjcnlwdCIsInJlY2lwaWVudHMiOlt7ImVuY3J5cHRlZF9rZXkiOiI5aGZ3NnBmdzBJa0dWTXBPODlvbTdDMDUyVkh1OW84Q3o5WnN0alJVT0tXMHE1M2xYNVJ3MmIyNTN6T3g5Zi1jIiwiaGVhZGVyIjp7ImtpZCI6IkVWMXVlRXJRZ0VjSlRBc01vWHRLOFVUQlBjdlp4bXBKajYxMXZwVml3b01aIiwiaXYiOiI3cFZaSG90eXVNaU5PSno3dW5sLUkySzVManoycDd2aCIsInNlbmRlciI6IllGS0MyMUJPUm40N0djcFJsN09US1RhX2V3YmNQM0NUc3hUajNNQXQxREg4UXpGeWtBbWpDc19vUmVHdVJLV3lTRVJscUJqamdyMHRCZGdJMnJzM1dyU1FYeGtLU1VBZFBEdjBJclkwLU9hbG9DNm5FREQ2UmR3dTVFbz0ifX1dfQ==",
        "iv": "JiREiBRXR0CSWN_N",
        "ciphertext": "dgkXOSlXDGKzLo3oxXbztXJlpZrn-OPiVOpVrk5YU9qJTX-xOsMLRf7SJPu41HrVN1NSSZQUHs95KdP4Im2Tq03nPNnt-uV1GVFa_DfmslJcD9i7JMMTP-YJ0UR2KDFkyzuD_mjSO9E49yh9Xfx9Ku2UxwvwVFBN6X-5XFqP-TZV8-f5gbLhtzwhD-sT1QPOlblOhPiqq5uNhkr8KegBdUkbeSorBJ21w7snIqc5VJI_O8KJYGnb2UD1N81IFtHUoZIR1W5lomBySbnmwqZkyNgMT9qAmZ_KuskEO05l43TH70T_VYaKG9W023U3NmMca1PoSS6V8YB1bd_b7x0OwMtAQTJYaliJWN-Kz-LijiLJLikkPs7HyqcQ558OzjLHxEbjGLtHBceuxeFIyrqvI81T31HM",
        "tag": "5q5qY8Fix61iPg-ml1ReiQ=="
      },
      "dda_template_id": "4ca1fe82-12d9-4a53-8156-ac8c53e76ca1"
    }
  ],
  "pagination": {
    "total_count": 1,
    "page": 1,
    "page_size": 10,
    "total_pages": 1
  }
}
```
