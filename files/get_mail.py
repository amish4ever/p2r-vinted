#!/bin/python

import sys
import redis
import re

if len(sys.argv) > 1:
  email = sys.argv[1]
else:
  print("You need to pass an e-mail address as an argument")
  exit(1)

redis = redis.StrictRedis(host='localhost', port=6379, db=0)

def retrieve_mail(rcpt):
  output = ""
  try:
    for key in redis.keys():
      if key != 'mail:id':
        if redis.hget(key, 'To:') == rcpt:
          mail = redis.hgetall(key)
          output += 'Date: ' + mail['Date:'] + '\n'
          output += 'From: ' + mail['From:'] + '\n'
          output += 'Message: \n' + mail['Message:'] + '\n'
          output += "-------------------------------------\n"
  except:
    print 'Unexpected error:', sys.exc_info()[0]
    exit(1)
  return output

if re.match(r"[^@]+@[^@]+\.[^@]+", email):
  print retrieve_mail(email)
else:
  print("This script is used to retrieve mails from Redis. You should provide a valid e-mail address")
