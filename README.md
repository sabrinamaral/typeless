Readme

📝 This app was created as the final project for Le Wagon Bootcamp by Sabrina Amaral, Bernardo Brotelli, Fernando Mussolini and Henrique Valeri.

🎯 After completing the bootcamp, I took it upon myself to refine the app's accuracy and functionality. My goal is not only to replace my personal budget spreadsheet with this app but also to gain a comprehensive understanding of its user experience. By using this app in my daily life, I will be able to adapt it to real-world situations and develop my newly acquired skills to their fullest potential.

## Instalation instrunctions

After cloning the app, you will need to create an account on [Cloudinary](https://cloudinary.com/) and [Verify](https://www.veryfi.com/) to get an API key.

Set your .env with these three variables:

1. CLIENT_ID_VERYFI
2. API_KEY_VERYFI (this one is the combination of username:APIkey)
3. CLOUDINARY_URL

Run 'bundle' and 'yarn install' commands to install all the gems and packages necessary to run the app.

To get your server up and running use:

```
  bin/rails server

```

(for the ruby on rails) and

```
yarn build --watch

```

on a different terminal (for webpack)

Finally, open it on your localhost:3000

PS: ctr c to stop the app

## Usage instrunctions

coming soon...

## Troubleshooting

If you have any trouble with webpack installation, try to run

```
rm -rf node_modules

```

to remove node_modules file and then run yarn again

## Tecnologies

- Ruby
- RoR
- Postgres
- Devise
- Simple Form
- Cloudinary
- Chartkick
- Bootstrap
- Font-awesome

![Typeless Dashboard](/app/assets/images/typeless.png)
