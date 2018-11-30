# Create Projects

oc login -u system:admin

oc adm new-project alpha-cicd-dev --node-selector='client=alpha'
oc adm new-project alpha-task-build --node-selector='client=alpha'
oc adm new-project alpha-task-dev --node-selector='client=alpha'
oc adm new-project alpha-task-test --node-selector='client=alpha'
oc adm new-project alpha-task-prod --node-selector='client=alpha'


#oc create -f /root/openshift-homework/yaml/projectlimit.yaml -n alpha-task-dev
#oc create -f /root/openshift-homework/yaml/projectlimit.yaml -n alpha-task-test
#oc create -f /root/openshift-homework/yaml/projectlimit.yaml -n alpha-task-prod
#oc create -f /root/openshift-homework/yaml/projectlimit.yaml -n alpha-cicd-dev


# Grant Jenkins Access to Projects
oc policy add-role-to-group edit system:serviceaccounts:alpha-cicd-dev -n alpha-task-build
oc policy add-role-to-group edit system:serviceaccounts:alpha-cicd-dev -n alpha-task-dev
oc policy add-role-to-group edit system:serviceaccounts:alpha-cicd-dev -n alpha-task-test
oc policy add-role-to-group edit system:serviceaccounts:alpha-cicd-dev -n alpha-task-prod

oc adm policy add-role-to-group admin alpha-corp -n alpha-task-build
oc adm policy add-role-to-group admin alpha-corp -n alpha-task-dev
oc adm policy add-role-to-group admin alpha-corp -n alpha-task-test
oc adm policy add-role-to-group admin alpha-corp -n alpha-task-prod
oc adm policy add-role-to-group admin alpha-corp -n alpha-cicd-dev

oc login -u amy -p r3dh4t1!

oc project alpha-cicd-dev

oc new-app jenkins-persistent
# Deploy Demo
oc new-app -n alpha-task-build -f /root/openshift-homework/yaml/alpha-corp-cicd-template.yaml

# Sleep for 5 minutes and then Start Pipeline
sleep 300
oc start-build tasks-pipeline
