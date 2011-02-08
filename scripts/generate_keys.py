import string

alphabet = string.ascii_uppercase
nums = ["ZERO", "ONE", "TWO", "THREE", "FOUR", "FIVE", "SIX", "SEVEN", "EIGHT", "NINE"];

line = "public static const {0} : uint = {1};"

for i,key in enumerate(alphabet):
	print line.format(key, 65 + i)

for i,key in enumerate(nums):
	print line.format(key, 48 + i)

