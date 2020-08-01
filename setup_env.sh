echo CI_DOCKER_DEPLOY_USER=$CI_DOCKER_DEPLOY_USER >> ./.envs/.production/.django
echo CI_DOCKER_DEPLOY_KEY=$CI_DOCKER_DEPLOY_KEY >> ./.envs/.production/.django

echo REDIS_IMAGE=$IMAGE:redis >> ./.envs/.production/.django
echo DOCS_IMAGE=$IMAGE:docs >> ./.envs/.production/.django
echo DJANGO_IMAGE=$IMAGE:django >> ./.envs/.production/.django
echo POSTGRES_IMAGE=$IMAGE:postgres >> ./.envs/.production/.django
echo FLOWER_IMAGE=$IMAGE:flower >> ./.envs/.production/.django
echo CELERYWORKER_IMAGE=$IMAGE:celeryworker >> ./.envs/.production/.django
echo CELERYBEAT_IMAGE=$IMAGE:celerybeat >> ./.envs/.production/.django
echo TRAEFIK_IMAGE=$IMAGE:traefik >> ./.envs/.production/.django
echo CI_REGISTRY=$CI_REGISTRY >> ./.envs/.production/.django

echo IMAGE=$CI_REGISTRY/$CI_PROJECT_NAMESPACE/$CI_PROJECT_NAME >> ./.envs/.production/.django


echo DJANGO_SETTINGS_MODULE=$DJANGO_SETTINGS_MODULE >> ./.envs/.production/.django
echo DJANGO_SECRET_KEY=$DJANGO_SECRET_KEY >> ./.envs/.production/.django
echo DJANGO_ADMIN_URL=$DJANGO_ADMIN_URL >> ./.envs/.production/.django
echo DJANGO_SECURE_SSL_REDIRECT=$DJANGO_SECURE_SSL_REDIRECT >> ./.envs/.production/.django
echo DJANGO_SERVER_EMAIL=$DJANGO_SERVER_EMAIL >> ./.envs/.production/.django
echo MAILGUN_API_KEY=$MAILGUN_API_KEY >> ./.envs/.production/.django
echo MAILGUN_DOMAIN=$MAILGUN_DOMAIN >> ./.envs/.production/.django
echo DJANGO_AWS_ACCESS_KEY_ID=$DJANGO_AWS_ACCESS_KEY_ID >> ./.envs/.production/.django
echo DJANGO_AWS_SECRET_ACCESS_KEY=$DJANGO_AWS_SECRET_ACCESS_KEY >> ./.envs/.production/.django
echo DJANGO_AWS_STORAGE_BUCKET_NAME=$DJANGO_AWS_STORAGE_BUCKET_NAME >> ./.envs/.production/.django
echo DJANGO_ACCOUNT_ALLOW_REGISTRATION=$DJANGO_ACCOUNT_ALLOW_REGISTRATION >> ./.envs/.production/.django
echo WEB_CONCURRENCY=$WEB_CONCURRENCY >> ./.envs/.production/.django
echo SENTRY_DSN=$SENTRY_DSN >> ./.envs/.production/.django
echo REDIS_URL=$REDIS_URL >> ./.envs/.production/.django
echo CELERY_FLOWER_USER=$CELERY_FLOWER_USER >> ./.envs/.production/.django
echo CELERY_FLOWER_PASSWORD=$CELERY_FLOWER_PASSWORD >> ./.envs/.production/.django


echo POSTGRES_HOST=$POSTGRES_HOST >> ./.envs/.production/.postgres
echo POSTGRES_PORT=$POSTGRES_PORT >> ./.envs/.production/.postgres
echo POSTGRES_DB=$POSTGRES_DB >> ./.envs/.production/.postgres
echo POSTGRES_USER=$POSTGRES_USER >> ./.envs/.production/.postgres
echo POSTGRES_PASSWORD=$POSTGRES_PASSWORD >> ./.envs/.production/.postgres
