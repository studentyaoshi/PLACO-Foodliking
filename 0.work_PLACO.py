import os,sys
document1 = open ( sys.argv[1] , 'r' ) # file1.ma
document2 = open ( sys.argv[2] , 'r' ) # file2.ma
document3 = open ( sys.argv[3] ,'w+' ) # result.list

dic_F = {}
dic_R = {}

document1.readline()
for i in document1:
	line = i.strip().split('\t')
	if float(line[5]) != 0:
		dic_F[line[0]] = line[1] + "\t" + line[2] + "\t" + str( float(line[4]) / float(line[5]) ) + "\t" + line[6]
		dic_R[line[0]] = line[2] + "\t" + line[1] + "\t" + str(-float(line[4]) / float(line[5]) ) + "\t" + line[6]

document2.readline()
document3.write('SNP\tA1\tA2\tZ1\tP1\tZ2\tP2\n')
for i in document2:
	line = i.strip().split('\t')
	alle = line[1] + "\t" + line[2]
	allr = line[2] + "\t" + line[1]
	if dic_F.get(line[0],"NA_AN") == "NA_AN":
		continue
	elif "\t".join( dic_F.get(line[0]).split('\t')[0:2] ) == alle:
		document3.write( line[0] + "\t" + dic_F.get(line[0]) + "\t" + str( float(line[4]) / float(line[5]) ) + "\t" + line[6] + "\n")
	elif "\t".join( dic_F.get(line[0]).split('\t')[0:2] ) == allr:
		document3.write( line[0] + "\t" + dic_R.get(line[0]) + "\t" + str( float(line[4]) / float(line[5]) ) + "\t" + line[6] + "\n")

document1.close()
document2.close()
document3.close()		
