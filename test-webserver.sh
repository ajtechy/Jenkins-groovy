for file in $(ls /root/devops-task6/devops-task6-pull-code/)
do
	if [[ -n $(echo $file | grep html) ]]
    then
    	export NodePort=$(kubectl get svc -o jsonpath='{.items[*].spec.ports[*].nodePort}')
        echo $NodePort
        export status_code=$(curl -s -o /dev/null -w "%{http_code}" 192.168.99.101:$NodePort/$file)
        echo $status_code
        echo $file $NodePort $status_code
        if [[ $status_code == 200 ]]
        then
        	echo "Everything is alright.\nwebserver is running good"
            exit 1
        else
        	echo "Something is wrong"
            # if something is wrong then this job fill notify to developer via mail
            # and also trigger to notify mail job.
            exit 0
    	fi
    elif [[ -n $(echo $file | grep php) ]]
    then
    	export NodePort=$(kubectl get svc -o jsonpath='{.items[*].spec.ports[*].nodePort}')
        echo $NodePort
        export status_code=$(curl -s -o /dev/null -w "%{http_code}" 192.168.99.101:$NodePort/$file)
        echo $status_code
        echo $file $NodePort $status_code
        if [[ $status_code == 200 ]]
        then
        	echo "Everything is alright.\nwebserver is running good"
            exit 1
        else
        	echo "Something is wrong"
            # if something is wrong then this job fill notify to developer via mail
            # and also trigger to notify mail job.
            exit 0
        fi
    fi
done