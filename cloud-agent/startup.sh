aca-py start \
    -it http 0.0.0.0 80 \
    -ot http \
    -e $ACAPY_ENDPOINT \
    --label $AGENT_NAME \
    --admin 0.0.0.0 8001 \
    --admin-insecure-mode \
    --auto-accept-requests --auto-ping-connection \
    --auto-respond-credential-proposal --auto-respond-credential-offer --auto-respond-credential-request --auto-store-credential \
    --auto-respond-presentation-proposal --auto-respond-presentation-request --auto-verify-presentation \
    --genesis-url $GENESIS_URL \
    --wallet-type indy \
    --wallet-name $AGENT_NAME \
    --webhook-url $WEBHOOK_URL \
    --wallet-key qwerty123