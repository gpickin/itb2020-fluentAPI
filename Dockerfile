FROM ortussolutions/commandbox
COPY . /app
RUN ${BUILD_DIR}/run.sh && sleep 30 && cd ${APP_DIR} && box server stop