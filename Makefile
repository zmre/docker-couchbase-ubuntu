server-enterprise:
	docker build -t zmre/couchbase-server-enterprise-ubuntu:4.0.0-beta enterprise/couchbase-server

server-enterprise-run:
	a=`docker run -p 8091:8091 -h couchbase -d zmre/couchbase-server-enterprise-ubuntu:4.0.0-beta` ; docker exec -it $$a bash -il ; docker stop $$a

all: server-enterprise
