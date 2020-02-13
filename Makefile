PHOHY: build
build: 
	docker build -t $(APP) .
	docker tag $(APP) gcr.io/$(PROJECT)/$(APP):`git rev-parse HEAD`
PHOHY: push
push:
	docker push gcr.io/$(PROJECT)/$(APP):`git rev-parse HEAD`
PHOHY: deploy
deploy:
	gcloud run deploy $(APP) --platform managed --image gcr.io/$(PROJECT)/$(APP):`git rev-parse HEAD` --region us-central1
