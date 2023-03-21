# Check if docker is installed
if ! command -v docker &> /dev/null; then
  echo "Docker not found, installing..."
  sudo apt update
  sudo apt install -y docker.io
fi

# Check if docker-compose is installed
if ! command -v docker-compose &> /dev/null; then
  echo "Docker Compose not found, installing..."
  sudo apt update
  sudo apt install -y docker-compose
fi

case "$1" in
  first_start)
    echo "First start: Starting containers, making migrations, and restarting containers"
    docker-compose up -d
    docker-compose exec web python manage.py makemigrations
    docker-compose exec web python manage.py migrate
    docker-compose down
    docker-compose up -d
    ;;
  start)
    echo "Starting containers"
    docker-compose up -d
    ;;
  stop)
    echo "Stopping containers"
    docker-compose down
    ;;
  restart)
    echo "Restarting containers"
    docker-compose down
    docker-compose up -d
    ;;
  build)
    echo "Building containers"
    docker-compose build
    ;;
  makemigrations)
    echo "Creating database migrations"
    docker-compose exec web python manage.py makemigrations
    ;;
  migrate)
    echo "Applying database migrations"
    docker-compose exec web python manage.py migrate
    ;;
  createsuperuser)
    echo "Creating superuser"
    docker-compose exec web python manage.py createsuperuser
    ;;
  collectstatic)
    echo "Collecting static files"
    docker-compose exec web python manage.py collectstatic
    ;;
  shell)
    echo "Opening Django shell"
    docker-compose exec web python manage.py shell
    ;;
  reset)
    echo "Stopping and removing all containers, networks, and volumes"
    docker-compose down -v
    ;;
  status)
    docker-compose ps
    ;;
  logs)
    echo "Displaying logs"
    docker-compose logs -f
    ;;
  help)
    echo "Usage: sh ./manage.sh [command]"
    echo ""
    echo "Commands:"
    echo "  first_start      - first start (start containers, make migrations, restart containers)"
    echo "  start            - start containers"
    echo "  stop             - stop containers"
    echo "  restart          - restart containers"
    echo "  build            - build containers"
    echo "  makemigrations   - create database migrations"
    echo "  migrate          - apply database migrations"
    echo "  createsuperuser  - create superuser"
    echo "  collectstatic    - collect static files"
    echo "  shell            - open Django shell"
    echo "  reset            - stop and remove all containers, networks, and volumes"
    echo "  status           - display status of each container"
    echo "  logs             - display logs"
    echo "  help             - display this help message"
    echo ""
    ;;
  *)
    echo "Invalid command. Run 'sh ./manage.sh help' to see a list of available commands."
    ;;
esac