1. In EKS Auto Scaling Groups is already created by the node group
2. Now create custom policy and attach to Node Group IAM Role
3. Deploy K8s Autoscaler.

### Custom Policy through JSON Document named "node-group-autoscale-policy":
```json
	{
	  "Version": "2012-10-17", 
	  "Statement":[ 
		  { "Action": [ 
				 "autoscaling: DescribeAutoScalingGroups",  
				 "autoscaling: DescribeAutoScaling Instances", 
				 "autoscaling: DescribeLaunchConfigurations",  
				 "autoscaling: DescribeTags", 
				 "autoscaling: SetDesired Capacity", 
				 "autoscaling: TerminateInstanceInAutoScalingGroup", 
				 "ec2: DescribeLaunchTemplateVersions"
			  ],
			  "Resource": "*",
			  "Effect": "Allow" 
		  }
	   ]

	}
```


### Now attach to our previous created eks-node-group-role IAM role-> search with "name node-group-autoscale-policy" and attach 


## Deploy cluster autoscaler component in cmd:
``` kubectl apply -f https://raw.githubusercontent.com/kubernetes/autoscaler/master/cluster-autoscaler/cloudprovider/aws/examples/cluster-autoscaler-autodiscover.yaml ```


- kubectl get deployment -n kube-system cluster-autoscaler

- kubectl edit deployment -n kube-system cluster-autoscaler

 **---**  first added below the annotaions: deployment.kubernetes.io/revision: "1" below:
	add this line:

```cluster-autoscaler.kubernetes.io/safe-to-evict= "false"
	edit <YOUR CLUSTER NAME> to your real cluster name

	and change the cluster-autoscaler:v1.26.2 this version to your current cluster-autoscaler version 
```

-- now save this yaml file

-  kubectl get pods -n kube-system --------- here you will see cluster-autoscaler pod
- kubectl get pods cluster-autoscaler-full-path -n kube-system -o wide
- kubeclt logs -n kube-system cluster-autoscaler-full-path as logs.txt



**---** For checking the autoscaling is working or not first create nging deployment with 1 replica which has 1 node after that add 20 replica which has maximum size 3 node.
Nginx yaml file with deployment and service:

### nginx-deployment.yaml:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 1        # after create, edit: kubectl edit deployment nginx-deployment this with 20
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx
        ports:
        - containerPort: 80

---
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  ports:
  - port: 80
    targetPort: 80
    protocol: TCP
  selector:
    app: nginx
  type: LoadBalancer
```



- kubectl get pod

- kubectl get svc 

- kubeclt logs -n kube-system cluster-autoscaler-full-path -f

- kubectl get nodes
