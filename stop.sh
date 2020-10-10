#!/bin/bash
ps -ef|grep reloadnginx|grep -v grep|cut -c 9-15|xargs kill -9
