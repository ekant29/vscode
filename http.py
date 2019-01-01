import re
with open("http.txt") as f:
    contents = f.readlines()

for i in contents :
  lst = re.findall(r'"([^"]*)"', i)
  for i in lst:
    print (i)