version: '3.1'
services:
  db:
    container_name: database
    image: mysql
    restart: always
    ports:
      - "3306:3306"
    environment:
      - MYSQL_ROOT_PASSWORD=secret
    volumes:  
      - ./data-mysql:/var/lib/mysql
      - ./itcheatsheet.sql:/itcheatsheet.sql
networks:
    default:
        external:
            name: it-cheatsheet-network
