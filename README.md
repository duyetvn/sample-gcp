# README

Sample GCP

## Run cloud build

```
gcloud builds submit --config cloudbuild.yaml \                
    --substitutions _SERVICE_NAME=plop,_INSTANCE_NAME=plop,_REGION=plop,_SECRET_NAME=plop
```

## Cloud run

```
gcloud run deploy sample-gcp-app \                             
     --platform managed \                                                                                                                
     --region plop \
     --image gcr.io/plop/plop \
     --add-cloudsql-instances plop:plop:plop \
     --allow-unauthenticated
```
