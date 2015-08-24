server-enterprise:
	docker build -t zmre/couchbase-enterprise-ubuntu:3.0.1 enterprise/couchbase-server

server-enterprise-run:
	a=`docker run -m 4000000000 --ulimit nofile=40960:40960 --ulimit core=100000000:100000000 --ulimit memlock=100000000:100000000 -p 8091:8091 -p 8092:8092 -p 8093:8093 -p 11207:11207 -p 11210:11210 -p 11211:11211 -p 18091:18091 -p 18092:18092 -h couchbase.local -d zmre/couchbase-enterprise-ubuntu:3.0.1` ; docker exec -it $$a bash -il ; docker stop $$a

all: server-enterprise
