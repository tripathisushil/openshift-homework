# Create Projects
oc new-project beta-task-dev --display-name="Beta-Tasks - Dev"
oc new-project beta-task-test --display-name="Beta-Tasks - TEST"
oc new-project beta-task-prod --display-name="Beta-Tasks - Prod"
oc new-project beta-cicd --display-name="Beta-CI/CD"

# Grant Jenkins Access to Projects
oc policy add-role-to-group edit system:serviceaccounts:beta-cicd -n beta-task-dev
sleep 10
oc policy add-role-to-group edit system:serviceaccounts:beta-cicd -n beta-task-test
sleep 10
oc policy add-role-to-group edit system:serviceaccounts:beta-cicd -n beta-task-prod
sleep 10
oc new-app jenkins-persistent
# Deploy Demo
oc new-app -n beta-cicd -f cicd-template.yaml

# Sleep for 5 minutes and then Start Pipeline
sleep 300
oc start-build tasks-pipeline