###############################################
# Justin Bearden                              #
# IEE 574 - Summer 2012                       #
# 5/8 Schedule Police Department              #
###############################################

param officers;					# Total officers in district
param min_officers;				# Minimum officers during any hour
param officers_per_car;			# Number of officers per car (per call)
param D{j in 1..7, k in 1..12};	# Officers needed on day j at 2-hour period k (from data)

# i = 1..3  = shifts
# j = 1..7  = days
# k = 1..12 = 2 hour time units

var X{i in 1..3, j in 1..7} integer;	# Officers starting on shift i on day j
var L{j in 1..7, k in 1..12} integer;	# Surplus of officers on day j at hour k
var S{j in 1..7, k in 1..12} integer;	# Shortage of officers on day j at hour k
var y integer;							# Maximum shortage or surplus

# Objective statement
minimize total_diff: sum{j in 1..7, k in 1..12} S[j,k] + sum{j in 1..7, k in 1..12} L[j,k];
minimize max_shortage: y;
minimize total_diff_and_max_shortage: sum{j in 1..7, k in 1..12} S[j,k] + sum{j in 1..7, k in 1..12} L[j,k] + y;

# Constraints
subject to max_y_shortage{j in 1..7, k in 1..12}: y >= S[j,k];				# y is maximum shortage over any time
subject to total_officers: sum{i in 1..3, j in 1..7} X[i,j] <= officers;	# officers starting <= total officers

# Hours 1 to 3 (Shift 3)
subject to hour1to3_day1to5{j in 1..5,k in 1..3}: sum{m in 1..j-1} X[3,m] + sum{m in j+2..7} X[3,m] + S[j,k] - L[j,k] = D[j,k] * officers_per_car;
subject to hour1to3_day6to7{j in 6..7,k in 1..3}: sum{m in j-5..j-1} X[3,m] + S[j,k] - L[j,k] = D[j,k] * officers_per_car;

# Hours 4 to 7 (Shift 1)
subject to hour4to7_day1to4{j in 1..4,k in 4..7}: sum{m in j+3..7} X[1,m] + sum{m in 1..j} X[1,m] + S[j,k] - L[j,k] = D[j,k] * officers_per_car;
subject to hour4to7_day5to7{j in 5..7,k in 4..7}: sum{m in j-4..j} X[1,m] + S[j,k] - L[j,k] = D[j,k] * officers_per_car;

# Hours 8 to 11 (Shift 2)
subject to hour8to11_day1to4{j in 1..4,k in 8..11}: sum{m in j+3..7} X[2,m] + sum{m in 1..j} X[2,m] + S[j,k] - L[j,k] = D[j,k] * officers_per_car;
subject to hour8to11_day5to7{j in 5..7,k in 8..11}: sum{m in j-4..j} X[2,m] + S[j,k] - L[j,k] = D[j,k] * officers_per_car;

# Hour 12 (Shift 3)
subject to hour12_day1to4{j in 1..4,k in 12..12}: sum{m in j+3..7} X[3,m] + sum{m in 1..j} X[3,m] + S[j,k] - L[j,k] = D[j,k] * officers_per_car;
subject to hour12_day5to7{j in 5..7,k in 12..12}: sum{m in j-4..j} X[3,m] + S[j,k] - L[j,k] = D[j,k] * officers_per_car;

# Minimum Officers
subject to minofficer_01_1{j in 1..5,k in 1..3}: sum{m in 1..j-1} X[3,m] + sum{m in j+2..7} X[3,m] >= min_officers;
subject to minofficer_01_2{j in 6..7,k in 1..3}: sum{m in j-5..j-1} X[3,m] >= min_officers;
subject to minofficer_04_1{j in 1..4,k in 4..7}: sum{m in j+3..7} X[1,m] + sum{m in 1..j} X[1,m] >= min_officers;
subject to minofficer_04_2{j in 5..7,k in 4..7}: sum{m in j-4..j} X[1,m] >= min_officers;
subject to minofficer_08_1{j in 1..4,k in 8..11}: sum{m in j+3..7} X[2,m] + sum{m in 1..j} X[2,m] >= min_officers;
subject to minofficer_08_2{j in 5..7,k in 8..11}: sum{m in j-4..j} X[2,m] >= min_officers;
subject to minofficer_12_1{j in 1..4,k in 12..12}: sum{m in j+3..7} X[3,m] + sum{m in 1..j} X[3,m] >= min_officers;
subject to minofficer_12_2{j in 5..7,k in 12..12}: sum{m in j-4..j} X[3,m] >= min_officers;

# Non-negative constraints
subject to positive_y: y >= 0;
subject to positive_X{i in 1..3, j in 1..7}: X[i,j] >= 0;
subject to positive_L{j in 1..7, k in 1..12}: L[j,k] >= 0;
subject to positive_S{j in 1..7, k in 1..12}: S[j,k] >= 0;