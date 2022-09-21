function HD_n = HD_diff_pers()
    person_no = randi([1 20], 1, 2);
    while person_no(1) == person_no(2)
        person_no = randi([1 20], 1, 2);
    end

    if person_no(1) < 10
        filename_1 = sprintf('person%02d.mat', person_no(1));
    else
        filename_1 = sprintf('person%2d.mat', person_no(1));
    end
    
    if person_no(2) < 10
        filename_2 = sprintf('person%02d.mat', person_no(2));
    else
        filename_2 = sprintf('person%2d.mat', person_no(2));
    end

    data_1 = load(filename_1).('iriscode');
    data_2 = load(filename_2).('iriscode');

    row_no = randi([1 20], 1, 2);
    HD = sum(xor(data_1(row_no(1 ), :), data_2(row_no(2), :)));
    HD_n = HD / 30;
end