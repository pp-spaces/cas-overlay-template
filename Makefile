main: build validate docker

clean:
		@echo "Cleaning source directory..."
		./gradlew clean

build:
		@echo "Build CAS"
		./gradlew clean build --stacktrace --no-daemon --refresh-dependencies -Dorg.gradle.internal.http.socketTimeout=600000 -Dorg.gradle.internal.http.connectionTimeout=600000

validate:
		@echo "Download CAS Shell"
		./gradlew downloadShell

		@echo "List CAS Template Views"
		./gradlew listTemplateViews

		@echo "Unzip CAS Web Application"
		./gradlew explodeWar

docker:
		@echo "Build Docker Image"
		./docker-build.sh

		@echo "Available Docker Images"
		docker images

		@echo "Push Docker Image"
		./docker-push.sh

dockerJib:
		@echo "Build Docker Image via Jib"
		./gradlew build jibDockerBuild --stacktrace --no-daemon --refresh-dependencies

dockerCompose:
		@echo "Build Docker Image via Docker Compose"
		docker-compose build
