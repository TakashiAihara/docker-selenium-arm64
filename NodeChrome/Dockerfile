# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# NOTE: DO *NOT* EDIT THIS FILE.  IT IS GENERATED.
# PLEASE UPDATE Dockerfile.txt INSTEAD OF THIS FILE
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
FROM selenium/node-base:4.0.0-alpha-6-arm64-20210101
LABEL authors=SeleniumHQ

USER root

#============================================
# Chromium
#============================================
RUN apt-get update -qqy \
  && apt-get install -qqy chromium-browser

#============================================
# Chromedriver
#============================================
RUN CHROME_DRIVER_VERSION=$(chromium-browser --version | awk '{print $2}') \
  && echo "Using chromedriver version: "$CHROME_DRIVER_VERSION \
  && apt-get update -qqy \
  && apt-get install chromium-chromedriver=`chromium-browser --version | awk '{print $2}'`-0ubuntu0.18.04.1 \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

#=================================
# Chrome Launch Script Wrapper
#=================================
COPY wrap_chrome_binary /opt/bin/wrap_chrome_binary
RUN /opt/bin/wrap_chrome_binary

USER 1200

COPY generate_config /opt/bin/generate_config

# Generating a default config during build time
RUN /opt/bin/generate_config > /opt/selenium/config.json
