

m = load("testperson.mat").iriscode;
m_new = zeros(1, length(m));
m_mask = zeros(1, length(m));

for i = 1:length(m)
    m_new(i) = m(i);
    if m(i) == 2
        m_mask(i) = 1;
        m_new(i) = 1;
    end
end

max_overall_hd = -1;
max_person = -1;
for i = 1:20
    file = sprintf("person%02d.mat", i);
    mat = load(file).iriscode;
    hd_max_person = 0;
    for row_idx = 1:20
        row = mat(row_idx, :);
        adjusted_row = bitor(row, m_mask);

        hd = pdist2(adjusted_row, m_new);

        hd_max_person = hd_max_person + hd;
    end
    hd_max_person = hd_max_person / 20;
    fprintf("Max hd %f Person %d\n", hd_max_person, i);

    if hd_max_person > max_overall_hd
        max_person = i;
        max_overall_hd = hd_max_person;
    end
end

fprintf("Max person is %d\n", max_person);
