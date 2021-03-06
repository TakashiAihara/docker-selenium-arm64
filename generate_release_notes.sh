#!/usr/bin/env bash

LATEST_TAG=$1
HEAD_BRANCH=$2
GRID_VERSION=$3
BUILD_DATE=$4

TAG_VERSION=${GRID_VERSION}-${BUILD_DATE}

# Get all tags, branches, and history
#git fetch --depth=1 origin +refs/tags/*:refs/tags/* 1>&2
#git fetch --no-tags --prune --depth=1 origin +refs/heads/*:refs/remotes/origin/* 1>&2
#git fetch --prune --unshallow 1>&2

echo "" >> release_notes.md
echo "### Changelog" > release_notes.md
git --no-pager log "${LATEST_TAG}...${HEAD_BRANCH}" --pretty=format:"* [\`%h\`](http://github.com/seleniumhq/docker-selenium/commit/%H) - %s :: %an" --reverse >> release_notes.md

CHROME_VERSION=$(docker run --rm selenium/node-chrome:${TAG_VERSION} google-chrome --version | awk '{print $3}')
CHROMEDRIVER_VERSION=$(docker run --rm selenium/node-chrome:${TAG_VERSION} chromedriver --version | awk '{print $2}')
FIREFOX_VERSION=$(docker run --rm selenium/node-firefox:${TAG_VERSION} firefox --version | awk '{print $3}')
GECKODRIVER_VERSION=$(docker run --rm selenium/node-firefox:${TAG_VERSION} geckodriver --version | awk 'NR==1{print $2}')


echo "" >> release_notes.md
echo "### Released versions" >> release_notes.md
echo "* Selenium: ${GRID_VERSION}" >> release_notes.md
echo "* Chrome: ${CHROME_VERSION}" >> release_notes.md
echo "* ChromeDriver: ${CHROMEDRIVER_VERSION}" >> release_notes.md
echo "* Firefox: ${FIREFOX_VERSION}" >> release_notes.md
echo "* GeckoDriver: ${GECKODRIVER_VERSION}" >> release_notes.md

echo "" >> release_notes.md
echo "### Published Docker images" >> release_notes.md
echo '```' >> release_notes.md
docker images --filter=reference='selenium/*:*' --format "table {{.ID}}\t{{.Repository}}\t{{.Tag}}\t{{.Size}}" >> release_notes.md
echo '```' >> release_notes.md

