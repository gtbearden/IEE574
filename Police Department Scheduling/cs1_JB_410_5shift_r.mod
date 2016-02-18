###############################################
# Justin Bearden                              #
# IEE 574 - Summer 2012                       #
# 4/10 - 5 shifts Schedule Police Department _ new shift schedule  #
###############################################

param officers;					# Total officers in district
param min_officers;				# Minimum officers during any hour
param officers_per_car;			# Number of officers per car (per call)
param D{j in 1..7, k in 1..12};	# Officers needed on day j at 2-hour period k (from data)

# i = 1..5  = shifts
# j = 1..7  = days
# k = 1..12 = 2 hour time units

var X{i in 1..5, j in 1..7} integer;		# Officers starting on shift i on day j
var L{j in 1..7, k in 1..12} integer;		# Surplus of officers on day j at hour k
var S{j in 1..7, k in 1..12} integer;		# Shortage of officers on day j at hour k
var y integer;								# Maximum shortage or surplus

# Objective statement
minimize total_diff: sum{j in 1..7, k in 1..12} S[j,k] + sum{j in 1..7, k in 1..12} L[j,k];
minimize max_shortage: y;
minimize total_diff_and_max_shortage: (sum{j in 1..7, k in 1..12} S[j,k]) + sum{j in 1..7, k in 1..12} L[j,k] + y;

# Constraints
subject to max_y_shortage{j in 1..7, k in 1..12}: y >= S[j,k];					# y is maximum shortage over any time
subject to total_officers: sum{i in 1..5, j in 1..7} X[i,j] <= officers;	# officers starting <= total officers

# Hour 1 to 2 (Shift 1, 5)
subject to hour1to2_day1to3{j in 1..3,k in 1..2}: sum{m in j+4..7} X[1,m] + sum{m in 1..j} X[1,m] + sum{m in 1..j-1} X[5,m] + sum{m in j+3..7} X[5,m] + S[j,k] - L[j,k] = D[j,k] * officers_per_car;
subject to hour1to2_day4to4{j in 4..4,k in 1..2}: sum{m in j-3..j} X[1,m] + sum{m in 1..j-1} X[5,m] + sum{m in j+3..7} X[5,m] + S[j,k] - L[j,k] = D[j,k] * officers_per_car;
subject to hour1to2_day5to7{j in 5..7,k in 1..2}: sum{m in j-4..j-1} X[1,m] + sum{m in j-4..j-1} X[5,m] + S[j,k] - L[j,k] = D[j,k] * officers_per_car;

# Hour 3 to 4 (Shift 1, 2)
subject to hour3to4_day1to4{j in 1..4,k in 3..4}: sum{m in j+4..7} X[1,m] + sum{m in 1..j} X[1,m] + sum{m in j+4..7} X[2,m] + sum{m in 1..j} X[2,m] + S[j,k] - L[j,k] = D[j,k] * officers_per_car;
subject to hour3to4_day5to7{j in 5..7,k in 3..4}: sum{m in j-3..j} X[1,m] + sum{m in j-3..j} X[2,m] + S[j,k] - L[j,k] = D[j,k] * officers_per_car;

# Hour 5 (Shift 1, 2, 3)
subject to hour5_day1to3{j in 1..3,k in 5..5}: sum{m in j+4..7} X[1,m] + sum{m in 1..j} X[1,m] + sum{m in j+4..7} X[2,m] + sum{m in 1..j} X[2,m] + sum{m in j+4..7} X[3,m] + sum{m in 1..j} X[3,m] + S[j,k] - L[j,k] = D[j,k] * officers_per_car;
subject to hour5_day4to7{j in 4..7,k in 5..5}: sum{m in j-3..j} X[1,m] + sum{m in j-3..j} X[2,m] + sum{m in j-3..j} X[3,m] + S[j,k] - L[j,k] = D[j,k] * officers_per_car;

# Hour 6 to 7 (Shift 2, 3)
subject to hour6to7_day1to3{j in 1..3,k in 6..7}: sum{m in j+4..7} X[2,m] + sum{m in 1..j} X[2,m] + sum{m in j+4..7} X[3,m] + sum{m in 1..j} X[3,m] + S[j,k] - L[j,k] = D[j,k] * officers_per_car;
subject to hour6to7_day4to7{j in 4..7,k in 6..7}: sum{m in j-3..j} X[2,m] + sum{m in j-3..j} X[3,m] + S[j,k] - L[j,k] = D[j,k] * officers_per_car;

# Hour 8 to 9 (Shift 3, 4)
subject to hour8to9_day1to3{j in 1..3,k in 8..9}: sum{m in j+4..7} X[3,m] + sum{m in 1..j} X[3,m] + sum{m in j+4..7} X[4,m] + sum{m in 1..j} X[4,m] + S[j,k] - L[j,k] = D[j,k] * officers_per_car;
subject to hour8to9_day4to7{j in 4..7,k in 8..9}: sum{m in j-3..j} X[3,m] + sum{m in j-3..j} X[4,m] + S[j,k] - L[j,k] = D[j,k] * officers_per_car;

# Hour 10 to 12 (Shift 4, 5)
subject to hour10to12_day1to3{j in 1..3,k in 10..12}: sum{m in j+4..7} X[4,m] + sum{m in 1..j} X[4,m] + sum{m in j+4..7} X[5,m] + sum{m in 1..j} X[5,m] + S[j,k] - L[j,k] = D[j,k] * officers_per_car;
subject to hour10to12_day4to7{j in 4..7,k in 10..12}: sum{m in j-3..j} X[4,m] + sum{m in j-3..j} X[5,m] + S[j,k] - L[j,k] = D[j,k] * officers_per_car;

# Minimum Officers
subject to min_officer_01_1{j in 1..3,k in 1..1}: sum{m in j+4..7} X[1,m] + sum{m in 1..j} X[1,m] + sum{m in 1..j-1} X[5,m] + sum{m in j+3..7} X[5,m] >= min_officers;
subject to min_officer_01_2{j in 4..4,k in 1..1}: sum{m in j-3..j} X[1,m] + sum{m in 1..j-1} X[5,m] + sum{m in j+3..7} X[5,m] >= min_officers;
subject to min_officer_01_3{j in 5..7,k in 1..1}: sum{m in j-4..j-1} X[1,m] + sum{m in j-4..j-1} X[5,m] >= min_officers;
subject to min_officer_03_1{j in 1..4,k in 1..1}: sum{m in j+4..7} X[1,m] + sum{m in 1..j} X[1,m] + sum{m in j+4..7} X[2,m] + sum{m in 1..j} X[2,m] >= min_officers;
subject to min_officer_03_2{j in 5..7,k in 1..1}: sum{m in j-3..j} X[1,m] + sum{m in j-3..j} X[2,m] >= min_officers;
subject to min_officer_05_1{j in 1..4,k in 1..1}: sum{m in j+4..7} X[1,m] + sum{m in 1..j} X[1,m] + sum{m in j+4..7} X[2,m] + sum{m in 1..j} X[2,m] + sum{m in j+4..7} X[3,m] + sum{m in 1..j} X[3,m] >= min_officers;
subject to min_officer_05_2{j in 5..7,k in 1..1}: sum{m in j-3..j} X[1,m] + sum{m in j-3..j} X[2,m] + sum{m in j-3..j} X[3,m] >= min_officers;
subject to min_officer_06_1{j in 1..4,k in 1..1}: sum{m in j+4..7} X[2,m] + sum{m in 1..j} X[2,m] + sum{m in j+4..7} X[3,m] + sum{m in 1..j} X[3,m] >= min_officers;
subject to min_officer_06_2{j in 5..7,k in 1..1}: sum{m in j-3..j} X[2,m] + sum{m in j-3..j} X[3,m] >= min_officers;
subject to min_officer_08_1{j in 1..4,k in 1..1}: sum{m in j+4..7} X[3,m] + sum{m in 1..j} X[3,m] + sum{m in j+4..7} X[4,m] + sum{m in 1..j} X[4,m] >= min_officers;
subject to min_officer_08_2{j in 5..7,k in 1..1}: sum{m in j-3..j} X[3,m] + sum{m in j-3..j} X[4,m] >= min_officers;
subject to min_officer_10_1{j in 1..4,k in 1..1}: sum{m in j+4..7} X[4,m] + sum{m in 1..j} X[4,m] + sum{m in j+4..7} X[5,m] + sum{m in 1..j} X[5,m] >= min_officers;
subject to min_officer_10_2{j in 5..7,k in 1..1}: sum{m in j-3..j} X[4,m] + sum{m in j-3..j} X[5,m] >= min_officers;


# Non-negative constraints
subject to positive_y: y >= 0;
subject to positive_X{i in 1..5, j in 1..7}: X[i,j] >= 0;
subject to positive_L{j in 1..7, k in 1..12}: L[j,k] >= 0;
subject to positive_S{j in 1..7, k in 1..12}: S[j,k] >= 0;