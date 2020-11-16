## Development
If you haven't install python dependencies please follow [Installing dependencies](Installing-dependencies).

## Run with docker
You can start the development server with this command (Add -d flag if you want to run it as daemon):
```
docker-compose up
```
You can stop the server either with `CTRL + C` or `docker-compose stop`
If you want to remove container, `docker-compose down`

### Execute commands inside container
If you want to run django commands such as `createsuperuser` use these commands:

(You need to run `docker-compose up -d` or open a new terminal to execute commands)
```
docker-compose exec paperlayer_backend <command>
docker-compose exec paperlayer_backend ./manage.py createsuperuser
docker-compose exec paperlayer_backend ./manage.py makemigrations
docker-compose exec paperlayer_backend ./manage.py shell
```

### Permission denied error
If you get permission denied errors for `docker/run.sh` script. Run these commands:
```
chown <username> docker/run.sh
chmod +x docker/run.sh
```

## Run without docker (not recommended)
You can start development server with these commands:
```
python manage.py migrate
python manage.py runserver
```

## Installing dependencies

Install poetry in your global:
```
python3 -m pip install --upgrade pip
python3 -m pip install poetry
```

Activate virtual environment with poetry in the project directory:
```
poetry shell
```
You can check whether virtual environment is activated by running this command:
```
which python
```
You should see something like `/Users/username/Library/Caches/pypoetry/virtualenvs/backend-HbhKE7kK-py3.9/bin/python`

If it returns `/usr/bin/python` or `/usr/local/bin/python3` it means it didn't activate the virtual environment properly. Try opening new terminal and run `poetry shell` again

Install dependencies with poetry:
```
poetry install
```

## Linting
You can either see linting errors in your IDE if you configure `flake8`.

Also you can run linting directly in your terminal with `flake8` command.


## Visual Studio Settings
In .vscode/settings.json:
```
{
    "python.pythonPath": "path-to-python-in-your-virtual-environment",
    "python.linting.flake8Enabled": true,
    "python.linting.enabled": true
}
```
You can find your python path with `which python` command after activating the virtual environment with `poetry shell`


## Deployment to Heroku

In .github/workflows folder, `backend-heroku.yml` file is a script that triggers a action for deployment to Heroku server.

It will work at every pull request and push to `master` branch

`Admin user` is created and will be shared with only team members.

**! Important**

If there are changes in models or database, please push your changes after making migrations.( NOT migrate )
```python
python manage.py makemigrations
```

This will update the `migrations` folder according to your changes.

Heroku handles the remaining stuffs in the its own server. (You don't have run `python manage.py migrate`)

