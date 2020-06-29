f=open("CCMS1.txt","w+")

for x in range(36):
	a=str("Type answer #" + str(x+1) + ":")
	test = input(a)
	b=str(str(x+1) + " " + test + "\n")
	f.write(b)
f.close
