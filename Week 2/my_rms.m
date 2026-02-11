% 3. Write a function to calculate the root mean square amplitude of an array of values.
function rms_out = my_rms(input_sig)

input_sig_squared = input_sig^2;
n = length(input_sig);
sig_summed = sum(input_sig_squared);
mean_val = sig_summed/n;
rms_out = sqrt(mean_val);