echo "Downloading Cecil"
curl -sSOL https://github.com/Cecilapp/Cecil/releases/latest/download/cecil.phar
php cecil.phar --version

echo "Started CSS build"
npm install tailwindcss --silent
npm install @tailwindcss/typography --silent
npx tailwindcss-cli build ./static/tailwind.css -o ./static/styles.css
if [ $? = 0 ]; then echo "Finished Tailwind build"; else echo "Tailwind fail..."; exit 1; fi

echo "Started Cecil build"
if [[ $1 == "preview" ]]; then
  php cecil.phar build -v --baseurl=$DEPLOY_PRIME_URL --drafts || { sleep 30; false; };
else
  php cecil.phar build -v --baseurl=$URL --postprocess;
fi

echo "Started Algolia index import"
npm install -g @algolia/cli
algolia import -s _site/algolia.json -a $ALGOLIA_APP_ID -k $ALGOLIA_APP_KEY -n $ALGOLIA_INDEX_NAME
if [ $? = 0 ]; then echo "Finished Algolia index import"; else echo "Index imort fail..."; exit 1; fi

# build success? can deploy?
if [ $? = 0 ]; then echo "Finished Cecil build"; exit 0; fi

echo "Interrupted Cecil build"; exit 1
