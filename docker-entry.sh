#!/bin/sh

npx sequelize-cli db:migrate &
pm2-runtime 'node server.js'