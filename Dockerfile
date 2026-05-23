# Sử dụng Tomcat 10 cho Jakarta EE 10
FROM tomcat:10.1-jdk21
WORKDIR /usr/local/tomcat/webapps

# Xóa thư mục ROOT mặc định
RUN rm -rf ROOT

# Copy file war đã build từ máy local vào (Bạn cần chạy ./gradlew war trước)
COPY build/libs/lab.war ./lab.war

# Giải nén để sẵn sàng cho Hot Reload
RUN mkdir ROOT && cd ROOT && jar -xvf ../lab.war && cd .. && rm lab.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
