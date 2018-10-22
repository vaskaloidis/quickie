#!/bin/bash
# Author:       Vas Kaloidis
# Email:        vas.kaloidis@gmail.com
# Date:         2018-10-16
# Usage:        app_name.sh
# Description:  APP_NAME
#
#
#


if [ "$choice" = "help" ]; then
  help_choice
elif [ "$choice" = "bash" ]; then
  bash_choice "$APPNAME", "$STARTER_DIR"
elif [ "$choice" = "ruby" ]; then
  ruby_choice "$APPNAME"
fi

help_choice() {
  echo "Usage starter.sh ([-b|--bash] | [-r|--ruby])  <app-name>"
  echo "starter.sh [-h|--help] "
}

