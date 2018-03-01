#!/bin/bash

mongo init-root-user.js
mongo createUsers.js
mongo createIndexForQueryBelgium.js
mongo createIndexForQueryItaly.js
