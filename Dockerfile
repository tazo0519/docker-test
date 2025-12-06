# 컨테이너가 떴을 때 환경에 jdk21 을 설치한다
FROM eclipse-temurin:21-jdk AS builder
WORKDIR /app

COPY . .
RUN ./gradlew clean build -x test


FROM eclipse-temurin:21-jdk
WORKDIR /app


# 호스트 컴퓨터의 .jar 파일을 app.jar로 복사한다
COPY --from=builder /app/build/libs/*.jar app.jar


EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]

# 종료된 컨테이너에 들어가서 디버깅하고 싶을 때 사용
# 500초 동안 시스템을 일시정지 시키는 명령어
# 컨테이너가 내부적으로 처리할게 없으면 종료 시키기 때문에, 500초 동안 작업을 하라고 지시한 것
#ENTRYPOINT ["/bin/bash", "-c", "sleep 500"]