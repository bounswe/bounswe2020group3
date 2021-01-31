# Backend System Manual
## With Docker
- Unzip [this](https://github.com/bounswe/bounswe2020group3/blob/master/deliverables/paperlayer.zip). <br/>
- Open terminal change folder to paperlayer and execute: <br/>

```bash
docker-compose up -d --build
```

- This will build backend and frontend. <br/>
- Then execute following command to run backend on localhost port 8000 and frontend on localhost port 5000: <br/>

```bash
docker-compose up
```
## Without Docker
### How to build and run on local
- Clone repository <br/>
- Open terminal and change folder to ..\bounswe2020group3\backend <br/>
- Execute following command on terminal to install dependencies: <br/>
```bash
poetry install
```
- Execute following command on terminal to open poetry shell: <br/>

```bash
poetry shell
```
- Install PostgreSql in your computer and set up our database instance using [this file](https://github.com/bounswe/bounswe2020group3/blob/master/backend/db-dumps/paperlayerdb.sql) . <br/>

- Execute following commands to migrate databse: <br/>
```bash
python manage.py makemigrations
python manage.py migrate
```

### Configuration
Paperlayer needs  some information stored in environment variables for some opreations.   <br/>
- Create following environment variables for database: <br/>

‘DJANGO_ENV’ <br/>
'NAME' <br/>
'USER' <br/>
'PASSWORD' <br/>
'HOST' <br/>
'PORT’ <br/>

- Following environment variables are necessary for some features but not mandatory for server to run: <br/>
<br/>
EMAIL_HOST_PASSWORD : Password of e-mail account that Paperlayer uses. <br/>
AWS_ACCESS_KEY_ID : Access key id to Amazon AWS S3 bucket that stores files uploaded by users. <br/>
AWS_SECRET_ACCESS_KEY : Secret key of Amazon AWS S3 bucket that stores files uploaded by users. <br/>
STREAM_API_KEY :  Api key for getstream activity stream [api](https://getstream.io/). <br/>
STREAM_API_SECRET : Secret key for getstream activity stream [api](https://getstream.io/) .  <br/>
SENDGRID_API_KEY : An api key used for e-mail verification [api](https://sendgrid.com/) .  <br/>
<br/>

- Then run the server using: <br/>

```bash
python manage.py runserver
```
