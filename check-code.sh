if ! kubectl get pvc | grep web-data-pvc
then
    kubectl apply -f /root/devops-task6/devops-task6-pull-code/K8s-resource-yml/pvc.yml
fi

if ! kubectl get svc | grep web-svc
then
    kubectl apply -f /root/devops-task6/devops-task6-pull-code/K8s-resource-yml/svc.yml
fi

if ls /root/devops-task6/devops-task6-pull-code/*.* | grep html
then
	echo "file"
	if ! kubectl get pods | grep httpd-deployment | grep Running
    then
        echo "apply"
        kubectl apply -f /root/devops-task6/devops-task6-pull-code/K8s-resource-yml/httpd.yml
        sleep 30
        pod_name=$(kubectl get pods -o=jsonpath='{.items[0].metadata.name}')
        kubectl cp /root/devops-task6/devops-task6-pull-code/*.html  $pod_name:/var/www/html
    else
        pod_name=$(kubectl get pods -o=jsonpath='{.items[0].metadata.name}')
        kubectl cp /root/devops-task6/devops-task6-pull-code/*.html  $pod_name:/var/www/html
    fi
elif ls /root/devops-task6/devops-task6-pull-code/*.* | grep php
then
	echo "file"
	if ! kubectl get pods | grep php-deployment | grep Running
    then
        echo "apply"
        kubectl apply -f /root/devops-task6/devops-task6-pull-code/K8s-resource-yml/php.yml
        sleep 30
        pod_name=$(kubectl get pods -o=jsonpath='{.items[0].metadata.name}')
        kubectl cp /root/devops-task6/devops-task6-pull-code/*.php  $pod_name:/var/www/html
    else
        pod_name=$(kubectl get pods -o=jsonpath='{.items[0].metadata.name}')
        kubectl cp /root/devops-task6/devops-task6-pull-code/*.html  $pod_name:/var/www/html
    fi
fi
    