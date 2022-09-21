function HD_n = HD_same_pers()
    person_no = randi([1 20], 1, 1);

    if person_no < 10
        filename = sprintf('person%02d.mat', person_no);
    else
        filename = sprintf('person%2d.mat', person_no);
    end

    data = load(filename).('iriscode');

    row_no = randi([1 20], 1, 2);
    HD = sum(xor(data(row_no(1), :), data(row_no(2), :)));
    HD_n = HD / 30;
end