ssh -o StrictHostKeyChecking=no $CONNECT_DEPLOY_INSTANCE << 'ENDSSH'
  cd alumni
  export $(cat ./.envs/.production/.django | xargs)
  docker login -u $CI_DOCKER_DEPLOY_USER -p $CI_DOCKER_DEPLOY_KEY $CI_REGISTRY
  docker pull $IMAGE:docs
  docker pull $IMAGE:django
  docker pull $IMAGE:postgres
  docker pull $IMAGE:flower
  docker pull $IMAGE:celeryworker
  docker pull $IMAGE:celerybeat
  docker pull $IMAGE:traefik
  docker-compose -f gitlab-production.yml up -d
ENDSSH
