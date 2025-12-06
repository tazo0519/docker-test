FROM eclipse-temurin:21-jdk AS builder
# WORKDIR: 컨테이너 안에 디렉토리 생성하고, 그 폴더 안에 파일들을 복사한다
WORKDIR /app

COPY . .
# RUN: 이미지 생성 과정에서 실행시켜야 할 명령어
RUN ./gradlew clean build -x test


# 컨테이너가 떴을 때 환경에 jdk21 을 설치한다
FROM eclipse-temurin:21-jdk
WORKDIR /app


# 호스트 컴퓨터의 .jar 파일을 app.jar로 복사한다
COPY --from=builder /app/build/libs/*.jar app.jar

# EXPOSE: 컨테이너 내부에서 어떤 포트에 프로그램이 실행되는지 명시해 주는 문서화 역할 (없어도 됨)
EXPOSE 8080
# ENTRYPOINT: 컨테이너가 생성 후 최초로 실행할 때 수행되는 명령어, 미니 컴퓨터의 전원을 키고나서 실행시키고싶은 명령어를 적으면 된다
ENTRYPOINT ["java", "-jar", "app.jar"]

# 종료된 컨테이너에 들어가서 디버깅하고 싶을 때 사용
# 500초 동안 시스템을 일시정지 시키는 명령어
# 컨테이너가 내부적으로 처리할게 없으면 종료 시키기 때문에, 500초 동안 작업을 하라고 지시한 것
#ENTRYPOINT ["/bin/bash", "-c", "sleep 500"]