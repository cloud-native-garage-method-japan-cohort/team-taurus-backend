#!/bin/sh
kubectl create sa build-bot

kubectl patch serviceaccount build-bot \
    -p '{"secrets": [{"name": "quay-io-team-taurus-backend-password"}]}'
kubectl patch serviceaccount build-bot \
    -p '{"imagePullSecrets": [{"name": "quay-io-team-taurus-backend-password"}]}'

kubectl get sa \
    -n team-taurus-backend \
    build-bot -o yaml

oc policy add-role-to-user cluster-admin \
    -z build-bot
