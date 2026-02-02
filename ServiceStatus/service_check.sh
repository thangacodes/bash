#!/bin/bash

SERVICES=("nginx" "pgbouncer")

start() {
  echo "Starting services..."
  for service in "${SERVICES[@]}"; do
    systemctl start "$service"
    if systemctl is-active --quiet "$service"; then
      echo "$service started successfully"
    else
      echo "Failed to start $service"
    fi
  done
}

stop() {
  echo "Stopping services..."
  for service in "${SERVICES[@]}"; do
    systemctl stop "$service"
    if systemctl is-active --quiet "$service"; then
      echo "Failed to stop $service"
    else
      echo "$service stopped successfully"
    fi
  done
}

status() {
  echo "Checking service status..."
  for service in "${SERVICES[@]}"; do
    if systemctl is-active --quiet "$service"; then
      echo "$service is running"
    else
      echo "$service is NOT running"
    fi
  done
}

echo "================================="
echo " PGBOUNCER & NGINX Service Menu"
echo "================================="
echo "1) Start services"
echo "2) Stop services"
echo "3) Status check"
echo "4) Exit"
echo

read -rp "Choose an option [1-4]: " choice

case "$choice" in
  1)
    start
    ;;
  2)
    stop
    ;;
  3)
    status
    ;;
  4)
    echo "Exiting..."
    exit 0
    ;;
  *)
    echo "Invalid option. Please choose 1-4."
    exit 1
    ;;
esac
