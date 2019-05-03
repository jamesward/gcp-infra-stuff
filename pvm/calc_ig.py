#! /usr/bin/python
import math, sys, getopt

def main(argv):
	target = 0.0	
	current = 0.0	
	result = 0.0		
	try:		
		opts, args = getopt.getopt(argv,"a:b:")	
	except getopt.GetoptError:		
		sys.exit(42)	
		for opt, arg in opts:		
			if (opt == "-a"):			
				target = float(arg)		
			elif (opt == "-b"):			
				current = float(arg)			
				result = float(target*(1/((current)/(target))))	
				print (int(result+1))	

if __name__ == "__main__":	
	script_name=sys.argv[0]	
	arguments = len(sys.argv) - 1
	if (arguments == 0):		
		sys.exit(43)
		
	main(sys.argv[1:])