% Implementation of Freedman-Diaconis rule to compute bin width
function width = get_bin_width(data)
    width = 2 * iqr(data) / length(data);
end