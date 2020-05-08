FROM ortussolutions/commandbox
COPY . /app
RUN chmod +x ${APP_DIR}/workbench/setup-env.sh
RUN ${APP_DIR}/workbench/setup-env.sh