#
#
# 5/8 Model
reset;
model mod/cs1_JB_58.mod;
data mod/cs1_JB_data.dat;
option solver gurobi;
objective total_diff_and_max_shortage;
solve;
print 'Run 1: 5/8 Schedule, 6am 2pm 10pm shifts' >mod/out/58_schedule.out;
print '' >mod/out/58_schedule.out;
print 'Objectives:' >mod/out/58_schedule.out;
display total_diff, max_shortage, total_diff_and_max_shortage >mod/out/58_schedule.out;
print 'Total Officers:' >mod/out/58_schedule.out;
display sum{i in 1..3, j in 1..7} X[i,j] >mod/out/58_schedule.out;
print 'Total Officers Working (each day):' >mod/out/58_schedule.out;
display {j in 1..7, k in 1..12}(D[j,k]+L[j,k]-S[j,k]) >mod/out/58_schedule.out;
print 'Schedule:' >mod/out/58_schedule.out;
display X >mod/out/58_schedule.out;
print 'Shortages:' >mod/out/58_schedule.out;
display S >mod/out/58_schedule.out;
print 'Surpluses:' >mod/out/58_schedule.out;
display L >mod/out/58_schedule.out;
print 'Officers Needed:' >mod/out/58_schedule.out;
display D >mod/out/58_schedule.out;
close mod/out/58_schedule.out;
print 'Full Model Definition: 5/8 Schedule, 6am 2pm 10pm shifts' >mod/out/58_full_model.out;
expand >mod/out/58_full_model.out;
close mod/out/out/58_full_model.out;


# 4/10 Model
reset;
model mod/cs1_JB_410.mod;
data mod/cs1_JB_data.dat;
option solver gurobi;
objective total_diff_and_max_shortage;
solve;
print 'Run 2: 4/10 Schedule, 6am 2pm 10pm shifts' >mod/out/410_schedule.out;
print '' >mod/out/410_schedule.out;
print 'Objectives:' >mod/out/410_schedule.out;
display total_diff, max_shortage, total_diff_and_max_shortage >mod/out/410_schedule.out;
print 'Total Officers:' >mod/out/410_schedule.out;
display sum{i in 1..3, j in 1..7} X[i,j] >mod/out/410_schedule.out;
print 'Total Officers Working (each day):' >mod/out/410_schedule.out;
display {j in 1..7, k in 1..12}(D[j,k]+L[j,k]-S[j,k]) >mod/out/410_schedule.out;
print 'Schedule:' >mod/out/410_schedule.out;
display X >mod/out/410_schedule.out;
print 'Shortages:' >mod/out/410_schedule.out;
display S >mod/out/410_schedule.out;
print 'Surpluses:' >mod/out/410_schedule.out;
display L >mod/out/410_schedule.out;
print 'Officers Needed:' >mod/out/410_schedule.out;
display D >mod/out/410_schedule.out;
close mod/out/410_schedule.out;
print 'Full Model Definition: 4/10 Schedule, 6am 2pm 10pm shifts' >mod/out/410_full_model.out;
expand >mod/out/410_full_model.out;
close mod/out/410_full_model.out;

# 4/10 Model with 5 shifts
reset;
model mod/cs1_JB_410_5shift.mod;
data mod/cs1_JB_data.dat;
option solver gurobi;
objective total_diff_and_max_shortage;
solve;
print 'Run 3: 4/10 Schedule, 4am 8am 12 pm 2pm 4pm shifts' >mod/out/410_5shift_schedule.out;
print '' >mod/out/410_5shift_schedule.out;
print 'Objectives:' >mod/out/410_5shift_schedule.out;
display total_diff, max_shortage, total_diff_and_max_shortage >mod/out/410_5shift_schedule.out;
print 'Total Officers:' >mod/out/410_5shift_schedule.out;
display sum{i in 1..5, j in 1..7} X[i,j] >mod/out/410_5shift_schedule.out;
print 'Total Officers Working (each day):' >mod/out/410_5shift_schedule.out;
display {j in 1..7, k in 1..12}(D[j,k]+L[j,k]-S[j,k]) >mod/out/410_5shift_schedule.out;
print 'Schedule:' >mod/out/410_5shift_schedule.out;
display X >mod/out/410_5shift_schedule.out;
print 'Shortages:' >mod/out/410_5shift_schedule.out;
display S >mod/out/410_5shift_schedule.out;
print 'Surpluses:' >mod/out/410_5shift_schedule.out;
display L >mod/out/410_5shift_schedule.out;
print 'Officers Needed:' >mod/out/410_5shift_schedule.out;
display D >mod/out/410_5shift_schedule.out;
close mod/out/410_5shift_schedule.out;
print 'Full Model Definition: 4/10 Schedule, 4am 8am 12pm 4pm 8pm shifts' >mod/out/410_5shift_full_model.out;
expand >mod/out/410_5shift_full_model.out;
close mod/out/410_5shift_full_model.out;