#!/bin/bash
set -e

RELEASE='v3.11'
DEPLOYMENT_TYPE='openshift-enterprise'

if [ $RELEASE = "v3.11" ]; then
    export IMAGES="registry.access.redhat.com/openshift3/apb-base
    registry.access.redhat.com/openshift3/apb-tools
    registry.access.redhat.com/openshift3/csi-attacher
    registry.access.redhat.com/openshift3/csi-driver-registrar
    registry.access.redhat.com/openshift3/csi-livenessprobebash
    registry.access.redhat.com/openshift3/csi-provisioner
    registry.access.redhat.com/openshift3/image-inspector
    registry.access.redhat.com/openshift3/local-storage-provisioner
    registry.access.redhat.com/openshift3/manila-provisioner
    registry.access.redhat.com/openshift3/ose-ansible
    registry.access.redhat.com/openshift3/ose-cli
    registry.access.redhat.com/openshift3/ose-cluster-capacity
    registry.access.redhat.com/openshift3/ose-deployer
    registry.access.redhat.com/openshift3/ose-descheduler
    registry.access.redhat.com/openshift3/ose-docker-builder
    registry.access.redhat.com/openshift3/ose-docker-registry
    registry.access.redhat.com/openshift3/ose-egress-dns-proxy
    registry.access.redhat.com/openshift3/ose-egress-http-proxy
    registry.access.redhat.com/openshift3/ose-egress-router
    registry.access.redhat.com/openshift3/ose-f5-router
    registry.access.redhat.com/openshift3/ose-haproxy-router
    registry.access.redhat.com/openshift3/ose-hyperkube
    registry.access.redhat.com/openshift3/ose-hypershift
    registry.access.redhat.com/openshift3/ose-keepalived-ipfailover
    registry.access.redhat.com/openshift3/ose-pod
    registry.access.redhat.com/openshift3/ose-node-problem-detector
    registry.access.redhat.com/openshift3/ose-recycler
    registry.access.redhat.com/openshift3/ose-web-console
    registry.access.redhat.com/openshift3/ose-node
    registry.access.redhat.com/openshift3/ose-control-plane
    registry.access.redhat.com/openshift3/registry-console
    registry.access.redhat.com/openshift3/snapshot-controller
    registry.access.redhat.com/openshift3/snapshot-provisioner
    registry.access.redhat.com/openshift3/ose-service-catalog
    registry.access.redhat.com/openshift3/ose-ansible-service-broker
    registry.access.redhat.com/openshift3/mariadb-apb
    registry.access.redhat.com/openshift3/mediawiki-apb
    registry.access.redhat.com/openshift3/mysql-apb
    registry.access.redhat.com/openshift3/ose-template-service-broker
    registry.access.redhat.com/openshift3/postgresql-apb
    registry.access.redhat.com/rhel7/etcd:3.2.22"

    export IMAGES_OPTIONAL="registry.redhat.io/openshift3/ose-logging-curator5
    registry.redhat.io/openshift3/ose-logging-elasticsearch5
    registry.redhat.io/openshift3/ose-logging-eventrouter
    registry.redhat.io/openshift3/ose-logging-fluentd
    registry.redhat.io/openshift3/ose-logging-kibana5
    registry.redhat.io/openshift3/metrics-cassandra
    registry.redhat.io/openshift3/metrics-hawkular-metrics
    registry.redhat.io/openshift3/metrics-hawkular-openshift-agent
    registry.redhat.io/openshift3/metrics-heapster
    registry.redhat.io/openshift3/oauth-proxy
    registry.redhat.io/openshift3/ose-metrics-schema-installer
    registry.redhat.io/openshift3/prometheus
    registry.redhat.io/openshift3/prometheus-alert-buffer
    registry.redhat.io/openshift3/prometheus-alertmanager
    registry.redhat.io/openshift3/prometheus-node-exporter"

else

    export IMAGES="registry.redhat.io/openshift3/apb-base
    registry.redhat.io/openshift3/apb-tools
    registry.redhat.io/openshift3/automation-broker-apb
    registry.redhat.io/openshift3/csi-attacher
    registry.redhat.io/openshift3/csi-driver-registrar
    registry.redhat.io/openshift3/csi-livenessprobe
    registry.redhat.io/openshift3/csi-provisioner
    registry.redhat.io/openshift3/grafana
    registry.redhat.io/openshift3/image-inspector
    registry.redhat.io/openshift3/mariadb-apb
    registry.redhat.io/openshift3/mediawiki
    registry.redhat.io/openshift3/mediawiki-apb
    registry.redhat.io/openshift3/mysql-apb
    registry.redhat.io/openshift3/ose-ansible
    registry.redhat.io/openshift3/ose-ansible-service-broker
    registry.redhat.io/openshift3/ose-cli
    registry.redhat.io/openshift3/ose-cluster-autoscaler
    registry.redhat.io/openshift3/ose-cluster-capacity
    registry.redhat.io/openshift3/ose-cluster-monitoring-operator
    registry.redhat.io/openshift3/ose-console
    registry.redhat.io/openshift3/ose-configmap-reloader
    registry.redhat.io/openshift3/ose-control-plane
    registry.redhat.io/openshift3/ose-deployer
    registry.redhat.io/openshift3/ose-descheduler
    registry.redhat.io/openshift3/ose-docker-builder
    registry.redhat.io/openshift3/ose-docker-registry
    registry.redhat.io/openshift3/ose-efs-provisioner
    registry.redhat.io/openshift3/ose-egress-dns-proxy
    registry.redhat.io/openshift3/ose-egress-http-proxy
    registry.redhat.io/openshift3/ose-egress-router
    registry.redhat.io/openshift3/ose-haproxy-router
    registry.redhat.io/openshift3/ose-hyperkube
    registry.redhat.io/openshift3/ose-hypershift
    registry.redhat.io/openshift3/ose-keepalived-ipfailover
    registry.redhat.io/openshift3/ose-kube-rbac-proxy
    registry.redhat.io/openshift3/ose-kube-state-metrics
    registry.redhat.io/openshift3/ose-metrics-server
    registry.redhat.io/openshift3/ose-node
    registry.redhat.io/openshift3/ose-node-problem-detector
    registry.redhat.io/openshift3/ose-operator-lifecycle-manager
    registry.redhat.io/openshift3/ose-pod
    registry.redhat.io/openshift3/ose-prometheus-config-reloader
    registry.redhat.io/openshift3/ose-prometheus-operator
    registry.redhat.io/openshift3/ose-recycler
    registry.redhat.io/openshift3/ose-service-catalog
    registry.redhat.io/openshift3/ose-template-service-broker
    registry.redhat.io/openshift3/ose-web-console
    registry.redhat.io/openshift3/postgresql-apb
    registry.redhat.io/openshift3/registry-console
    registry.redhat.io/openshift3/snapshot-controller
    registry.redhat.io/openshift3/snapshot-provisioner
    registry.redhat.io/rhel7/etcd:3.2.22"

    export IMAGES_OPTIONAL="registry.access.redhat.com/openshift3/logging-auth-proxy
    registry.access.redhat.com/openshift3/logging-curator
    registry.access.redhat.com/openshift3/logging-elasticsearch
    registry.access.redhat.com/openshift3/logging-eventrouter
    registry.access.redhat.com/openshift3/logging-fluentd
    registry.access.redhat.com/openshift3/logging-kibana
    registry.access.redhat.com/openshift3/oauth-proxy
    registry.access.redhat.com/openshift3/metrics-cassandra
    registry.access.redhat.com/openshift3/metrics-hawkular-metrics
    registry.access.redhat.com/openshift3/metrics-hawkular-openshift-agent
    registry.access.redhat.com/openshift3/metrics-heapster
    registry.access.redhat.com/openshift3/metrics-schema-installer
    registry.access.redhat.com/openshift3/prometheus
    registry.access.redhat.com/openshift3/prometheus-alert-buffer
    registry.access.redhat.com/openshift3/prometheus-alertmanager
    registry.access.redhat.com/openshift3/prometheus-node-exporter"

fi

for IMAGE in $IMAGES; do podman pull "$IMAGE:$RELEASE";done
for IMAGE in $IMAGES_OPTIONAL; do podman pull "$IMAGE:$RELEASE";done

IMAGES_TARBALL="$DEPLOYMENT_TYPE-$RELEASE.tar"
IMAGES_TARBALL_OPTIONAL="$DEPLOYMENT_TYPE-$RELEASE-OPTIONAL.tar"

if [ ! -e "$IMAGES_TARBALL" ]; then
    podman save -o $IMAGES_TARBALL $IMAGES
fi

if [ ! -e "$IMAGES_TARBALL_OPTIONAL" ]; then
    podman save -o $IMAGES_TARBALL_OPTIONAL $IMAGES_OPTIONAL
fi