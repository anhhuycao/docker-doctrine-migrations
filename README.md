#### General

- Migration database with docktrine migration
- Support mysql & posgress
- [Github](https://github.com/anhhuycao/docker-doctrine-migrations)
- [Docker Hub](https://hub.docker.com/repository/docker/anhhuybv/doctrine-migration)

#### Prepare

- Pull docker image

```
docker pull anhhuybv/doctrine-migration:3.3.0
```

- Add to your Makefile

```
dbmigrate-generate:
	docker run -v $(PWD)/migrations:/data anhhuybv/doctrine-migration:3.3.0 migration:generate

dbmigrate:
	docker run -v $(PWD)/migrations:/data anhhuybv/doctrine-migration:3.3.0 migration:migrate -n

dbmigrate-down:
	docker run -v $(PWD)/migrations:/data anhhuybv/doctrine-migration:3.3.0 migrations:migrate prev -n
```

- copy migration config from `migrations` folder

``

#### Usage

- Create new migration

  ```
  make dbmigrate-generate
  ```

- Run migration

  ```
  make dbmigrate
  ```

- Rollback migration
  ```
  make dbmigrate-down
  ```

#### Limitation

- Generated file migration with root permisssion on linux
  quick fix

```
   sudo chown your_user:your_user migrations/versions
```
