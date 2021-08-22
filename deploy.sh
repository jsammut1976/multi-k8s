docker build -t jsammut/multi-client:latest -t jsammut/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jsammut/multi-server:latest -t jsammut/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jsammut/multi-worker:latest -t jsammut/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push jsammut/multi-client:latest
docker push jsammut/multi-server:latest
docker push jsammut/multi-worker:latest
docker push jsammut/multi-client:$SHA
docker push jsammut/multi-server:$SHA
docker push jsammut/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jsammut/multi-server:$SHA
kubectl set image deployments/client-deployment client=jsammut/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jsammut/multi-worker:$SHA
