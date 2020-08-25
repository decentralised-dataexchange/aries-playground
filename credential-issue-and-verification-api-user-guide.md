# Introduction
This describes the API call flows during a verified data exchange process using hyperledger Indy as the distributed ledger registry and hyperldge aries agent for client application. 

The indy network is up and running at https://indy.igrant.io/. The aries agents are connected to this network and configured locally as described [here](https://github.com/decentralised-dataexchange/aries-playground/blob/master/README.md). Executing the sequence of operations described creates the reference system described [below](#Reference sytem).

# Reference system
In our reference implementation, we have the individual (Alice) holding her health data in her wallet app issued by a health test center. This health data could be used by Alice to prove her health status to a travel company. The legal entity ensures that the test center follows the schema and governance. 

![](reference-solution.png)

Once the reference system is up and running you can start 3 terminals and monitor their logs by executing the docker container logs given below:

| Agent  | Swagger API endpoint admin UI | 
| ------------- | ------------- | 
| Test Center | `docker exec -it agent1.webhook tail -f demo.log`| 
| Alice (Data4Life User) | `docker exec -it agent2.webhook tail -f demo.log` | 
| Travel Company | `docker exec -it agent3.webhook tail -f demo.log`| 

In your browser you can start three tabs to execute the APIs using swagger.

| Agent  | Swagger API endpoint admin UI | 
| ------------- | ------------- | 
| Test Center | [agent1.swagger.localhost](agent1.swagger.localhost) | 
| Alice (Data4Life User) | [agent2.swagger.localhost](agent2.swagger.localhost) | 
| Travel Company | [agent3.swagger.localhost](agent3.swagger.localhost) | 

# Schema definition by a legal entity
On [Test Center Agent](agent1.swagger.localhost), you can execute the schema definiton API to register the schema in the ledger. Ideally this is defined by a legal entity or a standardisation body.

Sends a schema to the ledger with the API `POST: ​/schemas` with the json body as given:
	    
    {
      "schema_version": "1.0",
	   "schema_name": "Covid-19 Test Results",
	   "attributes": [
	     		"testResult",
	     		"testDate"
      		]	
     }

Try out on your local machine at: [http://agent1.swagger.localhost/api/doc#/schema/post_schemas](http://agent1.swagger.localhost/api/doc#/schema/post_schemas)

# Establish connection 

Here, the Test Center and Data4Life-User agents establishes connection with each other. Following are the API call sequence:

1. Create a new invitation (by Test Center)

	`POST ​/connections​/create-invitation`
	
	This generates the `connection_id` and `invitation`.
	
	    {
	     "connection_id": "e18c5108-4040-4a1e-b994-e80eaab5e3d2",
	     "invitation": {
	       "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/connections/1.0/invitation",
	       "@id": "903fc685-0463-4f92-93ff-43dbdbfb1297",
	       "serviceEndpoint": "http://agent1.localhost",
	       "recipientKeys": [
	           "7eCdJgj5r5ZjGYqVJYGTjdjFqxNnP3oWxYseagPoB1gg"
	        ],
	       "label": "Travel-Company"
	     },
	     "invitation_url": "http://agent3.localhost?c_i=eyJAdHlwZSI6ICJkaWQ6c292OkJ6Q2JzTlloTXJqSGlxWkRUVUFTSGc7c3BlYy9jb25uZWN0aW9ucy8xLjAvaW52aXRhdGlvbiIsICJAaWQiOiAiOTAzZmM2ODUtMDQ2My00ZjkyLTkzZmYtNDNkYmRiZmIxMjk3IiwgInNlcnZpY2VFbmRwb2ludCI6ICJodHRwOi8vYWdlbnQzLmxvY2FsaG9zdCIsICJyZWNpcGllbnRLZXlzIjogWyI3ZUNkSmdqNXI1WmpHWXFWSllHVGpkakZxeE5uUDNvV3hZc2VhZ1BvQjFnZyJdLCAibGFiZWwiOiAiVHJhdmVsLUNvbXBhbnkifQ=="
	    }
	    	
	Try out on your local machine at: [http://agent3.swagger.localhost/api/doc#/connection/post_connections_create_invitation](http://agent3.swagger.localhost/api/doc#/connection/post_connections_create_invitation)

2.	Receive a new connection invitation by Data4Life-User with the connection_id.

	`POST ​/connections​/receive-invitation` with the invitation invitation json (shown below) generated in step 1 as input. 
	
		`{
	      "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/connections/1.0/invitation",	      "@id": "903fc685-0463-4f92-93ff-43dbdbfb1297",
	      "serviceEndpoint": "http://agent1.localhost",
	      "recipientKeys": [
	           "7eCdJgj5r5ZjGYqVJYGTjdjFqxNnP3oWxYseagPoB1gg"
	        ],
	      "label": "Travel-Company"
	  	}`

3. Accept a stored connection invitation by Data4Life-user

	`POST ​/connections​/{conn_id}​/accept-invitation` passing the `connection_id` as input.

Check both Test Center Agent and Alice Agent by `GET /connections `and both are in `Active` status

After the secured connection is established between the two agents, the Test Center first establishes the connection with Alice. After that the Test Center issues credential to them with their own personal data. Alice then is able to see the credential in her Data4Life wallet.

# Credenial issuance by the issuer (Test Center)

Here, a credential is issued by the Test Center based on a standard scehma earlier defined by the legal entity.  

1. Create a local DID for the test center and make it public by publishing it to the ledger 
	
	`POST ​/wallet​/did​/create`
	
	This generates the DID and verification key which now is registered 
	![](indy-screenshot.png)

2. Repeat step 1 to create DID for the Data4Life-User and publish it to the ledger to make it public. 

3. Now, based on the schema, Test Center creates a credential definition to the ledger.
	
	An example scheme ID and name is as given. Please use the ones that were created during schema defintion or pick one from indy ledger.

	Schema ID: PWr9PACurgoMwowC5Bx8RD:2:Covid-19 Test Results:1.0
	Schema Name: Covid-19 Test Results:1.0
	
	`POST method /credential-definitions` sends a credential definition to the ledger 
	
	**NOTE:** Make sure revocation is false in the paylod example as given below: 
	
	    {
		  "revocation_registry_size": 0,
		  "support_revocation": false,
		  "schema_id": "PWr9PACurgoMwowC5Bx8RD:2:Covid-19 Test Results:1.0",
		  "tag": "default"
		 }`
		
4. Test Center now issues the credenital to the holder Alice (Data4Life-user
	
	`POST	​/issue-credential​/send`
	
	with auto_remove set to FALSE
	
	    { 
	     "schema_name": "Covid-19 Test Results",
	     "schema_version": "1.0",
	     "cred_def_id": "PWr9PACurgoMwowC5Bx8RD:3:CL:19:default",
	     "auto_remove": false,
	     "comment": "string",
	     "connection_id": "a8ea680f-0704-4327-99b8-02e5e3d03ea4",
	     "trace": false,
	     "schema_issuer_did": "PWr9PACurgoMwowC5Bx8RD",
	     "schema_id": "PWr9PACurgoMwowC5Bx8RD:2:Covid-19 Test Results:1.0",
	     "issuer_did": "PWr9PACurgoMwowC5Bx8RD",
	     "credential_proposal": {
	     "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/issue-credential/1.0/credential-preview",
	     "attributes": [
	        {
	          "name": "testDate",
	          "mime-type": "text/plain",
	          "value": "22-Aug-2020"
	        },
	        {
	          "name": "testResult",
	          "mime-type": "text/plain",
	          "value": "negative"
	        }
	      ]
	     }
	    }

# Alice stores credential into a personal wallet (Data4Life)

Alice, the Data4Life-User, now stores the received credentials

`	POST ​/issue-credential​/records​/{cred_ex_id}​/store`


# Proof presentation by Alice to verifier (Travel Company)

Before any communication happens between Alice (Data4Life-User) and the verifier, a secured connection is established between two agents. After that Travel Company issues a proof request to Alice, showing what type of proof is needed to qualify in order for Alice to travel using the Covid-19 test result. Alice will build the proof based on the credential in her Data4Life wallet. Alice then sends the proof to the travel company which will observe the result.

1. Establish connection

	Travel Company Agent: `POST /connections/create-invitation`, from the response get the invitation object (from `{ to }`) showns earlier during the connection between Test Center and Alice.

	Alice Agent: `POST /connections/receive-invitation` with the invitation object
   
   Check both Travel Company Agent and Alice Agent by `GET /connections `and both are in `Active` status

2. In this demo, the Proof request details the Test Center is asking for is

    	testResult
    	testDate

    all items follows the Credential Definition specified by the ID
    
    `POST /present-proof/send-request` is called with the following payload (example)


	    {
	      "connection_id": "a8ea680f-0704-4327-99b8-02e5e3d03ea4",
	      "comment": "Ready to travel",
	      "proof_request": {
	      "name": "Proof of COVID19 Negative",
	      "version": "1.0",
	      "requested_attributes": {
	      "0_testresult_uuid": {
	        "name": "testResult",
	        "restrictions": [
	          {
	            "cred_def_id": "PWr9PACurgoMwowC5Bx8RD:3:CL:19:default"
	          }
	        ]
	       },
	       {
	       "0_testdate_uuid": {
	        "name": "testDate",
	        "restrictions": [
	          {
	            "cred_def_id": "PWr9PACurgoMwowC5Bx8RD:3:CL:19:default"
	          }
	        ]
	       }
	     },
	     "requested_predicates": {}
	    }
	  }
   
   Using the requested_predicates, you can do some assertions, example, the testDate shall be less than 2 days from today. 
   
   In the webhook interceptor, you can view the sequence of events happening:

	* receiving the proof request
	* checking credentials
	* generating proof
	* sending proof to Travel Company
   
3. From Travel Company, we can use `GET /present-proof/records` to see the proof sent by Alice. The `presentation_exchange_id` is the identifier of the presentation proof and state will tell you the current status of the presented proof.

4. Finally Travel Company use `POST /present-proof/{pres-ex-id}/verify-presentation` to see Alice’s proof presentation.

# References
[1] [Setting up indy network and agents](https://github.com/decentralised-dataexchange/aries-playground/blob/master/README.md) 
