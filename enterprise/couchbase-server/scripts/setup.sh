#!/bin/sh

admin_user=Administrator
admin_password=cb1234
bucket_name=default
bucket_ram_quota=1196
index_ram_quota=256
cluster_ram_quota=1196
num_replicas=0
num_threads=3

# Initialize Node
curl -v -X POST http://127.0.0.1:8091/nodes/self/controller/settings \
  --data-urlencode path=/opt/couchbase/var/lib/couchbase/data \
  --data-urlencode index_path=/opt/couchbase/var/lib/couchbase/data

# Name the host
curl -v -X POST http://127.0.0.1:8091/node/controller/rename \
  -d hostname=127.0.0.1

# Setup Services
curl -v -X POST http://127.0.0.1:8091/node/controller/setupServices \
  --data-urlencode "services=kv"


# Setup bucket memory
curl -v -X POST http://127.0.0.1:8091/pools/default \
  -d memoryQuota=${cluster_ram_quota}

# Setup default bucket
curl -v -X POST http://127.0.0.1:8091/pools/default/buckets \
  -d flushEnabled=1 \
  -d ramQuotaMB=${bucket_ram_quota} \
  -d name="${bucket_name}" \
  -d replicaIndex=0 \
  -d evictionPolicy=valueOnly \
  -d replicaNumber=${num_replicas} \
  -d threadsNumber=${num_threads} \
  -d authType=sasl \
  -d saslPassword=
# -d bucketType=membase
# -u ${admin_user}:${admin_password}

# Setup Administrator username and password
curl -v -X POST http://127.0.0.1:8091/settings/web \
  --data-urlencode password="${admin_password}" \
  --data-urlencode username="${admin_user}" \
  -d port=SAME

sleep 5

