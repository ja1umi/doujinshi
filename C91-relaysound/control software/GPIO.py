from time import sleep
import sys
sys.path.append(".")
from shiftpi import digitalWrite, digitalWrite8, shiftRegisters, ALL, HIGH, LOW

def noteon(ll):
	_notenum = int(ll[0])
	_notelen = int(ll[1])
	digitalWrite8(1, _notenum | 0x80)
	# a 1/16 musical note = 1/16 sec, for testing purpose only 
	sleep(_notelen * 1/16)
	return ll
	
def noteonsim(ll):
	_notenum = int(ll[0])
	_notelen = int(ll[1])
	print "digitalWrite8(1,", _notenum | 0x80, ")"
	# a thirteenth note = 1/16 sec, a whote note = 2 sec, for testing purpose only 
	print "sleep(", _notelen * 1/16, ")"
	# note off
	#print "digitalWrite8(1,", _notenum, ")"
	return ll

def noteoff(ll):
	_notenum = int(ll[0])
	_notelen = int(ll[1])
	digitalWrite8(1, 0)
	# a thirteenth note = 1/16 sec, a whote note = 2 sec, for testing purpose only 
	sleep(_notelen * 1/16)
	return ll

def init():
	shiftRegisters(3)
	digitalWrite(ALL,LOW)
	return 'initialized.'
