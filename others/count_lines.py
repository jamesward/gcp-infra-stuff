#!/usr/bin/python

import sys, getopt, time, csv, linecache

def bufcount(filename):
    f = open(filename)                  
    lines = 0
    buf_size = 1024 * 1024
    read_f = f.read # loop optimization

    buf = read_f(buf_size)
    while buf:
        lines += buf.count('\n')
        buf = read_f(buf_size)

    return lines

def simplecount(filename):
    lines = 0
    for line in open(filename):
        lines += 1
    return lines	

def actually_read_lines(filename):
	with open(filename, "rU") as in_file:
		reader = csv.DictReader(in_file,delimiter=',')
		for row in reader:
			a=row

def get_specific_line(filename,line_no):
	print linecache.getline(filename, line_no)


def main(argv):
	try:
		opts, args = getopt.getopt(argv,"f:br")
	except getopt.GetoptError:
		sys.exit(42)
	for opt, arg in opts:
		if opt == "-f":
			inputfile = arg

	time1 = time.time()
	print bufcount(inputfile)
	time2 = time.time()

	time3 = time.time()
	print simplecount(inputfile)
	time4 = time.time()

	#time5 = time.time()
	#print actually_read_lines(inputfile)
	#time6 = time.time()

	time7 = time.time()
	get_specific_line(inputfile,1233123)
	time8 = time.time()



	print 'bufcount took %0.3f ms' % ((time2-time1)*1000.0)
	print 'simplecount took %0.3f ms' % ((time4-time3)*1000.0)
	#print 'actually_read_lines took %0.3f ms' % ((time6-time5)*1000.0)
	print 'getting a line took %0.3f ms' % ((time8-time7)*1000.0)





if __name__ == "__main__":
    script_name=sys.argv[0]
    arguments = len(sys.argv) - 1

    if (arguments == 0):
        sys.exit(42)

    main(sys.argv[1:])