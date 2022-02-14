# terrajet-scale

This repository contains scripts and other tools that are used to conduct experiments reported in https://github.com/crossplane/terrajet/issues/55. 
Example invocation:
```bash
cd scripts
 ./manage-mr.sh create ./virtualnetwork.yaml $(seq 1 10) | tee exp-virtualnetwork.log
```

The first argument is the `kubectl` operation to be run. The `manage-mr.sh` script runs a `kubectl <operation> -f -` using the specified operation, so any `kubectl` command that accepts a `-f` argument should be fine such as `create`, `apply` or `delete`. 

The second argument is a resource template. An example resource template is as follows:
```yaml
apiVersion: network.azure.jet.crossplane.io/v1alpha2
kind: VirtualNetwork
metadata:
  name: test-{{SUFFIX}}
spec:
  forProvider:
    addressSpace:
    - 10.0.0.0/16
    dnsServers:
    - 10.0.0.1
    - 10.0.0.2
    - 10.0.0.3
    location: East US
    resourceGroupName: example
    tags:
      experiment: "2"
  providerConfigRef:
    name: example
```

The `manage-mr.sh` script replaces the string `{{SUFFIX}}` in this template with each subsequent argument and runs a `kubectl <command>` using the replaced resource manifest.