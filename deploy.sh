docker build -t sarahwbs/multi-client:latest -t sarahwbs/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sarahwbs/multi-server:latest -t sarahwbs/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sarahwbs/multi-worker:latest -t sarahwbs/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push sarahwbs/multi-client:latest
docker push sarahwbs/multi-server:latest
docker push sarahwbs/multi-worker:latest
docker push sarahwbs/multi-client:$SHA
docker push sarahwbs/multi-server:$SHA
docker push sarahwbs/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployment/server-deployment server=sarahwbs/multi-server:$SHA
kubectl set image deployment/client-deployment client=sarahwbs/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=sarahwbs/multi-worker:$SHA
