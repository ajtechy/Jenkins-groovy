if  ls /root/ | grep devops-task6
then
	 echo "Directory exist"
else
	 mkdir /root/devops-task6
fi 
cp -rvf /root/.jenkins/workspace/devops-task6-pull-code/    /root/devops-task6