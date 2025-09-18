#!/bin/bash

# write an html template in the same working directory


cat <<EOF > index.html
<!DOCTYPE html>
<html>
  <head>
    <title>My Template</title>
  </head>
  <body>
    <h1>Hello, world!</h1>
  </body>
</html>
EOF
