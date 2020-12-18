# cecil.app

> Source code of https://cecil.app, generated with [Cecil](https://github.com/Cecilapp/Cecil) (obviously!) and hosted by [Netlify](https://www.netlify.com).

[![Netlify Status](https://api.netlify.com/api/v1/badges/2353ad5a-611d-4236-9542-183fe0d585c7/deploy-status)](https://app.netlify.com/sites/cecilapp/deploys)

## Development

```bash
npm install tailwindcss
npm install @tailwindcss/typography
npx tailwindcss-cli build ./static/tailwind.css -o ./static/styles.css
curl -LO https://cecil.app/cecil.phar
php cecil.phar serve -v
```

## Production

```bash
CECIL_ENV=production npx tailwindcss-cli build ./static/tailwind.css -o ./static/styles.css
curl -LO https://cecil.app/cecil.phar
php cecil.phar build
```
