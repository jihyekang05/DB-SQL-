import sys
sys.stdin=open("input.txt", "r")


            

n = int(input())
hour = []
for i in range(n):
    s,e = map(int,input().split())
    hour.append((s,e))

##important point
hour.sort(key = lambda x : (x[1],x[0])) 

et = 0
cnt = 0
for s, e in hour:
    if s>=et:
        et = e
        cnt +=1
    else:
        pass


print(cnt)
