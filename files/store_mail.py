#!/bin/python

import sys
import email
import redis

redis = redis.StrictRedis(host='localhost', port=6379, db=0)
mail_parser = email.FeedParser.FeedParser()

def store_mail(mail):
  try:
    for line in mail:
      mail_parser.feed(line)
    email = mail_parser.close()
    redis.incr('mail:id')
    id = redis.get('mail:id')
    redis.hmset(id, {'To:':email['To'],'From:':email['From'], 'Date:':email['Date'], 'Message:':email.get_payload()})
  except:
    print 'Unexpected error:', sys.exc_info()[0]
    exit(1)
  return 'Message was stored successfully'

if not sys.stdin.isatty():
  store_mail(sys.stdin.readlines())
else:
  print("This script is used to store mails in Redis")
